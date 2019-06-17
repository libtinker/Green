//
//  ZJJNetwork.m
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import "ZJJNetwork.h"
#import <AFNetworking/AFNetworking.h>
#import "ZJJApiManager.h"
#import "LocalService.h"


static AFHTTPSessionManager *shareManager = nil;

@implementation ZJJNetwork

+ (AFHTTPSessionManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer* requestSerializer = [AFHTTPRequestSerializer serializer];
        requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        [requestSerializer setTimeoutInterval:60];
        [shareManager setResponseSerializer:responseSerializer];
        [shareManager setRequestSerializer:requestSerializer];
    });
    return shareManager;
}

//设置Header
+ (void)setHeader:(AFHTTPSessionManager *)manager {
    [manager.requestSerializer setValue:@"ios"forHTTPHeaderField:@"device"];
    [manager.requestSerializer setValue:[LocalService getUserId] forHTTPHeaderField:@"user_id"];
    [manager.requestSerializer setValue:@"appName" forHTTPHeaderField:@"appName"];
    [manager.requestSerializer setValue:@"app" forHTTPHeaderField:@"platform"];
    [manager.requestSerializer setValue:@"AppleStore"forHTTPHeaderField:@"appMarket"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
}

+ (void)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(Success)success
     failure:(Failure)failure {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    AFHTTPSessionManager *manager = [ZJJNetwork shareManager];
    [ZJJNetwork setHeader:manager];

    NSString *baseUrl = [ZJJApiManager shareManager].baseUrl;

    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [param addEntriesFromDictionary:@{@"apiName":URLString}];

    [manager POST:baseUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [ZJJNetwork handleData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        failure(error,nil);
    }];
}

+ (void)handleData:(id  _Nullable)responseObject success:(Success)success failure:(Failure)failure{
    NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
    NSString *code = result[@"code"];
    if (code.integerValue == 200) {
        success(result);
    }else {//这里只是简单的写一下，实际情况更复杂
        failure(nil,result);
    }
}

@end

//
//  ZJJNetwork.m
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import "ZJJNetwork.h"
#import "AFHTTPCustomRequestSerializer.h"
#import <AFNetworking/AFNetworking.h>
#import "ZJJApiManager.h"
#import "RouterManager.h"

static AFHTTPSessionManager *shareManager = nil;

NSTimeInterval const timeoutInterval = 60;


@implementation ZJJNetwork

+ (AFHTTPSessionManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [AFHTTPSessionManager manager];
//        AFHTTPCustomRequestSerializer* requestSerializer = [AFHTTPCustomRequestSerializer serializer];
        AFHTTPRequestSerializer* requestSerializer = [AFHTTPRequestSerializer serializer];
        requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        [requestSerializer setTimeoutInterval:timeoutInterval];
        [shareManager setResponseSerializer:responseSerializer];
        [shareManager setRequestSerializer:requestSerializer];
    });
    return shareManager;
}

//设置Header
+ (void)setHeader:(AFHTTPSessionManager *)manager {
    [manager.requestSerializer setValue:@"ios"forHTTPHeaderField:@"device"];
    [manager.requestSerializer setValue:[RouterManager getUserId] forHTTPHeaderField:@"user_id"];
    [manager.requestSerializer setValue:@"appName" forHTTPHeaderField:@"appName"];
    [manager.requestSerializer setValue:@"app" forHTTPHeaderField:@"platform"];
    [manager.requestSerializer setValue:@"AppleStore"forHTTPHeaderField:@"appMarket"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
}

#pragma mark - post接口请求
+ (void)POST:(NSString *)URLString
        parameters:(id)parameters
        success:(Success)success
        failure:(Failure)failure {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    AFHTTPSessionManager *manager = [ZJJNetwork shareManager];
    [ZJJNetwork setHeader:manager];

    NSString *baseUrl = [ZJJApiManager shareManager].baseUrl;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [param addEntriesFromDictionary:@{@"apiName":URLString}];

    [manager POST:baseUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [ZJJNetwork handleData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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

+ (void)download:(NSString *)URLString

        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
         success:(Success)success
         failure:(Failure)failure {
    AFHTTPSessionManager *manager = [ZJJNetwork shareManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];

    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
       if (downloadProgressBlock) {
           downloadProgressBlock(downloadProgress);
       }
        //NSLog(@"%f",1.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *fullPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error == nil) {
            success(filePath);
        }else{
            failure(error,response);
        }
    }];
    [task resume];
}

+ (void)upload:(NSString *)URLString
    parameters:(id)parameters
     FileItems:(NSArray<FileItem *> *)FileItems
      progress:(void (^)(NSProgress *downloadProgress))uploadProgressBlock
       success:(Success)success
       failure:(Failure)failure {
    AFHTTPSessionManager *manager = [ZJJNetwork shareManager];

    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [FileItems enumerateObjectsUsingBlock:^(FileItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [formData appendPartWithFileData:obj.data name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%f",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,task);
    }];
}

@end

@implementation FileItem

@end

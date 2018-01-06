//
//  ZJJHttpRequest.m
//  ZJJNetWork
//
//  Created by ZJJ on 2017/12/17.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import "ZJJHttpRequest.h"
#import "AFNetworking.h"

@implementation ZJJHttpRequest

+ (void)request:(NSString *)strUrl param:(NSDictionary *)params withSuccess:(NetResultHandler)success failed:(NetResultHandler)failed
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 设置请求接口回来的时候支持什么类型的数据
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ZJJ_URL_BASE,strUrl];
    [session POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传的进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"post请求成功%@", result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"code"] isEqualToString:@"200"]) {
                success(result);
            }else{
                failed(result);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"post请求失败:%@", error);
    }];
}
@end

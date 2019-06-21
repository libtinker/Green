//
//  ZJJNetwork.h
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef void (^Success)(id _Nullable responseObject);
typedef void (^Failure)(NSError * _Nullable error,id _Nullable responseObject);

@interface ZJJNetwork : NSObject


/**
 POST请求

 @param URLString 网址
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(Success)success
     failure:(Failure)failure;


/**
 下载文件

 @param URLString 网址
 @param downloadProgressBlock 进度条
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)download:(NSString *)URLString
        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
         success:(Success)success
         failure:(Failure)failure;


/**
 上传文件到服务器

 @param URLString 服务器网址
 @param fileURLs 本地文件路径url
 @param uploadProgressBlock 上传进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)upload:(NSString *)URLString
      fileURLs:(NSArray<NSURL *> *)fileURLs
      progress:(void (^)(NSProgress *downloadProgress))uploadProgressBlock
       success:(Success)success
       failure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END

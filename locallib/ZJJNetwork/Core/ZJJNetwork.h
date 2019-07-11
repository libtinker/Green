//
//  ZJJNetwork.h
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@class FileItem;

typedef void (^Success)(id _Nullable responseObject);
typedef void (^Failure)(NSError * _Nullable error,id _Nullable responseObject);

@interface ZJJNetwork : NSObject

/**
 POST请求

 @param URLString 网址
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @return 任务对象
 */
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(Success)success
                       failure:(Failure)failure;

/**
 下载文件

 @param URLString 网址
 @param downloadProgressBlock 进度条
 @param success 成功回调
 @param failure 失败回调
 @return 任务对象
 */
- (NSURLSessionDownloadTask *)download:(NSString *)URLString

                              progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                               success:(Success)success
                               failure:(Failure)failure;

/**
 上传文件到服务器

 @param URLString 服务器网址
 @param parameters 参数
 @param FileItems 文件模型
 @param uploadProgressBlock 上传进度
 @param success 成功回调
 @param failure 失败回调
 @return 任务对象
 */
- (NSURLSessionDataTask *)upload:(NSString *)URLString
                      parameters:(id)parameters
                       FileItems:(NSArray<FileItem *> *)FileItems
                        progress:(void (^)(NSProgress *downloadProgress))uploadProgressBlock
                         success:(Success)success
                         failure:(Failure)failure;
@end

@interface FileItem : NSObject

/**
 文件二进制数据
 */
@property (nonatomic,strong) NSData *data;

/**
 名字（一般默认都写成file）
 */
@property (nonatomic,strong) NSString *name;

/**
 文件名字
 */
@property (nonatomic,strong) NSString *fileName;

/**
 文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic,strong) NSString *mimeType;

@end
NS_ASSUME_NONNULL_END

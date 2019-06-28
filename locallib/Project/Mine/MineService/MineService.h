//
//  MineService.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineService : NSObject

/**
 通过协议进行操作

 @param path 路径
 @param data 参数
 @return 是否处理成功
 */
+ (BOOL)openPath:(NSString *)path data:(NSDictionary<NSString *, id> *)data;

/**
 获取用户id用于网络请求

 @return 用户id
 */
+ (NSString *)getUserId;

/**
 是否是登录状态

 @return 结果
 */
+ (BOOL)isLogin;
@end

NS_ASSUME_NONNULL_END

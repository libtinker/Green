//
//  LocalService.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalService : NSObject

/**
 通过协议进行操作

 @param url 网址协议
 @param options 参数
 @return 操作是否成功
 */
+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options;

/**
获取用户id

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

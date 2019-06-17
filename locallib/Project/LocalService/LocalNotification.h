//
//  LocalNotification.h
//  Project
//
//  Created by 天空吸引我 on 2019/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
extern NSNotificationName const UserDidLoginNotification;//登录的通知

@interface LocalNotification : NSObject

/**
 添加通知

 @param name 通知名字
 @param block 回调
 */
+ (void)addObserverForName:(nullable NSNotificationName)name UsingBlock:(void (^)(NSNotification *note))block;

/**
 发送通知

 @param name 通知名字
 @param userInfo 参数信息
 */
+ (void)postNotificationName:(nullable NSNotificationName)name userInfo:(NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END

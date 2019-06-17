//
//  LocalNotification.m
//  Project
//
//  Created by 天空吸引我 on 2019/6/17.
//

#import "LocalNotification.h"

NSNotificationName const UserDidLoginNotification = @"UserDidLoginNotification";

@implementation LocalNotification
+ (void)addObserverForName:(nullable NSNotificationName)name UsingBlock:(void (^)(NSNotification *note))block {
    [[NSNotificationCenter defaultCenter] addObserverForName:name object:self queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        block(note);
    }];
}

+ (void)postNotificationName:(nullable NSNotificationName)name userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:userInfo];
}
@end

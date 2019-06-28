//
//  NSObject+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/21.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JJAdd)

/**
 交换实例方法

 @param originalSelector 原来的方法
 @param swizzledSelector 新添加的方法
 */
+ (void)swizzleInstanceMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 交换类方法

 @param originalSelector 原来的方法
 @param swizzledSelector 现有的方法
 */
+ (void)swizzleClassMethod:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 当前的控制器

 @return 控制器
 */
- (UIViewController *)currentViewController;

/**
 window当前的跟控制器

 @return 控制器
 */
- (UIViewController *)rootViewController;
@end

NS_ASSUME_NONNULL_END

//
//  UIColor+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/18.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JJAdd)

/**
 设置颜色

 @param color 16进制字符串
 @param alpha 透明度
 @return UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 设置颜色（透明度为1.0）

 @param color 颜色值
 @return UIColor对象
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END

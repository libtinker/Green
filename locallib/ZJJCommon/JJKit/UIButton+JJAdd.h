//
//  UIButton+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/18.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JJAdd)

/**
 快速初始化UIButton(不含有图片的)

 @param frame frame
 @param title 标题
 @param titleColor 标题颜色
 @param font 字体
 @param target target
 @param action 事件
 @return UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect )frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;
/**
 快速初始化UIButton

 @param frame frame
 @param title 文字
 @param titleColor 文字颜色
 @param font 字体
 @param image 背景图片
 @param target target
 @param action 点击事件
 @return UIButoon
 */
+ (UIButton *)buttonWithFrame:(CGRect )frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundImage:(nullable UIImage *)image target:(id)target action:(SEL)action;

/**
 快速初始化（图片）

 @param frame frame
 @param image 图片资源
 @param target target
 @param action 事件
 @return UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect )frame image:(UIImage *)image target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END

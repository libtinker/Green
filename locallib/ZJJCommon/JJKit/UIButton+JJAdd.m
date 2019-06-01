//
//  UIButton+JJAdd.m
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/18.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import "UIButton+JJAdd.h"

@implementation UIButton (JJAdd)

+ (UIButton *)buttonWithFrame:(CGRect )frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect )frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundImage:(nullable UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithFrame:CGRectZero title:title titleColor:titleColor font:font target:target action:action];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect )frame image:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end

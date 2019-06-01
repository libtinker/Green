//
//  UILabel+JJAdd.m
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/18.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import "UILabel+JJAdd.h"

@implementation UILabel (JJAdd)

+ (UILabel *)labelWithFrame:(CGRect )frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}

@end

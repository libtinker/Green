//
//  NSAttributedString+JJAdd.m
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/19.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import "NSAttributedString+JJAdd.h"

@implementation NSAttributedString (JJAdd)

@end

@implementation NSMutableAttributedString (JJAdd)

- (void)setFont:(UIFont *)font range:(NSRange )range {
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)setColor:(UIColor *)color range:(NSRange )range {
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle range:(NSRange )range {
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

- (void)setUnderlineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange )range{
    [self addAttribute:NSUnderlineStyleAttributeName value:@(underlineStyle) range:range];
}

- (void)setUnderlineColor:(UIColor *)clolor range:(NSRange )range{
    [self addAttribute:NSUnderlineColorAttributeName value:clolor range:range];
}

@end

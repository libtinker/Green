//
//  NSAttributedString+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/19.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (JJAdd)

@end

@interface NSMutableAttributedString (JJAdd)

/**
 设置字体

 @param font 字体
 @param range 位置范围
 */
- (void)setFont:(UIFont *)font range:(NSRange )range;

/**
 设置颜色

 @param color 颜色值
 @param range 位置范围
 */
- (void)setColor:(UIColor *)color range:(NSRange )range;

/**
 设置段落样式(行间距、字间距、对齐方式 …… )

 @param paragraphStyle NSMutableParagraphStyle对象
 @param range 位置范围
 */
- (void)setParagraphStyle:(NSMutableParagraphStyle *)paragraphStyle range:(NSRange )range;

/**
 设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似

 @param underlineStyle 下划线样式
 @param range 位置范围
 */
- (void)setUnderlineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange )range;

/**
 设置下划线颜色

 @param clolor 颜色
 @param range 位置范围
 */
- (void)setUnderlineColor:(UIColor *)clolor range:(NSRange )range;
@end

NS_ASSUME_NONNULL_END

//
//  UILabel+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/18.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (JJAdd)

/**
 label的快速初始化方法

 @param frame frame
 @param text 文字内容
 @param textColor 文字颜色
 @param font 字体
 @return UIlabel对象
 */
+ (UILabel *)labelWithFrame:(CGRect )frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END

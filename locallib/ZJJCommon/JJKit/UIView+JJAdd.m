//
//  UIView+JJAdd.m
//  ZJJCommon
//
//  Created by 天空吸引我 on 2019/6/26.
//

#import "UIView+JJAdd.h"

@implementation UIView (JJAdd)
/**
 切部分圆角
 @param cornerRadius 圆角半径
 */
- (void)setPartRoundWithCorners:(UIRectCorner)corners cornerRadius:(float)cornerRadius {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)].CGPath;
    self.layer.mask = shapeLayer;
}
@end

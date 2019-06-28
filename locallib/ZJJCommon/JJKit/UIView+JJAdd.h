//
//  UIView+JJAdd.h
//  ZJJCommon
//
//  Created by 天空吸引我 on 2019/6/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JJAdd)
/**
 切部分圆角

 UIRectCorner有五种
 UIRectCornerTopLeft //上左
 UIRectCornerTopRight //上右
 UIRectCornerBottomLeft // 下左
 UIRectCornerBottomRight // 下右
 UIRectCornerAllCorners // 全部

 @param cornerRadius 圆角半径
 */
- (void)setPartRoundWithCorners:(UIRectCorner)corners cornerRadius:(float)cornerRadius;
@end

NS_ASSUME_NONNULL_END

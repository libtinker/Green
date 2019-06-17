//
//  BaseViewController.h
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController


/**
 设置左边的返回按钮

 @param title 标题
 @param action 事件
 */
- (void)setLeftBarButtonItemWithTitle:(NSString *)title action:(nullable SEL)action;

/**
 设置右边的d按钮

 @param title 按钮标题
 @param action 事件
 */
- (void)setRightBarButtonItemWithTitle:(NSString *)title action:(nullable SEL)action;
@end

NS_ASSUME_NONNULL_END

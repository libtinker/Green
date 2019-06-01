//
//  WithrawAlertController.h
//  ZhongWangLiCai
//
//  Created by 天空吸引我 on 2018/12/17.
//  Copyright © 2018年 hc-ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^JJAlertActionBlock)(id result);

@interface JJAlertAction : NSObject

@property (nonatomic,strong) UIColor *color;//颜色
@property (nonatomic,strong) UIFont *font;//字体

/**
 获取一个action对象

 @param title 标题
 @param handler 回调
 @return action对象
 */
+ (instancetype)actionWithTitle:(nonnull NSString *)title  handler:(JJAlertActionBlock)handler;

@end

@interface JJAlertController : UIViewController

@property (nonatomic,strong,readwrite) UILabel *titleLabel;
@property (nonatomic,strong,readwrite) UILabel *messageLabel;

//添加取消、确定等按钮
- (void)addAction:(JJAlertAction *)action;

/**
 JJ弹窗（类似于UIAlertController）

 @param title 标题
 @param message 信息
 @return 弹窗控制器
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nonnull NSString *)message;

/**
 自定义弹窗

 @param customerView 自定义的视图
 @return 弹窗控制器
 */
+ (instancetype)alertControllerWithCustomerView:(UIView *)customerView;

/**
 JJ弹窗（类似于UIAlertController,不需要在外面present，可以在UIView、NSObject中使用）

 @param title 标题
 @param message 消息
 @param actionNames 事件名称数组
 @param handle 回调
 @return d弹窗控制器
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nonnull NSString *)message actionNames:(NSArray<NSString *> *)actionNames handle:(JJAlertActionBlock)handle;
@end

NS_ASSUME_NONNULL_END

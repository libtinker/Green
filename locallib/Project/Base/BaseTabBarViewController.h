//
//  BaseTabBarViewController.h
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarViewController : UITabBarController


/**
 添加控制器

 @param childVc 控制器
 @param title 标题
 @param imageName 图片
 @param seletedImageName 选中图片名字
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)seletedImageName;
@end

NS_ASSUME_NONNULL_END

//
//  BaseViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

+ (void)initialize {
    // 设置导航items数据主题
    [self setupNavigationItemsTheme];

    // 设置导航栏主题
    [self setupNavigationBarTheme];
}


#pragma mark -  设置导航items数据主题
+ (void)setupNavigationItemsTheme {
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    // 设置字体颜色
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateHighlighted];
    [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateDisabled];

}

#pragma mark -  设置导航栏主题
+ (void)setupNavigationBarTheme {
    UINavigationBar * navBar = [UINavigationBar appearance];

    // 设置导航栏title属性
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    // 设置导航栏颜色
    [navBar setBarTintColor:[UIColor whiteColor]];

    UIImage *image = [UIImage imageNamed:@"nav_64"];

    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

}


#pragma mark -  拦截所有push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        // 如果navigationController的字控制器个数大于两个就隐藏
        viewController.hidesBottomBarWhenPushed = YES;

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark -  拦截所有pop方法
- (void)back {
    [super popViewControllerAnimated:YES];
    //这里就可以自行修改返回按钮的各种属性等
}


@end

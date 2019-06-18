//
//  BaseTabBarViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "MineViewController.h"
#import "HomeViewController.h"
#import "HotViewController.h"
#import "UIColor+JJAdd.h"
#import "LocalService.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

+ (void)initialize {

    // 设置UITabBarItem主题
    [self setupTabBarItemTheme];

    // 设置UITabBar主题
    [self setupTabBarTheme];
}

+ (void)setupTabBarItemTheme {
    UITabBarItem *tabBarItem = [UITabBarItem appearance];

    /**设置文字属性**/
    // 普通状态
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];

    // 选中状态
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18.0f],NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];

//    tabBarItem.imageInsets = UIEdgeInsetsMake(0, -10, -6, -10);

    // 高亮状态
    //    [tabBarItem setTitleTextAttributes:@{} forState:UIControlStateHighlighted];

    // 不可用状态(disable)
    //    [tabBarItem setTitleTextAttributes:@{} forState:UIControlStateDisabled];
}

+ (void)setupTabBarTheme {
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.backgroundColor = [UIColor blackColor];
    [tabBar setBackgroundImage:[UIImage new] ];
    [tabBar setShadowImage:UIColor.lightTextColor.image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    HomeViewController *homeCtrl = [[HomeViewController alloc] init];
    [self addChildVc:homeCtrl title:@"首页" imageName:@"tabbar_seleted" selectedImageName:@"tabbar_seleted"];

    HotViewController *hotCtrl = [[HotViewController alloc] init];
    [self addChildVc:hotCtrl title:@"关注" imageName:@"tabbar_seleted" selectedImageName:@"tabbar_seleted"];

    MineViewController *mineCtrl = [[MineViewController alloc] init];
    [self addChildVc:mineCtrl title:@"我的" imageName:@"tabbar_seleted" selectedImageName:@"tabbar_seleted"];

}

#pragma mark - 添加一个子控制器
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)seletedImageName {

    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //文字位置
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -15)];
    //图片位置
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(45, 2, 2, 2);

    BaseNavigationViewController  *nc = [[BaseNavigationViewController alloc] initWithRootViewController:childVc];
    nc.title = title;
    [self addChildViewController:nc];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"tabBarController.selectedIndex:%d",tabBarController.selectedIndex);
    if ([LocalService isLogin]==NO) {
        tabBarController.selectedIndex = 0;
        NSURL *url = [NSURL URLWithString:@"Green://mine/login"];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {}];
    }
}
@end

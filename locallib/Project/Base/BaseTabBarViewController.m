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

@interface BaseTabBarViewController ()

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
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f], NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];

    // 选中状态
    [tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0f],NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];

    // 高亮状态
    //    [tabBarItem setTitleTextAttributes:@{} forState:UIControlStateHighlighted];

    // 不可用状态(disable)
    //    [tabBarItem setTitleTextAttributes:@{} forState:UIControlStateDisabled];
}

+ (void)setupTabBarTheme {
    //    UITabBar *tabBar = [UITabBar appearance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *homeCtrl = [[HomeViewController alloc] init];
    [self addChildVc:homeCtrl title:@"首页" imageName:[UIImage imageNamed:@"full_exit"] selectedImageName:nil];

    MineViewController *mineCtrl = [[MineViewController alloc] init];
    [self addChildVc:mineCtrl title:@"我的" imageName:nil selectedImageName:nil];

}

#pragma mark - 添加一个子控制器
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)seletedImageName {

    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, [UIFont fontWithName:title size:12.0f],NSFontAttributeName,nil] forState:UIControlStateNormal];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor], NSForegroundColorAttributeName, [UIFont fontWithName:title size:12.0f],NSFontAttributeName,nil] forState:UIControlStateSelected];

    BaseNavigationViewController  *nc = [[BaseNavigationViewController alloc] initWithRootViewController:childVc];
    nc.title = title;
    [self addChildViewController:nc];
}

@end

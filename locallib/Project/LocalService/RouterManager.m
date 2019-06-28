//
//  LocalService.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "RouterManager.h"
#import "MineService.h"
#import "ZJJPhotoService.h"
#import "NSURL+JJAdd.h"
#import "BaseTabBarViewController.h"

@implementation RouterManager

+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    if ([url.host isEqualToString:@"tabbar"]) {
        return [BaseTabBarViewController openPath:url.path data:url.parameterDictionary];
    }else if ([url.host isEqualToString:@"mine"]) {
       return [MineService openPath:url.path data:url.parameterDictionary];
    }else if ([url.host isEqualToString:@"photo"]){
        return [ZJJPhotoService openPath:url.path data:url.parameterDictionary];
    }
    return NO;
}

+ (UIWindow *)didFinishLaunching {
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [window makeKeyAndVisible];
    window.backgroundColor = UIColor.whiteColor;
    BaseTabBarViewController *tabbar = [[BaseTabBarViewController alloc] init];
    window.rootViewController = tabbar;

    [self setupAppearance];
    return window;
}

//设置外观
+ (void)setupAppearance{
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
    }
}

+ (NSString *)getUserId {
    return [MineService getUserId];
}

+ (BOOL)isLogin {
    return [MineService isLogin];
}
@end

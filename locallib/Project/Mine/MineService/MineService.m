//
//  MineService.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "MineService.h"
#import "LoginViewController.h"
#import "NSObject+JJAdd.h"

@implementation MineService
+ (BOOL)openPath:(NSString *)path options:(NSDictionary<NSString *, id> *)options {
    if ([path isEqualToString:@"login"]) {
       return [self presentLoginVC];
    }
    return NO;
}

+ (BOOL)presentLoginVC {
    LoginViewController *ctrl = [[LoginViewController alloc] init];
    ctrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    if (@available(iOS 8.0, *)) {
        ctrl.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    [[self currentViewController] presentViewController:ctrl animated:YES completion:nil];
    return YES;
}
@end

//
//  LoginModel.m
//  Project
//
//  Created by 天空吸引我 on 2019/6/17.
//

#import "LoginModel.h"
#import "JJAlertController.h"

@implementation LoginModel

+ (BOOL)isLegalWithUsername:(NSString *)username password:(NSString *)password {
    if (username.length!=11||password.length<6||password.length>20) {
        [JJAlertController alertControllerWithTitle:nil message:@"账号或密码错误" actionNames:@[@"确定"] handle:^(id  _Nonnull result) {
            
        }];
        return NO;
    }
    return YES;
}

+ (void)saveUserId:(NSString *)userId {
    if (userId) {
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"user_id"];
    }
}

+ (NSString *)getUserId {
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    return userId?userId:@"";
}
@end

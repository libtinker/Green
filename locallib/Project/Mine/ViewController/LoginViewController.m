//
//  LoginViewController.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginModel.h"
#import "LoginView.h"
#import "ZJJNetwork.h"
#import "JJKit.h"
#import "LocalNotification.h"

@interface LoginViewController ()

@property (nonatomic,strong) LoginView *loginView;
@end

@implementation LoginViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.loginView];
    [self setRightBarButtonItemWithTitle:@"注册" action:@selector(rightBarButtonItemClicked)];
    [self setLeftBarButtonItemWithTitle:@"返回" action:@selector(backClicked)];
}

#pragma mark - HTTP
- (void)loginRequest:(NSString *)userName password:(NSString *)password {
    __weak LoginViewController *weakSelf = self;
    NSDictionary *parm = @{
                           @"username":userName,
                           @"password":password
                           };
    [ZJJNetwork POST:@"login" parameters:parm success:^(id  _Nullable responseObject) {
        NSDictionary *data = responseObject[@"data"];
        [LoginModel saveUserId:data[@"user_id"]];
        [LocalNotification postNotificationName:UserDidLoginNotification userInfo:nil];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {
        [JJAlertController alertControllerWithTitle:nil message:responseObject[@"msg"] actionNames:@[@"确定"] handle:nil];
    }];
}
#pragma mark - Delegate

#pragma mark - Public
- (void)rightBarButtonItemClicked {
    RegisterViewController *ctrl = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)backClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
        __weak LoginViewController *weakSelf = self;
        _loginView.loginBlock = ^(NSString * _Nonnull userName, NSString * _Nonnull password) {
            if ([LoginModel isLegalWithUsername:userName password:password]) {
                [weakSelf loginRequest:userName password:password];
            }
        };
    }
    return _loginView;
}
@end

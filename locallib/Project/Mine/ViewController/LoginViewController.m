//
//  LoginViewController.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "ZJJNetwork.h"
#import "JJKit.h"

@interface LoginViewController ()

@property (nonatomic,strong) LoginView *loginView;
@end

@implementation LoginViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.78];
    [self.view addSubview:self.loginView];
    // Do any additional setup after loading the view.
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
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError * _Nullable error, id  _Nullable responseObject) {
    }];
}
#pragma mark - Delegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:self.view.frame];
        __weak LoginViewController *weakSelf = self;
        _loginView.loginBlock = ^(NSString * _Nonnull userName, NSString * _Nonnull password) {
            if (userName.isNumber&&password.length>6) {
                [weakSelf loginRequest:userName password:password];
            }else{
                [JJAlertController alertControllerWithTitle:nil message:@"账号或密码错误  " actionNames:@[@"确定"] handle:^(id  _Nonnull result) {

                }];
            }
        };
    }
    return _loginView;
}
@end

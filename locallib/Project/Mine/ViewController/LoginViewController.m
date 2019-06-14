//
//  LoginViewController.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()

@property (nonatomic,strong) LoginView *loginView;
@end

@implementation LoginViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.48];
    [self.view addSubview:self.loginView];
    // Do any additional setup after loading the view.
}

#pragma mark - HTTP

#pragma mark - Delegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter

- (LoginView *)loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    }
    return _loginView;
}
@end

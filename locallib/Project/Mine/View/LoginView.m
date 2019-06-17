//
//  LoginView.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "LoginView.h"
#import "JJKit.h"

@interface LoginView ()//<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;
@property (nonatomic,strong) UIButton *loginBtn;
@end

@implementation LoginView
#pragma mark - Initial Methods

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

/**视图初始化*/
- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.userNameTF];
    [self addSubview:self.passwordTF];
    [self addSubview:self.loginBtn];
}

#pragma mark - Delegate
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
#pragma mark - Public

#pragma mark - Private
- (void)loginClicked {
    [self endEditing:YES];
    if (_loginBlock) {
        _loginBlock(_userNameTF.text,_passwordTF.text);
    }
}
#pragma mark - Setter

#pragma mark - Getter

- (UITextField *)userNameTF {
    if (!_userNameTF) {
        _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 44)];
        _userNameTF.placeholder = @"请输入电话号码";
        _userNameTF.keyboardType = UIKeyboardTypeNumberPad;
        _userNameTF.backgroundColor = UIColor.whiteColor;
    }
    return _userNameTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, [UIScreen mainScreen].bounds.size.width - 40, 44)];
        _passwordTF.placeholder = @"请输入密码";
        _passwordTF.backgroundColor = [UIColor whiteColor];
    }
    return _passwordTF;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithFrame:CGRectMake(20, 240, [UIScreen mainScreen].bounds.size.width - 40, 44) title:@"登录" titleColor:UIColor.whiteColor font:[UIFont systemFontOfSize:16] target:self action:@selector(loginClicked)];
        _loginBtn.backgroundColor = [UIColor orangeColor];
    }
    return _loginBtn;
}

@end

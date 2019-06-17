//
//  WithrawAlertController.m
//  ZhongWangLiCai
//
//  Created by 天空吸引我 on 2018/12/17.
//  Copyright © 2018年 hc-ios. All rights reserved.
//

#import "JJAlertController.h"
#import "UILabel+JJAdd.h"
#import "UIButton+JJAdd.h"
#import "NSAttributedString+JJAdd.h"
#import "CALayer+JJAdd.h"
#import "NSString+JJAdd.h"
#import "NSObject+JJAdd.h"

@interface JJAlertAction ()

@property (nonatomic,strong) JJAlertActionBlock handler;
@property (nonatomic,copy) NSString *title;

@end

@implementation JJAlertAction

+ (instancetype)actionWithTitle:(nonnull NSString *)title  handler:(JJAlertActionBlock)handler {
    JJAlertAction *action = [[JJAlertAction alloc] init];
    action.handler = handler;
    action.title = title;
    action.color = [UIColor blackColor];
    action.font = [UIFont systemFontOfSize:16.0];
    return action;
}
@end

@interface  JJAlertController ()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *customerView;

@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) NSString *messageString;

@property (nonatomic,strong) NSMutableArray<JJAlertAction *> *actions;
@end

@implementation JJAlertController

- (instancetype)init {
    if (self = [super init]) {
        _actions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.48];
    if (self.customerView) {
        [self.view addSubview:_customerView];
        _customerView.center = self.view.center;
    } else {
        [self.view addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.messageLabel];
        [self createActionButton];
    }
}

#pragma mark ------- getter ------

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.cornerRadius = 6.0f;
        _contentView.layer.w = [UIScreen mainScreen].bounds.size.width - 60;
        CGFloat h = self.messageLabel.layer.y + self.messageLabel.layer.h + 34;
        _contentView.layer.h = _actions.count==1||_actions.count==2?h+48:h+_actions.count*48;
        _contentView.center = self.view.center;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFrame:CGRectZero text:_titleString textColor:[UIColor colorWithRed:63/255.0 green:67/255.0 blue:70/255.0 alpha:1.0] font:[UIFont boldSystemFontOfSize:18]];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.y = 24;
        _titleLabel.layer.x = 30;
        _titleLabel.layer.w = [UIScreen mainScreen].bounds.size.width-120;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.numberOfLines = 0;
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:_messageString];
        NSRange range = NSMakeRange(0, _messageString.length);
        [attStr setFont:[UIFont systemFontOfSize:14] range:range];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 10.0f;
        paraStyle.alignment = NSTextAlignmentCenter;
        [attStr setParagraphStyle:paraStyle range:range];
        _messageLabel.attributedText = attStr;

        _messageLabel.layer.y = self.titleLabel.layer.y + self.titleLabel.layer.h +20;
        _messageLabel.layer.w = self.contentView.layer.w - 40;
        _messageLabel.layer.x = 20;
        _messageLabel.layer.h = [_messageString getHeightWithFont:_messageLabel.font width:_messageLabel.layer.w lineSpacing:10.0];
    }
    return _messageLabel;
}

#pragma mark ---------setter------------

- (void)setMessageString:(NSString *)messageString {
    if (messageString == nil) {
        _messageString = @"";
    }else{
        _messageString = messageString;
    }
}

- (void)createActionButton {
    for (int i=0; i<_actions.count; i++) {
        UIButton *btn = [self createBtnWithAction:_actions[i]];
        btn.tag = i;
        UIView *lineView = [self createLineView];
        [btn addSubview:lineView];
        
        lineView.layer.w = btn.layer.w = _actions.count == 2 ? ([UIScreen mainScreen].bounds.size.width-60)/2:([UIScreen mainScreen].bounds.size.width-60);
        btn.layer.x = _actions.count == 2 ? btn.layer.w*i:0;
        btn.layer.y = _actions.count == 2 ? 34 + self.messageLabel.layer.y + self.messageLabel.layer.h:34+48*i + self.messageLabel.layer.y + self.messageLabel.layer.h;
        btn.layer.h = 48;
        lineView.layer.y = lineView.layer.x = 0;
        lineView.layer.h = 1;
    }
    
    if (_actions.count == 2) {
        UIView *lineView = [self createLineView];
        [_contentView addSubview:lineView];
        lineView.layer.centerX = self.messageLabel.layer.centerX;
        lineView.layer.size = CGSizeMake(1, 48);
        lineView.layer.y = 34 + self.messageLabel.layer.y + self.messageLabel.layer.h;
    }
}

- (UIView *)createLineView {
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:236/255.0 blue:241/255.0 alpha:1.0];
    return lineView;
}

- (UIButton *)createBtnWithAction:(JJAlertAction *)action {
    UIButton *btn = [UIButton buttonWithFrame:CGRectZero title:action.title titleColor:action.color font:action.font backgroundImage:nil target:self action:@selector(buttonClicked:)];
    [_contentView addSubview:btn];
    return btn;
}

- (void)addAction:(JJAlertAction *)action {
    [_actions addObject:action];
}

- (void)buttonClicked:(UIButton *)button {
    NSInteger tag = button.tag;
    JJAlertAction *action = _actions[tag];
    [self dismissViewControllerAnimated:YES completion:^{
        if (action.handler) action.handler([NSNumber numberWithInteger:tag]);
    }];
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nonnull NSString *)message {
    JJAlertController *ctrl = [[JJAlertController alloc] init];
    ctrl.titleString = title;
    ctrl.messageString = message;
    ctrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    ctrl.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return ctrl;
}

+ (instancetype)alertControllerWithCustomerView:(UIView *)customerView {
    JJAlertController *ctrl = [[JJAlertController alloc] init];
    ctrl.customerView = customerView;
    ctrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    ctrl.modalPresentationStyle = UIModalPresentationOverFullScreen;
    return ctrl;
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nonnull NSString *)message actionNames:(NSArray<NSString *> *)actionNames handle:(JJAlertActionBlock)handle {
    JJAlertController *ctrl = [self alertControllerWithTitle:title message:message];
    for (int i = 0; i <actionNames.count; i ++) {
        JJAlertAction *action = [JJAlertAction actionWithTitle:actionNames[i] handler:handle];
        action.color = actionNames.count == 2 && i == 0 ? [UIColor redColor] : [UIColor blackColor];
        [ctrl addAction:action];
    }
    [self.currentViewController presentViewController:ctrl animated:YES completion:nil];
    return ctrl;
}

@end

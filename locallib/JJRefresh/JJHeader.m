//
//  JJHeader.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/6.
//

#import "JJHeader.h"


@interface JJHeader()
@property(nonatomic, strong) UIImageView *arrowView;
@property(nonatomic, strong) UILabel *stateLabel;
@property(nonatomic, strong) UIActivityIndicatorView *loadingView;
@end

@implementation JJHeader

- (void)prepare {
    [super prepare];
    _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshpull"]];
    _arrowView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_arrowView];

    _stateLabel = [[UILabel alloc] init];
    if (@available(iOS 8.2, *)) {
        _stateLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    } else {
        // Fallback on earlier versions
    }
    _stateLabel.textColor = [UIColor whiteColor];
    [self addSubview:_stateLabel];

    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:_loadingView];
    self.stateLabel.text = @"下拉刷新";
    __weak typeof(self) weakself = self;
    self.endRefreshingCompletionBlock = ^{
        weakself.stateLabel.text = @"下拉刷新";
        [weakself placeSubviews];
    };
}


//设置尺寸
- (void)placeSubviews {
    [super placeSubviews];
    [self.stateLabel sizeToFit];
    CGRect frame = self.stateLabel.frame;
    self.stateLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-frame.size.width/2, (self.frame.size.height-frame.size.height)/2, frame.size.width, frame.size.height);
    self.arrowView.frame = CGRectMake(_stateLabel.frame.origin.x - 6 -17, (self.frame.size.height-17)/2, 17, 17);
    self.loadingView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-10, self.frame.size.height/2-10, 20, 20);
}


- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        self.stateLabel.text = @"下拉刷新";
        if (oldState == MJRefreshStateRefreshing) {
            self.stateLabel.text = @"";
            self.arrowView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
                self.stateLabel.text = @"下拉刷新";
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            self.stateLabel.text = @"下拉刷新";
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        self.stateLabel.text = @"松开刷新";
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.stateLabel.text = @"";
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}


@end

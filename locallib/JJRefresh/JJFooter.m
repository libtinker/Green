//
//  JJFooter.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/6.
//

#import "JJFooter.h"

@interface JJFooter()
@property(nonatomic, strong) UIImageView *arrowView;
@property(nonatomic, strong) UILabel     *stateLabel;
@end

@implementation JJFooter
//初始化子空间
- (void)prepare {
    [super prepare];
    self.stateLabel = [[UILabel alloc]init];
    self.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    self.stateLabel.textColor = [UIColor colorWithRed:148/255.0 green:150/255.0 blue:163/255.0 alpha:1];
    [self addSubview:self.stateLabel];
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshmore"]];
    _arrowView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_arrowView];
}

//设置尺寸
- (void)placeSubviews {
    [super placeSubviews];
    [self.stateLabel sizeToFit];
    CGRect frame = self.stateLabel.frame;
    self.stateLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-frame.size.width/2, (self.frame.size.height-frame.size.height)/2, frame.size.width, frame.size.height);
    self.arrowView.frame = CGRectMake(_stateLabel.frame.origin.x - 6 -17, (self.frame.size.height-17)/2, 17, 17);
}

//监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

// 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

// 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}

// 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateRefreshing:
            self.arrowView.hidden = YES;
            self.stateLabel.text = @"拼命获取中...";
            break;
        case MJRefreshStateNoMoreData:
            self.arrowView.hidden = YES;
            self.stateLabel.text = @"已没有更多数据";
            break;
        default:
            self.arrowView.hidden = NO;
            self.stateLabel.text = @"上拉获取更多";
            break;
    }
}

// 监听拖拽比例
- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
}

- (void)endRefreshing {
    if (self.state == MJRefreshStateNoMoreData) {
        return;
    }
    self.state = MJRefreshStateIdle;
}
@end

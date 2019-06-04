//
//  VideoView.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/1.
//

#import "VideoView.h"
#import "JJAlertController.h"
#import <AVFoundation/AVFoundation.h>

API_AVAILABLE(ios(10.0))
@interface VideoView ()
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
//@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）

@property (strong, nonatomic)UISlider *avSlider;//用来现实视频的播放进度，并且通过它来控制视频的快进快退。
@property (assign, nonatomic)BOOL isReadToPlay;//用来判断当前视频是否准备好播放。

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,assign) AVPlayerTimeControlStatus playStatus;//播放状态
@end

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {


    }
    return self;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.bounds =  CGRectMake(0, 0, 59, 57);
        _button.center = self.center;
        UIImage *image = [UIImage imageNamed:@"video.bundle/icon_play_pause"];
        [_button setImage:image forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)playWithUrlString:(NSString *)urlString {
    self.myPlayer = nil;
    NSURL *mediaURL = nil;
    if ([urlString containsString:@"http://"]) {
        mediaURL = [NSURL URLWithString:urlString];
    }else{
        mediaURL = [NSURL fileURLWithPath:urlString];
    }
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:mediaURL];
    self.myPlayer = [AVPlayer playerWithPlayerItem:item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];

    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法

    self.playerLayer.frame = self.frame;
    [self.layer addSublayer:self.playerLayer];
    [self addSubview:self.button];

    // 时间监听
    //        [self.myPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
    //            AVPlayerItem *item = self.item;
    //            NSInteger currentTime = item.currentTime.value/item.currentTime.timescale;
    //            NSLog(@"当前播放时间:%ld",currentTime);
    //            self.avSlider.value = currentTime;
    //        }];

    [self addObserver];
}

- (void)addObserver {
    //监听 timeControlStatus
    [self.myPlayer addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew context:nil];

    //通过KVO来观察status属性的变化，来获得播放之前的错误信息
    [self.myPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    //视频播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerMovieFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.myPlayer currentItem]];
}

- (void)removeObserver {
    [self.myPlayer removeObserver:self forKeyPath:@"timeControlStatus" context:nil];
    [self.myPlayer.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.myPlayer currentItem]];
}
//播放完成
- (void)playerMovieFinish {
    [self.myPlayer.currentItem seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        if (finished) {
            [self.myPlayer play];
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                [self alert:@"item 有误"];
                self.isReadToPlay = NO;
                _button.hidden = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                self.isReadToPlay = YES;
                [self.myPlayer play];
                _button.hidden = YES;
//                self.avSlider.maximumValue = self.item.duration.value / self.item.duration.timescale;
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                [self alert:@"视频资源出现未知错误"];
                self.isReadToPlay = NO;
                _button.hidden = NO;
                break;
            default:
                break;
        }
    }
    
    //移除监听（观察者）
    //    [object removeObserver:self forKeyPath:@"status"];
    
    if (object == self.myPlayer && [keyPath isEqualToString:@"timeControlStatus"]) {
        
        if (@available(iOS 10.0, *)) {
            _playStatus = [[change objectForKey:NSKeyValueChangeNewKey]integerValue];
        }
    } else {
        // Fallback on earlier versions
        // ios10.0之后才能够监听到暂停后继续播放的状态，ios10.0之前监测不到这个状态
        //但是可以监听到开始播放的状态 AVPlayerStatus  status监听这个属性。
    }
}

- (void)playAction{
    if ( self.isReadToPlay) {
        if (@available(iOS 10.0, *)) {
            if (_playStatus == AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate) {
                // do something
                _button.hidden = YES;
                  [self alert:@"资源出错"];

            }else if (_playStatus == AVPlayerTimeControlStatusPlaying) {//正在播放
                [self.myPlayer pause];
                _button.hidden = NO;
            }else if (_playStatus == AVPlayerTimeControlStatusPaused) {//暂停
                [self.myPlayer play];
                
//                self.myPlayer.rate = 1.5;//注意更改播放速度要在视频开始播放之后才会生效
                _button.hidden = YES;
            }
        } else {
            // Fallback on earlier versions
              [self alert:@"版本不支持"];
        }
    }else{
        NSLog(@"视频正在加载中");
        [self alert:@"视频正在加载中"];
    }
}

- (void)alert:(NSString *)alert {
    JJAlertController *alertView = [JJAlertController alertControllerWithTitle:nil message:alert actionNames:@[@"确定"] handle:^(id  _Nonnull result) {

    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self playAction];
}


- (void)clear {
    self.myPlayer = nil;
}
@end

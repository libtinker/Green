//
//  VideoView.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/1.
//

#import "VideoView.h"
#import <AVFoundation/AVFoundation.h>

API_AVAILABLE(ios(10.0))
@interface VideoView ()
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）

@property (strong, nonatomic)UISlider *avSlider;//用来现实视频的播放进度，并且通过它来控制视频的快进快退。
@property (assign, nonatomic)BOOL isReadToPlay;//用来判断当前视频是否准备好播放。

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,assign) AVPlayerTimeControlStatus playStatus;//播放状态
@end

@implementation VideoView

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        NSURL *mediaURL = [NSURL URLWithString:urlString];
        self.item = [AVPlayerItem playerItemWithURL:mediaURL];
        self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
        self.playerLayer.frame = self.frame;
        [self.layer addSublayer:self.playerLayer];
        
        //通过KVO来观察status属性的变化，来获得播放之前的错误信息
        [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.bounds =  CGRectMake(0, 0, 59, 57);
        _button.center = self.center;
        UIImage *image = [UIImage imageNamed:@"video.bundle/poster_play"];
        [_button setImage:image forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        [self.avSlider addTarget:self action:@selector(avSliderAction) forControlEvents:
         UIControlEventTouchUpInside|UIControlEventTouchCancel|UIControlEventTouchUpOutside];
        
        //监听 timeControlStatus
        [self.myPlayer addObserver:self forKeyPath:@"timeControlStatus" options:NSKeyValueObservingOptionNew context:nil];    }
    return self;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                self.isReadToPlay = NO;
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                self.isReadToPlay = YES;
                self.avSlider.maximumValue = self.item.duration.value / self.item.duration.timescale;
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                self.isReadToPlay = NO;
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

            }else if (_playStatus == AVPlayerTimeControlStatusPlaying) {//正在播放
                [self.myPlayer pause];
                _button.hidden = NO;
            }else if (_playStatus == AVPlayerTimeControlStatusPaused) {//暂停
                [self.myPlayer play];
                _button.hidden = YES;
            }
        } else {
            // Fallback on earlier versions
        }
    }else{
        NSLog(@"视频正在加载中");
    }
}

- (UISlider *)avSlider{
    if (!_avSlider) {
        _avSlider = [[UISlider alloc]initWithFrame:CGRectMake(50, self.bounds.size.height-30, self.bounds.size.width-100, 30)];
        [self addSubview:_avSlider];
    }
    return _avSlider;
}

- (void)avSliderAction{
    //slider的value值为视频的时间
    float seconds = self.avSlider.value;
    //让视频从指定的CMTime对象处播放。
    CMTime startTime = CMTimeMakeWithSeconds(seconds, self.item.currentTime.timescale);
    //让视频从指定处播放
    [self.myPlayer seekToTime:startTime completionHandler:^(BOOL finished) {
        if (finished) {
            [self playAction];
        }
    }];
}

@end

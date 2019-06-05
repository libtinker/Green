//
//  VideoView.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,Playerstatus) {
    PlayerstatusFailed,
    PlayerStatusPlaying,
    PlayerStatusPaused
};

typedef void(^PlayerstatusBlock)(Playerstatus);

@interface HomeVideoView : UIView

/**
 播放通过URL

 @param urlString url
 */
- (void)playWithUrlString:(NSString *)urlString;
- (void)pause;//暂停
- (void)play;//播放

- (void)addObserverPlayer:(PlayerstatusBlock)playerstatusBlock;
@end

NS_ASSUME_NONNULL_END

//
//  HomeTableViewCell.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/5.
//

#import "HomeTableViewCell.h"
#import "HomeVideoView.h"
#import "UILabel+JJAdd.h"

@interface HomeTableViewCell ()

@property (nonatomic,strong) HomeVideoView *videoView;
@property (nonatomic,strong) UIImageView *playImageView;

@property (nonatomic,strong) UILabel*nameLabel;
@property (nonatomic,strong) UILabel *describeLabel;

@end
@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.videoView];
        [self.contentView addSubview:self.playImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.describeLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self.contentView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (HomeVideoView *)videoView {
    if (!_videoView) {
        _videoView = [[HomeVideoView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        __weak HomeTableViewCell *weakSelf = self;
        [_videoView addObserverPlayer:^(Playerstatus status) {
            if (status == PlayerstatusFailed) {
                weakSelf.playImageView.hidden = NO;
            }else if (status == PlayerStatusPlaying) {
                weakSelf.playImageView.hidden = NO;
            }else{
                weakSelf.playImageView.hidden = YES;
            }
        }];
    }
    return _videoView;
}

- (void)playUrlString:(NSString *)urlString {
    _playImageView.hidden = YES;
    [_videoView playWithUrlString:urlString];
}

- (void)pause {
    _playImageView.hidden = NO;
    [_videoView pause];
}

- (UIImageView *)playImageView {
    if (!_playImageView) {
        _playImageView = [UIImageView new];
        _playImageView.bounds =  CGRectMake(0, 0, 59, 57);
        _playImageView.center = self.videoView.center;
        UIImage *image = [UIImage imageNamed:@"video.bundle/icon_play_pause"];
        _playImageView.image = image;
        _playImageView.hidden = YES;
    }
    return _playImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 100, 280, 20) text:@"@里贝里告别拜仁" textColor:UIColor.whiteColor font:[UIFont italicSystemFontOfSize:16]];
    }
    return _nameLabel;
}

- (UILabel *)describeLabel {
    if (!_describeLabel) {
        _describeLabel = [UILabel labelWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 80, 280, 20) text:@"好想哭" textColor:UIColor.whiteColor font:[UIFont italicSystemFontOfSize:13]];
    }
    return _describeLabel;
}

- (void)tapClick {
    [_videoView play];
}

- (void)setData:(NSDictionary *)data {
    _describeLabel.text = data[@"discribe"];
    _nameLabel.text = data[@"title"];
    [self playUrlString:data[@"video_url"]];
}
@end

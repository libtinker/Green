//
//  HomeTableViewCell.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/5.
//

#import "HomeTableViewCell.h"
#import "HomeVideoView.h"
#import "UILabel+JJAdd.h"
#import "UIButton+JJAdd.h"

@interface HomeTableViewCell ()

@property (nonatomic,strong) HomeVideoView *videoView;
@property (nonatomic,strong) UIImageView *playImageView;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel*nameLabel;
@property (nonatomic,strong) UILabel *describeLabel;
@property (nonatomic,strong) UIButton *headPortraitPBtn;//头像
@property (nonatomic,strong) UIButton *praiseBtn;//点赞
@property (nonatomic,strong) UIButton *commentsBtn;//评论
@property (nonatomic,strong) UIButton *shareBtn;//分享
@end
@implementation HomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.videoView];
        [self.contentView addSubview:self.scrollView];
        [self.contentView addSubview:self.playImageView];
        [self.scrollView addSubview:self.nameLabel];
        [self.scrollView addSubview:self.describeLabel];
        [self.scrollView addSubview:self.headPortraitPBtn];
        [self.scrollView addSubview:self.praiseBtn];
        
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

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, [UIScreen mainScreen].bounds.size.height);
         _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
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

- (UIButton *)headPortraitPBtn {
    if (!_headPortraitPBtn) {
        _headPortraitPBtn = [UIButton buttonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height-340, 60, 60) image:[UIImage imageNamed:@""] target:self action:@selector(headPortraitPBtnClicked)];
        _headPortraitPBtn.backgroundColor = [UIColor redColor];
        _headPortraitPBtn.layer.cornerRadius = 30;
    }
    return _headPortraitPBtn;
}

- (UIButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [UIButton buttonWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, [UIScreen mainScreen].bounds.size.height-260, 60, 60) image:[UIImage imageNamed:@"video.bundle/icon_home_like_before"] target:self action:@selector(praiseBtnClicked)];
        [_praiseBtn setTitle:@"1.0w" forState:UIControlStateNormal];
//        _praiseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        CGSize titleSize = _praiseBtn.titleLabel.bounds.size;
        CGSize imageSize = _praiseBtn.imageView.bounds.size;
        _praiseBtn.imageEdgeInsets = UIEdgeInsetsMake(-imageSize.height/2, titleSize.width/2, imageSize.height/2, -titleSize.width/2);
        _praiseBtn.titleEdgeInsets = UIEdgeInsetsMake(titleSize.height/2, -imageSize.width/2, -titleSize.height/2, imageSize.width/2);
        [_praiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _praiseBtn;
}

- (void)headPortraitPBtnClicked {
    [self pause];

    NSURL *url = [NSURL URLWithString:@"Green://mine/login"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {

        }];
}

- (void)praiseBtnClicked {

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

//
//  HomeViewController.m
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

static const int videoViewCount = 3;

#import "HomeViewController.h"
#import "VideoView.h"

@interface HomeViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *dataArray;
}
//@property (nonatomic,strong) VideoView *videoView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentPage;
@end

@implementation HomeViewController

#pragma mark - LifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    //测试

    NSString * urlString1 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSString * urlString2 = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"mp4"];
    dataArray = [[NSMutableArray alloc] init];
    [dataArray addObject:urlString1];
     [dataArray addObject:urlString2];
    [self.view addSubview:self.scrollView];
    self.currentPage = 1;

    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    for (int i = 0;i < videoViewCount; i++) {
        CGRect frame = CGRectMake(0, i*height, width, height);
      VideoView * _videoView = [[VideoView alloc] initWithFrame:frame];

        if (i == 1) {
            [_videoView playWithUrlString:dataArray[0]];
        }
        [self.scrollView addSubview:_videoView];
    }


    self.scrollView.contentSize = CGSizeMake(0, height*videoViewCount);
//    self.scrollView.contentOffset = CGPointMake(0, height);

    [self.scrollView setContentOffset:CGPointMake(0,  height) animated:YES];

//    [self setContent];



}

#pragma mark - HTTP


#pragma mark - Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSInteger page = 0;
//    //用来拿最小偏移量
//    CGFloat minDistance = MAXFLOAT;
//
//    for (int i=0; i<self.scrollView.subviews.count; i++) {
//        VideoView *imagBtn = self.scrollView.subviews[i];
//        CGFloat distance = 0;
//        distance = ABS(imagBtn.frame.origin.y - scrollView.contentOffset.y);
//        if (distance<minDistance) {
//            minDistance = distance;
//            page = imagBtn.tag;
//        }
//    }
//    self.currentPage = page;
}
//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    [self updateContent];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    VideoView *imgBtn = self.scrollView.subviews[1];
//    [imgBtn clear];
}

#pragma mark - Public

#pragma mark - Private
//设置显示内容
- (void)setContent{
    for (int i=0; i<self.scrollView.subviews.count; i++) {
        NSInteger index = self.currentPage;
        VideoView *imgBtn = self.scrollView.subviews[i];
        if (i == 0) {
            index--;
        }else if (i == 2){
            index++;
        }
        if (index<0) {
            index = dataArray.count-1;
        }else if (index == dataArray.count) {
            index = 0;
        }
        imgBtn.tag = index;
        NSLog(@"------------%d",index);
        //只是图片的加载方式
    }
    self.scrollView.contentOffset = CGPointMake(0, self.view.frame.size.height);
    VideoView *imgBtn = self.scrollView.subviews[1];
    [imgBtn playWithUrlString:dataArray[imgBtn.tag]];

}

//状态改变之后更新显示内容
- (void)updateContent {
    CGFloat height = self.view.bounds.size.height;
    [self setContent];
    self.scrollView.contentOffset = CGPointMake(0, height);
}
#pragma mark - Setter

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.frame;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}
@end

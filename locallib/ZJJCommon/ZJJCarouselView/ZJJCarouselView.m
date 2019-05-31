//
//  ZJJCarouselView.m
//  ZJJCarouselViewExample
//
//  Created by 天空吸引我 on 2018/5/3.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "ZJJCarouselView.h"
#import "UIButton+WebCache.h"

static const int imageBtnCount = 3;

@interface ZJJCarouselView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView*scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

/**轮播图点击事件*/
@property (nonatomic,copy) DidSelectBlock didSelectBlock;
@end

@implementation ZJJCarouselView
-(instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls didSelectBlock:(DidSelectBlock)didSelectBlock
{
    if (self = [super initWithFrame:frame]) {
        [self setDefaultParm];//默认开启自动轮播
        [self addSubview:self.scrollView];
        [self addContentView];
        [self addSubview:self.pageControl];
        [self setImageUrls:imageUrls];
        _didSelectBlock = didSelectBlock;
    }
    return self;
}

- (void)setDefaultParm {
    //默认开启自动轮播
    _isAutomaticTransmission = YES;
    //轮播间隔默认为2秒
    _intervalTime = 2.0f;
    //当前pageControl的颜色（默认为黄色）
    _currentPageColor = [UIColor orangeColor];
    //pageControl的默认颜色（默认为灰色)
    _pageColor = [UIColor grayColor];
    //pageControl的高度
    _pageH = 20.f;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = _currentPageColor;
        _pageControl.pageIndicatorTintColor = _pageColor;
    }
    return _pageControl;
}

- (void)addContentView {
    for (int i = 0;i < imageBtnCount; i++) {
        UIButton *imageBtn = [[UIButton alloc] init];
        [_scrollView addSubview:imageBtn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.scrollView.contentSize = CGSizeMake(width*imageBtnCount, 0);
    
    for (int i=0; i<self.scrollView.subviews.count; i++) {
        UIButton *imageBtn = self.scrollView.subviews[i];
        imageBtn.frame = CGRectMake(i*width, 0, width, height);
        [imageBtn addTarget:self action:@selector(imageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
     //设置contentOffset,显示最中间的图片
    self.scrollView.contentOffset = CGPointMake(width, 0);
    
    //设置pageControl的位置
    CGFloat pageW = self.frame.size.width;
    CGFloat pageH = _pageH;
    CGFloat pageX = 0;
    CGFloat pageY = height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
}

-(void)setImageUrls:(NSArray *)imageUrls {
    _imageUrls = imageUrls;
    self.pageControl.numberOfPages = _imageUrls.count;
    self.pageControl.currentPage = 0;
    [self setContent];
    [self startTimer];
}

-(void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
}

-(void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

//设置显示内容
-(void)setContent {
    for (int i=0; i<self.scrollView.subviews.count; i++) {
        NSInteger index = self.pageControl.currentPage;
        UIButton *imgBtn = self.scrollView.subviews[i];
        
        if (i == 0) {
            index--;
        }else if (i == 2){
            index++;
        }
        
        if (index<0) {
            index = self.pageControl.numberOfPages-1;
        }else if (index == self.pageControl.numberOfPages){
            index = 0;
        }
        
        imgBtn.tag = index;
        
        //只是图片的加载方式
        NSURL *imageUrl = [NSURL URLWithString:_imageUrls[index]];
        [imgBtn sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:_placeholderImage completed:nil];
        [imgBtn sd_setImageWithURL:imageUrl forState:UIControlStateHighlighted placeholderImage:_placeholderImage completed:nil];
    }
}

//状态改变之后更新显示内容
- (void)updateContent {
    [self setContent];
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = 0;
    //用来拿最小偏移量
    CGFloat minDistance = MAXFLOAT;
    
    for (int i=0; i<self.scrollView.subviews.count; i++) {
        UIButton *imagBtn = self.scrollView.subviews[i];
        CGFloat distance = 0;
        distance = ABS(imagBtn.frame.origin.x - scrollView.contentOffset.x);
        if (distance<minDistance) {
            minDistance = distance;
            page = imagBtn.tag;
        }
    }
    self.pageControl.currentPage = page;
}
//开始拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
//结束拖拽的时候开始定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}
//结束拖拽的时候更新image内容
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateContent];
}
//scroll滚动动画结束的时候更新image内容
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateContent];
}
#pragma mark - 定时器
//开始计时器
- (void)startTimer {
    if (_isAutomaticTransmission) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_intervalTime target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
    
}
//停止计时器
- (void)stopTimer {
    if (_isAutomaticTransmission) {
        //结束计时
        [self.timer invalidate];
        //计时器被系统强引用，必须手动释放
        self.timer = nil;
    }
}
//通过改变contentOffset * 2换到下一张图片
- (void)nextImage {
    CGFloat width = self.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(2 * width, 0) animated:YES];
}
-(void)imageBtnClicked:(UIButton *)button{
    NSInteger index = button.tag;
    if (_didSelectBlock) {
        _didSelectBlock(index);
    }
}

@end

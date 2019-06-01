//
//  ZJJCarouselView.h
//  ZJJCarouselViewExample
//
//  Created by 天空吸引我 on 2018/5/3.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJCarouselView : UIView

#pragma mark - 轮播图参数设置
/**图片地址数组*/
@property (nonatomic, copy) NSArray *imageUrls;
/**是否开启自动轮播（默认是开启状态）*/
@property (nonatomic,assign) BOOL isAutomaticTransmission;

/**轮播间隔时间（默认为2秒）*/
@property (nonatomic,assign) NSTimeInterval intervalTime;

/**占位图*/
@property (nonatomic,copy) UIImage *placeholderImage;

/**当前pageControl的颜色（默认为黄色）*/
@property (nonatomic, strong) UIColor *currentPageColor;
/**pageControl的默认颜色（默认为灰色）*/
@property (nonatomic, strong) UIColor *pageColor;
/**当前pageControl的图片*/
@property (nonatomic, strong) UIImage *currentPageImage;
/**pageControl的默认图片（默认为灰色）*/
@property (nonatomic, strong) UIImage *pageImage;

/**pageControl的高度（默认是20）*/
@property (nonatomic,assign) CGFloat pageH;

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls imgClicked:(void(^)(NSInteger index))imgClicked;

@end

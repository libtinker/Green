//
//  UIView+ZJJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/5.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (JJAdd)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat w;
@property (assign, nonatomic) CGFloat h;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@end

NS_ASSUME_NONNULL_END

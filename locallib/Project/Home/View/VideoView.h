//
//  VideoView.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
- (void)playWithUrlString:(NSString *)urlString;
- (void)clear;
@end

NS_ASSUME_NONNULL_END

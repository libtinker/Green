//
//  BaseTabBarViewController.h
//  Green
//
//  Created by 天空吸引我 on 2019/5/31.
//  Copyright © 2019 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTabBarViewController : UITabBarController

+ (BOOL)openPath:(NSString *)path data:(NSDictionary<NSString *, id> *)data;
@end

NS_ASSUME_NONNULL_END

//
//  UIDevice+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/21.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (JJAdd)

/**
 获取当前硬件体系类型
 */
- (NSString *)deviceName;

/**
 获取当前操作系统名
 */
- (NSString *)sysnameName;

/**
 获取网络上的名称
 */
- (NSString *)nodenameName;

/**
 获取当前发布级别
 */
- (NSString *)releaseName;

/**
 获取当前发布版本
 */
- (NSString *)versionName;

/**
 机器型号名称

 @return 结果字符串
 */
- (NSString *)machineModelName;
@end

NS_ASSUME_NONNULL_END

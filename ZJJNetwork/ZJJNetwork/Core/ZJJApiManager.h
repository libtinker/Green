//
//  ZJJApiManager.h
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    EnvironmentTypeOnline = 0,
    EnvironmentTypeTest,
    EnvironmentTypePrepare
} EnvironmentType;

@interface ZJJApiManager : NSObject
+ (instancetype)shareManager;

@property(nonatomic, assign) EnvironmentType type;
@property(nonatomic, copy) NSString *baseUrl;
@end

NS_ASSUME_NONNULL_END

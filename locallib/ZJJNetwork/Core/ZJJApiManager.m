//
//  ZJJApiManager.m
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import "ZJJApiManager.h"

@implementation ZJJApiManager

+ (instancetype)shareManager {
    static ZJJApiManager *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[self alloc] init];
    });
    return _sharedSingleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _type = EnvironmentTypeTest;
    }
    return self;
}

- (NSString *)baseUrl {
    if (!_baseUrl) {
        switch (_type) {
            case EnvironmentTypeOnline:
                _baseUrl = @"http://127.0.0.1:6060";
                break;
            case EnvironmentTypeTest:
                _baseUrl = @"http://192.168.0.100:6061";
                break;
            case EnvironmentTypePrepare:
                _baseUrl = @"http://127.0.0.1:6060";
                break;
        }
    }
    return _baseUrl;
}
@end

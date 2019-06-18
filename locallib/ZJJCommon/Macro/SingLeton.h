//
//  SingLeton.h
//  ZhongWangLiCai
//
//  Created by hc-ios on 2018/11/27.
//  Copyright © 2018 hc-ios. All rights reserved.
//

// @interface
#define singleton_interface(shareName) \
+ (instancetype)share##shareName;

// @implementation
#define singleton_implementation(shareName) \
static id _instace; \
+(id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken;\
dispatch_once(&onceToken,^{ \
_instace = [super allocWithZone:zone];\
});\
return _instace;\
}\
\
+(instancetype)share##shareName\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken,^{\
_instace = [[self alloc]init];\
});\
return _instace;\
}\

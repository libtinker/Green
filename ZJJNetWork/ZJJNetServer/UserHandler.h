//
//  UserHandler.h
//  ZJJNetWork
//
//  Created by ZJJ on 2018/1/4.
//  Copyright © 2018年 ZJJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJJBaseHandler.h"
@interface UserHandler : ZJJBaseHandler

//登录
+ (void)requestLoginWithParam:(NSDictionary *)params withSuccess:(NetResultHandler)success failed:(NetResultHandler)failed;

@end

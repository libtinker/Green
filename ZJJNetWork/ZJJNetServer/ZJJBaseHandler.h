//
//  ZJJBaseHandler.h
//  ZJJNetWork
//
//  Created by ZJJ on 2018/1/4.
//  Copyright © 2018年 ZJJ. All rights reserved.
//

#import "ZJJNetServer.h"
#import <Foundation/Foundation.h>

@interface ZJJBaseHandler : NSObject
+ (void)request:(NSString *)strUrl  param:(NSDictionary *)params withSuccess:(NetResultHandler)success failed:(NetResultHandler)failed;
@end

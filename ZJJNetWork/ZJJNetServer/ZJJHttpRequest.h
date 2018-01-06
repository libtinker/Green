//
//  ZJJHttpRequest.h
//  ZJJNetWork
//
//  Created by ZJJ on 2017/12/17.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJJNetServer.h"

@interface ZJJHttpRequest : NSObject

+ (void)request:(NSString *)strUrl param:(NSDictionary *)params withSuccess:(NetResultHandler)success failed:(NetResultHandler)failed;

@end

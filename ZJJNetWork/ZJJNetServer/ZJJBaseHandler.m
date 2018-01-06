//
//  ZJJBaseHandler.m
//  ZJJNetWork
//
//  Created by ZJJ on 2018/1/4.
//  Copyright © 2018年 ZJJ. All rights reserved.
//

#import "ZJJBaseHandler.h"
#import "ZJJHttpRequest.h"

@implementation ZJJBaseHandler
+ (void)request:(NSString *)strUrl  param:(NSDictionary *)params withSuccess:(NetResultHandler)success failed:(NetResultHandler)failed;
{
    [ZJJHttpRequest request:strUrl param:params withSuccess:^(id obj) {
        if (success) {
            success(obj);
        }
    } failed:^(id obj) {
        if (failed) {
            failed(obj);
        }
    }];
    
}
@end

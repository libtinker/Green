//
//  UserHandler.m
//  ZJJNetWork
//
//  Created by ZJJ on 2018/1/4.
//  Copyright © 2018年 ZJJ. All rights reserved.
//

#import "UserHandler.h"

@implementation UserHandler

+ (void)requestLoginWithParam:(NSDictionary *)params withSuccess:(NetResultHandler)success failed:(NetResultHandler)failed
{
    NSString *str = @"/user/login";
    [self request:str param:params withSuccess:success failed:failed];
}
@end

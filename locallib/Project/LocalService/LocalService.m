//
//  LocalService.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import "LocalService.h"
#import "MineService.h"

@implementation LocalService

+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options {
    //去除特殊字符
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"/"];
    NSString * path = [[url.path componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];

    if ([url.host isEqualToString:@"mine"]) {
       return [MineService openPath:path options:options];
    }
    return NO;
}

+ (BOOL)isLogged {

}
@end

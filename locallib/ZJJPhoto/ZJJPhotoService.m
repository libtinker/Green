//
//  ZJJPhotoService.m
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/24.
//

#import "ZJJPhotoService.h"
#import "ZJJPhoto.h"

@implementation ZJJPhotoService

+ (BOOL)openPath:(NSString *)path data:(NSDictionary<NSString *, id> *)data {
    if ([path isEqualToString:@"/save"]) {
        [ZJJPhoto.share saveVideo:data[@"data"]];
    }
    return YES;
}
@end

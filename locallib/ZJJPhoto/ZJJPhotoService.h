//
//  ZJJPhotoService.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJJPhotoService : NSObject
+ (BOOL)openPath:(NSString *)path data:(NSDictionary<NSString *, id> *)data;
@end

NS_ASSUME_NONNULL_END

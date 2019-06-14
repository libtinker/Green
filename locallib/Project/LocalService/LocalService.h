//
//  LocalService.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalService : NSObject

+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<NSString *, id> *)options;
@end

NS_ASSUME_NONNULL_END

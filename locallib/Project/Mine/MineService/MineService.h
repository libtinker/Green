//
//  MineService.h
//  AFNetworking
//
//  Created by 天空吸引我 on 2019/6/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineService : NSObject

+ (BOOL)openPath:(NSString *)path options:(NSDictionary<NSString *, id> *)options;
@end

NS_ASSUME_NONNULL_END

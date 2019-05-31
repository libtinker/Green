//
//  ZJJNetwork.h
//  ZJJNetwork
//
//  Created by 天空吸引我 on 2019/5/30.
//  Copyright © 2019 ZJJ. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef void (^Success)(id _Nullable responseObject);
typedef void (^Failure)(NSError * _Nullable error,id _Nullable responseObject);

@interface ZJJNetwork : NSObject

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(Success)success
     failure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END

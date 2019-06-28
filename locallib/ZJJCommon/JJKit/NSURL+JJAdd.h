//
//  NSURL+JJAdd.h
//  ZJJCommon
//
//  Created by 天空吸引我 on 2019/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (JJAdd)

/**
 获取URL的参数（字典类型）

 @return url参数
 */
- (NSDictionary *)parameterDictionary;
@end

NS_ASSUME_NONNULL_END

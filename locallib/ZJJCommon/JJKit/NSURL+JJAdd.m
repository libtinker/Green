//
//  NSURL+JJAdd.m
//  ZJJCommon
//
//  Created by 天空吸引我 on 2019/6/25.
//

#import "NSURL+JJAdd.h"

@implementation NSURL (JJAdd)

//获取URL的参数（字典类型）
- (NSDictionary *)parameterDictionary {
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:self.absoluteString];
    if (components.queryItems.count == 0) {
        return nil;
    }
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = @{obj.name:obj.value};
        [dataDict addEntriesFromDictionary:dict];
    }];
    return dataDict;
}

@end

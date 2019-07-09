//
//  AFHTTPCustomRequestSerializer.m
//  NetWorkLab
//
//  Created by hc-ios on 2018/10/29.
//  Copyright © 2018 hc-ios. All rights reserved.
//

#import "AFHTTPCustomRequestSerializer.h"

@implementation AFHTTPCustomRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error {
    NSParameterAssert(request);
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    NSString *query = nil;
    if (parameters) {
        query = parameters;
    }
    if (!query) {
        query = @"";
    }
    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
        [mutableRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    NSData *body   = [query dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPBody:body];
    return mutableRequest;
}

@end

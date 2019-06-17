//
//  LoginModel.h
//  Project
//
//  Created by 天空吸引我 on 2019/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : NSObject

/**
 判断本地用户信息是否合法

 @param username 用户名
 @param password 密码
 @return 结果
 */
+ (BOOL)isLegalWithUsername:(NSString *)username password:(NSString *)password;

+ (void)saveUserId:(NSString *)userId;

+ (NSString *)getUserId;
@end

NS_ASSUME_NONNULL_END

//
//  NSString+JJAdd.h
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/16.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JJAdd)

#pragma mark ------ 加密相关 ------
/**
 aes加密（对称加密）

 @param key 加密秘钥
 @param iv 向量
 @return 加密后的字符串
 */
- (NSString *)aes256EncryptWithKey:(NSString *)key iv:(NSString *)iv;

/**
 aes解密（对称加密）

 @param key 解密秘钥
 @param iv 向量
 @return 解密后的字符串
 */
- (NSString *)aes256DecryptWithKey:(NSString *)key iv:(NSString *)iv;

/**
 base64加密

 @return 加密后的字符串
 */
- (NSString *)base64EncodedString;

/**
 base64解密

 @return 解密后的字符串
 */
- (NSString *)base64DecodeString;

/**
 md5加密（不可逆）

 @return 加密后字符串
 */
- (NSString *)md5;

#pragma mark ------ 字符串验证 ------

/** 是否为网址*/
- (BOOL)isURL;

/** 是否为邮箱*/
- (BOOL)isEmail;

/** 是否为纯数字*/
- (BOOL)isNumber;

/** 是否为身份证*/
- (BOOL)isIDCard;

/** 是否为字母*/
- (BOOL)isLetter;

/** 标点符号 */
- (BOOL)isPunctuation;

/** 汉语 */
- (BOOL)isChinese;
#pragma mark ------ 字符串其他处理 ------

/**
 获取字符串高度

 @param font 字体
 @param width 字符串宽
 @return 高度
 */
- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width;


/**
 获取带有行间距字符串高度

 @param font 字体
 @param width 宽度
 @param lineSpacing 行间距
 @return 高度
 */
- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;


@end

NS_ASSUME_NONNULL_END

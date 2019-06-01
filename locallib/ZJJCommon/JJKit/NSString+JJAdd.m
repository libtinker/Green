//
//  NSString+JJAdd.m
//  ZJJKitExample
//
//  Created by 天空吸引我 on 2019/3/16.
//  Copyright © 2019年 天空吸引我. All rights reserved.
//

#import "NSString+JJAdd.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (JJAdd)

#pragma mark ------ 加密相关 ------
//加密
- (NSString *)aes256EncryptWithKey:(NSString *)key iv:(NSString *)iv {
    NSData *contentData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [iv dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

//解密
- (NSString *)aes256DecryptWithKey:(NSString *)key iv:(NSString *)iv {
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [iv dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}

//base64加密
- (NSString *)base64EncodedString {
    NSData* originData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodeResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
     return encodeResult;
}

//base64解密
- (NSString *)base64DecodeString {
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
}

//MD5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark ------ 字符串验证------

- (BOOL)validateString:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

//网址
- (BOOL)isURL {
    return [self validateString:@"[a-zA-z]+://.*"];
}

//邮箱
- (BOOL)isEmail {
    return [self validateString:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

//身份证验证
- (BOOL)isIDCard {
    if (self.length != 18) {
        return NO;
    }
    if (![[self substringToIndex:17] isNumber]) {
        return NO;
    }
    NSString *last = [self substringFromIndex:17];
    return [last isEqualToString:@"x"] || [last isEqualToString:@"X"] || [last isNumber];
}

//是否为纯数字
- (BOOL)isNumber {
    return [self validateString:@".*[0-9]+.*"];
}

//纯字母
- (BOOL)isLetter {
    return [self validateString:@"[a-zA-Z]*"];
}

//标点符号
- (BOOL)isPunctuation {
    return [self validateString:@"[-()（）—”“$&@%^*?+?=|{}?【】？??￥!！.<>/:;：；、,，。·]*"];
}

//汉语
- (BOOL)isChinese {
    return [self validateString:@"[\u4e00-\u9fa5]+"];
}

#pragma mark ------ 字符串其他处理 ------

//获取字符串高度
- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width {
    return  [self getHeightWithFont:font width:width lineSpacing:0];
}

- (CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpacing;
    NSDictionary *dic = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  ceilf(size.height);
}

@end

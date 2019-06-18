//
//  ConstantConfig.h
//  DuoLeRong
//
//  Created by hc-ios on 2018/10/25.
//  Copyright © 2018 hc-ios. All rights reserved.
//

#ifndef ConstantConfig_h
#define ConstantConfig_h

#define WS(weakSelf) __weak __typeof(self)weakSelf = self;

#define STATUSBAR_HEIGHT  [[UIApplication sharedApplication] statusBarFrame].size.height

#define SafeAreaBottomHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20 ? 34 : 0)

#define NAVBAR_HEIGHT     44

#define TABBAR_HEIGHT     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define SCREEN_WIDTH      ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT     ([UIScreen mainScreen].bounds.size.height)

#define ScaleH(float)     (((float)*SCREEN_HEIGHT)/667.0)

#define ScaleW(float)     (((float)*SCREEN_WIDTH)/375.0)


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#define Font(s)             [UIFont systemFontOfSize:(s)]
#define BoldFont(s)         [UIFont boldSystemFontOfSize:(s)]
#define MediumFont(s)       [UIFont systemFontOfSize:(s) weight:UIFontWeightMedium]
#define RegularFont(s)      [UIFont systemFontOfSize:(s) weight:UIFontWeightRegular]

#endif

//
//  UnitTextFiled.h
//  ZhongWangLiCai
//
//  Created by 天空吸引我 on 2018/12/21.
//  Copyright © 2018年 hc-ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//JJUnitTextFiledStyle 验证码输入框
typedef NS_ENUM(NSInteger,JJUnitTextFiledStyle) {
    JJUnitTextFiledStyleGrid = 0,//方格风格
    JJUnitTextFiledStyleLine,//下划线风格
};

typedef void(^InputBoxText)(NSString *inputBoxText);

@interface JJUnitTextFiled : UIView

/**
 初始化验证码输入框

 @param frame z位置大小
 @param textFiledStyle 输入框展示分格
 @param inputBoxText 输入框中文字
 @return 当前对象
 */
- (instancetype)initWithFrame:(CGRect)frame textFiledStyle:(JJUnitTextFiledStyle)textFiledStyle inputBoxText:(InputBoxText)inputBoxText;

//方格数量(默认6个)
@property (nonatomic,assign) NSInteger unitCount;
//方格间隙（默认为0）（这个属性和width设置一个即可）
@property (nonatomic,assign) CGFloat unitSpace;
// 设置边框宽度，默认为 1。
@property (nonatomic, assign)  CGFloat borderWidth;
// 设置边框颜色。
@property (nonatomic, strong)  UIColor *borderColor;
//左边距(默认20)
@property (nonatomic,assign) CGFloat left;
//右边距(默认20)
@property (nonatomic,assign) CGFloat right;
//方格宽度（这个属性和unitSpace设置一个即可）
@property (nonatomic,assign) CGFloat width;
//方格高度
@property (nonatomic,assign) CGFloat height;

/*输入框相关*/
//输入框文字
@property (nonatomic,strong,readonly) NSString *text;
//字体
@property (nonatomic,strong) UIFont *font;
//字体颜色
@property (nonatomic,strong) UIColor *textColor;
//密文输入,默认值为 NO
@property (nonatomic, assign) BOOL secureTextEntry;
//光标颜色（UnitLineStyle下有效）
@property (nonatomic,strong) UIColor *cursorColor;

//清除数据
- (void)clearData;

@end

NS_ASSUME_NONNULL_END

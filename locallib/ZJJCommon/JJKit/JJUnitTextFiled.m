//
//  UnitTextFiled.m
//  ZhongWangLiCai
//
//  Created by 天空吸引我 on 2018/12/21.
//  Copyright © 2018年 hc-ios. All rights reserved.
//

#import "JJUnitTextFiled.h"
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface JJUnitTextFiled ()<UIKeyInput> {
    InputBoxText _inputBoxText;
    JJUnitTextFiledStyle _textFiledStyle;
}

@property (nonatomic, strong) NSMutableString *textStore;

@end

@implementation JJUnitTextFiled

- (instancetype)initWithFrame:(CGRect)frame textFiledStyle:(JJUnitTextFiledStyle)textFiledStyle inputBoxText:(InputBoxText)inputBoxText {
    if (self = [super initWithFrame:frame]) {
        self.textStore = [NSMutableString string];
        _inputBoxText = inputBoxText;
        _textFiledStyle = textFiledStyle;
        [self setUnittextFiledAppearance];
        [self becomeFirstResponder];
    }
    return self;
}

- (void)setUnittextFiledAppearance {
    self.backgroundColor = [UIColor whiteColor];
    _cursorColor = [UIColor greenColor];
    _font = [UIFont systemFontOfSize:15];
    _textColor = [UIColor blackColor];
    _unitCount = 6;
    _unitSpace = 0;
    _borderWidth = 1.0;
    _left = _right = 0;
    _borderColor = [UIColor colorWithRed:155/255.0 green:157/255.0 blue:169/255.0 alpha:1.0];
    _width = _height = (self.bounds.size.width - _left -_right - _unitCount * _unitSpace)/_unitCount;
    _width = _height = _height>self.bounds.size.height?self.bounds.size.height:_width;
}

- (void)theCallback {
    if (_inputBoxText) {
        _inputBoxText(_textStore);
    }
}

#pragma mark UIKeyInput protocol
-(void)insertText:(NSString *)text {
    if (_textStore.length>=_unitCount) {
        return;
    }
    [_textStore appendString:text];
    [self theCallback];
    _text = _textStore;
    [self setNeedsDisplay];
}

- (BOOL)hasText {
    return _textStore.length > 0 ;
}

- (void)deleteBackward {
    if ([_textStore length] == 0) {
        return;
    }
    NSRange theRange = NSMakeRange(_textStore.length - 1, 1);
    [_textStore deleteCharactersInRange:theRange];
    [self theCallback];
    _text = _textStore;
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}

#pragma mark -------勾画内容-------

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat left = _left;
    CGFloat y = 0;
    CGFloat w = _width;
    CGFloat h = _height;;
    for (int i = 0; i <_unitCount; i++) {
        [self drawSquareRowRect:CGRectMake(left + i*w + i*_unitSpace, y, w, h)];
    }
    CGFloat textY = (h -ceilf(_font.lineHeight))/2;
    for (int i = 0; i < _textStore.length; i++) {
        NSString *text =  [_textStore substringWithRange:NSMakeRange(i, 1)];
        [self drawText:text rect:CGRectMake(left + i*w + i*_unitSpace, textY, w, h)];
    }
    [self drawCursor:CGRectMake(left + _textStore.length*w + _textStore.length*_unitSpace, y, w, h)];
}

//画输入内容
- (void)drawText:(NSString *)text rect:(CGRect)rect {
    if (_secureTextEntry) {
        [self drawCircleRect:rect];
    }else{
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
        [style setAlignment:NSTextAlignmentCenter];
        NSDictionary *attributeDict = @{NSParagraphStyleAttributeName:style, NSFontAttributeName:_font, NSForegroundColorAttributeName:_textColor};
        [text drawInRect:rect withAttributes:attributeDict];
    }
}

//画圆
- (void)drawCircleRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();//1.0获取上下文
    CGContextAddArc(ctx,  rect.size.width/2+rect.origin.x, ceilf(_font.lineHeight)/2 + rect.origin.y, 2.5,DEGREES_TO_RADIANS(0), DEGREES_TO_RADIANS(360), 0);
    CGContextSetStrokeColorWithColor(ctx, _textColor.CGColor);
    CGContextSetLineWidth(ctx, 5);//线条宽度
    CGContextStrokePath(ctx);
}

//绘制正方行
- (void)drawSquareRowRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, _borderWidth);
    CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    if (_textFiledStyle == JJUnitTextFiledStyleLine) {
        CGPoint pointsRect[2] = {CGPointMake(x, y+h), CGPointMake(x+w, y+h)};
        CGContextAddLines(context, pointsRect, 2);
    }else if(rect.origin.x == 0){
        CGPoint pointsRect[5] = {CGPointMake(x, y), CGPointMake(x+w, y), CGPointMake(x+w, y+h), CGPointMake(x, y+h), CGPointMake(x, y)};
        CGContextAddLines(context, pointsRect, 5);
    }else{
        CGPoint pointsRect[4] = {CGPointMake(x, y), CGPointMake(x+w, y), CGPointMake(x+w, y+h), CGPointMake(x, y+h)};
        CGContextAddLines(context, pointsRect, 4);
    }
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawCursor:(CGRect)rect {
    if (_textFiledStyle == JJUnitTextFiledStyleGrid) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, _borderWidth);
    CGContextSetStrokeColorWithColor(context, _cursorColor.CGColor);
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    CGPoint pointsRect[2] = {CGPointMake(x, y+h), CGPointMake(x+w, y+h)};
    CGContextAddLines(context, pointsRect, 2);
    CGContextDrawPath(context, kCGPathFillStroke);
}

#pragma mark ------ setter ------

- (void)setUnitCount:(NSInteger)unitCount {
    _unitCount = unitCount;
    [self setNeedsDisplay];
}

- (void)setLeft:(CGFloat)left {
    _left = left;
    [self setNeedsLayout];
}

- (void)setRight:(CGFloat)right {
    _right = right;
    [self setNeedsLayout];
}

- (void)setUnitSpace:(CGFloat)unitSpace {
    _unitSpace = unitSpace;
    _width = _height = (self.bounds.size.width - _left -_right - _unitCount * _unitSpace)/_unitCount;
    [self setNeedsLayout];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    _cursorColor = cursorColor;
    [self setNeedsLayout];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self setNeedsLayout];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsLayout];
}

- (void)setWidth:(CGFloat)width {
    _width = width;
    _unitSpace = (self.bounds.size.width - _left - _right)/_unitCount - width;
    [self setNeedsLayout];
}

- (void)setHeight:(CGFloat)height {
    _height = height;
    [self setNeedsLayout];
}

- (void)clearData {
     [_textStore deleteCharactersInRange:NSMakeRange(0, _textStore.length)];
       _text = nil;
    [self setNeedsDisplay];
}

@end

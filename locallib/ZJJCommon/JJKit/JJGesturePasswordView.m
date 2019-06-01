//
//  ZJJGesturePasswordView.m
//  ZJJGesturePasswordExample
//
//  Created by 天空吸引我 on 2018/4/28.
//  Copyright © 2018年 天空吸引我. All rights reserved.
//

#import "JJGesturePasswordView.h"

@interface JJGesturePasswordView() {
    NSMutableArray *_selectedPointArray;
    CGPoint currentPoint;
    NSMutableString *_passwd;
    
    NSInteger _startY;
    NSInteger _startX;
    NSInteger _PaddingX;
    NSInteger _PaddingY;
    NSInteger _Width;
    NSInteger _Height;
    CGPoint _lockPos[9];
}

/** 密码手势完成 */
@property (nonatomic,copy) void(^complete) (NSString *password);

@end

@implementation JJGesturePasswordView

- (instancetype)initWithFrame:(CGRect)frame normalImage:( UIImage * _Nonnull )normalImage selectImage:(UIImage * _Nonnull)selectImag complete:(void(^)(NSString *password))complete {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        _normalImage = normalImage;
        _selectImage = selectImag;
        _complete = complete;

        _selectedPointArray = [[NSMutableArray alloc]init];
        _passwd = [[NSMutableString alloc]init];

        _Width = 65;
        _Height = 65;

        _PaddingX = (self.frame.size.width-_Width*3)/3;
        _PaddingY = _PaddingX;

        _startX = (self.frame.size.width-_Width*3-_PaddingX*2)/2;
        _startY = (self.frame.size.height-_Height*3-_PaddingY*2)/2;

        _lockPos[0] = CGPointMake(_startX, _startY);
        _lockPos[1] = CGPointMake(_startX + _Width + _PaddingX, _startY);
        _lockPos[2] = CGPointMake(_startX + _Width*2 + _PaddingX*2, _startY);
        _lockPos[3] = CGPointMake(_startX, _startY + _Height + _PaddingY);
        _lockPos[4] = CGPointMake(_startX + _Width + _PaddingX, _startY + _Height + _PaddingY);
        _lockPos[5] = CGPointMake(_startX + _Width*2 + _PaddingX*2, _startY +_Height +_PaddingY);
        _lockPos[6] = CGPointMake(_startX, _startY + _Height*2 + _PaddingY*2);
        _lockPos[7] = CGPointMake(_startX + _Width + _PaddingX, _startY+_Height*2+_PaddingY*2);
        _lockPos[8] = CGPointMake(_startX +_Width*2 +_PaddingX*2, _startY+_Height*2+_PaddingY*2);
    }
    return self;
}

- (CGPathRef)linePathStartAt:(CGPoint)startPoint End:(CGPoint)endPoint With:(CGFloat)lineWidth {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y);
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    return path;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    currentPoint = [touch locationInView:self];
    
    for (int i = 0; i < 9; i++) {
        CGPoint p = _lockPos[i];
        CGRect rect = CGRectMake(p.x, p.y, _Width, _Height);
        if(CGRectContainsPoint(rect, currentPoint)) {
            CGPoint ap = CGPointMake(p.x+_Width/2, p.y+_Height/2);
            NSString *curstr = NSStringFromCGPoint(ap);
            if(![_selectedPointArray containsObject:curstr]) {
                [_selectedPointArray addObject:curstr];
                [_passwd appendFormat:@"%d", i];
                if (_lockChangeBlock) {
                    _lockChangeBlock([NSString stringWithFormat:@"%d", i]);
                }
            }
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_complete) {
        _complete(_passwd);
    }
    [_selectedPointArray removeAllObjects];
    [_passwd setString:@""];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _lineWidth?_lineWidth:2.0f);
    CGContextSetStrokeColorWithColor(context,_lineColor.CGColor?_lineColor.CGColor: [[UIColor colorWithRed:198/255.0 green:101/255.5 blue:77/255.0 alpha:1.0] CGColor]);
    CGContextSetLineJoin(context, kCGLineJoinRound);

    if ([_selectedPointArray count] > 0) {
        int i = 0;
        for (NSString *posstr in _selectedPointArray) {
            CGPoint p = CGPointFromString(posstr);
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y); //+Height/2-8
            } else {
                CGContextAddLineToPoint(context, p.x, p.y); //-Height/2+8
            }
            i++;
        }
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
        CGContextStrokePath(context);
    }
    
    int j = 0;
    for (int i = 0; i < 9; i++) {
        CGPoint p = _lockPos[i];
        CGPoint ap = CGPointMake(p.x+_Width/2, p.y+_Height/2);
        NSString *curstr = NSStringFromCGPoint(ap);
        if(![_selectedPointArray containsObject:curstr]) {
            [_normalImage drawAtPoint:CGPointMake(p.x, p.y)];
        } else {
            j++;
            [_selectImage drawAtPoint:CGPointMake(p.x, p.y)];
        }
    }
}

//八方位转换
+ (int)changeType:(NSString*)start end:(NSString*)end {
    CGPoint startP = CGPointFromString(start);
    CGPoint endP = CGPointFromString(end);
    
    int startPX = startP.x;
    int startPY = startP.y;
    int endPX = endP.x;
    int endPY = endP.y;
    
    if (endPX == startPX && endPY < startPY) {
        return 1;
    }
    if (endPX > startPX && endPY < startPY) {
        return 2;
    }
    if (endPX > startPX && endPY == startPY) {
        return 3;
    }
    if (endPX > startPX && endPY > startPY) {
        return 4;
    }
    if (endPX == startPX && endPY > startPY) {
        return 5;
    }
    if (endPX < startPX && endPY > startPY) {
        return 6;
    }
    if (endPX < startPX && endPY == startPY) {
        return 7;
    }
    if (endPX < startPX && endPY < startPY) {
        return 8;
    }
    return 0;
}

//旋转图片
+ (UIImage *)rotateImage:(UIImage *)image start:(NSString*)start end:(NSString*)end {
    long double rotate = 0.0;
    CGRect rect = CGRectZero; //modify by sankun 17/7/24 赋初始值 去除警告
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    int type = [JJGesturePasswordView changeType:start end:end];
    switch (type) {
        case 1:
            rotate = 0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
        case 2:
            rotate = sin(315*M_PI/180);
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.height/2.33;
            translateY = rect.size.width/5;
            break;
        case 3:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case 4:
            rotate = M_PI+0.6;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width*1.25;
            translateY = -rect.size.height/1.6;
            break;
        case 5:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        case 6:
            rotate = M_PI-0.6;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width/1.75;
            translateY = -rect.size.height*1.2;
            break;
        case 7:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case 8:
            rotate = sin(45*M_PI/180);
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = rect.size.height/4.7;
            translateY = -rect.size.width/2.2;
            break;
        default:
            
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

- (void)dealloc {
    _selectedPointArray = nil;
    _passwd = nil;
}

@end

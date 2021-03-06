//
//  UIBezierPath+THOUIBezierPathCategory.m
//  THOmasProject
//
//  Created by nan meng on 2021/11/14.
//

#import "UIBezierPath+THOUIBezierPathCategory.h"

@implementation UIBezierPath (THOUIBezierPathCategory)

+ (UIBezierPath *)drawWireLine:(NSMutableArray *)linesArray {
    UIBezierPath * path = [UIBezierPath bezierPath];
    [linesArray enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point;
        point.x = [obj[@"x"] doubleValue];
        point.y = [obj[@"y"] doubleValue];
        if (idx == 0) {
            [path moveToPoint:CGPointMake(point.x, point.y)];
        } else {
            [path addLineToPoint:CGPointMake(point.x, point.y)];
        }
    }];
    return path;
}

+ (NSMutableArray<UIBezierPath *> *)drawLines:(NSMutableArray<NSMutableArray *> *)linesArray {
    if ((linesArray.count == 0) || linesArray == nil)
        return nil;
    NSMutableArray * result = [NSMutableArray array];
    for (NSMutableArray * lineArray in linesArray) {
        UIBezierPath * path = [UIBezierPath drawWireLine:lineArray];
        [result addObject:path];
    }
    return result;
}

+ (UIBezierPath *)drawKLine:(CGFloat)open close:(CGFloat)close high:(CGFloat)high low:(CGFloat)low candleWidth:(CGFloat)candleWidth  xPostion:(CGFloat)xPostion lineWidth:(CGFloat)lineWidth {
    UIBezierPath * candlePath = [UIBezierPath bezierPath];
    candlePath.lineWidth = lineWidth;
    CGFloat y = open > close ? close : open;
    CGFloat height = fabs(close-open);
    [candlePath moveToPoint:CGPointMake(xPostion, y)];
    [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth / 2.0f, y)];
    if (y > high) {
        [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth / 2.0f, high)];
        [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth / 2.0f, y)];
    }
    [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth, y)];
    [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth, y + height)];
    [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth / 2.0f, y + height)];
    if ((y + height) < low) {
        [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth / 2.0f, low)];
        [candlePath addLineToPoint:CGPointMake(xPostion + candleWidth / 2.0f, y+height)];
    }
    [candlePath addLineToPoint:CGPointMake(xPostion, y + height)];
    [candlePath addLineToPoint:CGPointMake(xPostion, y)];
    [candlePath closePath];
    return candlePath;
}

@end

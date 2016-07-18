//
//  UIColor+TNExtensions.m
//  TuNiuApp
//
//  Created by Panfeng on 16/2/5.
//  Copyright © 2016年 Tuniu. All rights reserved.
//

#import "UIColor+TNExtensions.h"

@implementation UIColor (TNExtensions)

// 根据16进制数设置颜色(默认alpha为1.0)
+ (UIColor *)tn_colorWithHex:(unsigned int)hex{
    return [UIColor tn_colorWithHex:hex alpha:1];
}

// 根据16进制数设置颜色
+ (UIColor *)tn_colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hex & 0xFF)) / 255.0
                           alpha:alpha];
}

// 根据16进制字符串设置颜色
+ (UIColor *)tn_colorwithHexString:(NSString *)hexString
{
    if (hexString.length == 0) {
        return [UIColor blackColor];
    }
    unsigned int hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&hex];
    return [UIColor tn_colorWithHex:hex];
}

// 根据16进制字符串设置颜色
+ (UIColor *)tn_colorwithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString.length == 0) {
        return [UIColor blackColor];
    }
    unsigned int hex = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&hex];
    return [UIColor tn_colorWithHex:hex alpha:alpha];
}

// 获取随机颜色
+ (UIColor*)tn_randomColor{
    
    NSInteger r = arc4random() % 255;
    NSInteger g = arc4random() % 255;
    NSInteger b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

// APP背景颜色(默认0xfefefc)
+ (UIColor*)tn_appBackgroundColor {
    
    return [UIColor tn_colorwithHexString:@"#fefefc"];
}

// APP通用深色
+ (UIColor*)tn_appBlackColor {
    
    return [UIColor colorWithRed:38.0/255.0 green:38.0/255.0 blue:38.0/255.0 alpha:1];
}

// APP通用浅色
+ (UIColor*)tn_appOffWhiteColor {
    
    return [UIColor colorWithRed:234.0/255.0 green:234.0/255.0 blue:234.0/255.0 alpha:1];
}

+ (UIColor *)tn_gradientColorImageFromColors:(NSArray*)colors gradientType:(TNGradientType)gradientType imgSize:(CGSize)imgSize{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case TNGradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case TNGradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case TNGradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case TNGradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    
    UIColor *color = [UIColor colorWithPatternImage:image];
    return color;
}

@end

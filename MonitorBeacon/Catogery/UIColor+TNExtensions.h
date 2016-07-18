//
//  UIColor+TNExtensions.h
//  TuNiuApp
//
//  Created by Panfeng on 16/2/5.
//  Copyright © 2016年 Tuniu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, TNGradientType) {
    TNGradientTypeTopToBottom = 0,//从上到小
    TNGradientTypeLeftToRight = 1,//从左到右
    TNGradientTypeUpleftToLowright = 2,//左上到右下
    TNGradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIColor (TNExtensions)

/**
 *  根据16进制数设置颜色(默认alpha为1.0)
 *
 *  @param hex 16进制数字(例如0xff0000)
 *
 *  @return 32位真彩色
 */
+ (UIColor *)tn_colorWithHex:(unsigned int)hex;

/**
 *  根据16进制数设置颜色
 *
 *  @param hex   16进制数字(例如0xff0000)
 *  @param alpha 透明度
 *
 *  @return 32位真彩色
 */
+ (UIColor *)tn_colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

/**
 *  根据16进制字符串设置颜色
 *
 *  @param hexString 16进制字符串(例如@"#ff0000"),hexString为空，默认返回黑色
 *
 *  @return 32位真彩色
 */
+ (UIColor *)tn_colorwithHexString:(NSString *)hexString;

/**
 *  根据16进制字符串设置颜色
 *
 *  @param hexString 16进制字符串(例如@"#ff0000"),hexString为空，默认返回黑色
 *  @param alpha     透明度
 *
 *  @return 32位真彩色
 */
+ (UIColor *)tn_colorwithHexString:(NSString *)hexString alpha:(CGFloat)alpha ;

/**
 *  获取随机颜色
 *
 *  @return 随机颜色
 */
+ (UIColor *)tn_randomColor;

/**
 *  APP背景颜色(默认0xfefefc)
 *
 *  @return APP背景颜色
 */
+ (UIColor *)tn_appBackgroundColor;

/**
 *  APP通用深色
 *
 *  @return APP通用深色
 */
+ (UIColor *)tn_appBlackColor;

/**
 *  APP通用浅色
 *
 *  @return APP通用浅色
 */
+ (UIColor *)tn_appOffWhiteColor;

/**
 *  生成渐变颜色
 *
 *  @param colors       颜色
 *  @param gradientType 类型
 *  @param imgSize      size
 *
 *  @return
 */
+ (UIColor *)tn_gradientColorImageFromColors:(NSArray*)colors gradientType:(TNGradientType)gradientType imgSize:(CGSize)imgSize;

@end






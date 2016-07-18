//
//  BRAppConfig.h
//  BeaconRN
//
//  Created by gaolong on 16/5/25.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+TNExtensions.h"

//简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:@"确定" \
otherButtonTitles:nil]; \
[alert show];

//----------方法简写-------
#define mAppDelegate        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define mWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define mKeyWindow          [[UIApplication sharedApplication] keyWindow]
#define mUserDefaults       [NSUserDefaults standardUserDefaults]
#define mNotificationCenter [NSNotificationCenter defaultCenter]
#define kFont(size) [UIFont systemFontOfSize:size]
#define kB_Font(size) [UIFont boldSystemFontOfSize:size]

#define WEAKEN(weakObjectName,object) __typeof__(object) __weak weakObjectName = object;
#define WEAKSELF() WEAKEN(weakSelf,self)

#define NSSTRING_NOT_NIL(value)  value ? value : @""

// block self
#define mWeakSelf  __weak typeof (self)weakSelf = self;
#define mStrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hexColorValue) [UIColor tn_colorWithHex:hexColorValue]

//----------颜色-------
// 常用颜色
#define COLOR_GREEN HEXCOLOR(0x33bd61)
#define COLOR_ORANGE HEXCOLOR(0xff7800)
#define COLOR_RED HEXCOLOR(0xff7c70)
#define COLOR_TEXT_DARK HEXCOLOR(0x333333)
#define COLOR_TEXT_GRAY HEXCOLOR(0x666666)
#define COLOR_TEXT_LIGHT_GRAY HEXCOLOR(0x999999)
#define COLOR_APP_BACKGROUND HEXCOLOR(0xededed)
#define COLOR_SEPARATOR HEXCOLOR(0xc6c6c6)
#define COLOR_SEPARATOR_LINE HEXCOLOR(0xd4d4d4)
#define COLOR_SUPER_ORANGE HEXCOLOR(0xfe9925)  /**< 浅橘黄色 */


/// 存储是否接受推送通知、是否有声音提示、是否震动提示，值为bool类型，程序第一次安装时，初始化为YES
static NSString *const kReceiveNotificationKey            = @"receiveNotificationKey";
static NSString *const kReceiveNotificationWithSoundKey   = @"receiveNotificationWithSoundKey";
static NSString *const kReceiveNotificationWithVibrateKey = @"receiveNotificationWithVibrateKey";
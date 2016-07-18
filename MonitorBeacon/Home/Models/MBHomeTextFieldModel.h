//
//  MBHomeTextFieldModel.h
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBHomeBeaconResponse;
typedef NS_ENUM(NSInteger, MBHomeTextFieldType) {
    MBHomeTextFieldTypeNone,
    MBHomeTextFieldTypeUUID,
    MBHomeTextFieldTypeMajor,
    MBHomeTextFieldTypeMinor,
};

typedef NS_ENUM(NSInteger, MBHomeCellType)
{
    MBHomeCellTypeTextField,
    MBHomeCellTypeConfirmButton,
    MBHomeCellTypeResult,
};

@interface MBHomeTextFieldModel : NSObject
@property (nonatomic, assign) MBHomeTextFieldType textFieldType;
@property (nonatomic, assign) MBHomeCellType cellType;
@property (nonatomic, strong) MBHomeBeaconResponse *response;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, strong) NSString *keyString;
@property (nonatomic, strong) NSString *valueString;

- (instancetype)initTextFieldModelWith:(MBHomeTextFieldType)type
                                 title:(NSString *)title
                           placeHolder:(NSString *)placeHolder
                             keyString:(NSString *)keyString
                           valueString:(NSString *)valueString
                              cellType:(MBHomeCellType)cellType;
@end


@interface MBHomeBeaconModel : NSObject

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *major;
@end

@interface MBHomeBeaconResponse : NSObject
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) id data;
@end
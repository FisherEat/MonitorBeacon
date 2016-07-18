//
//  MBHomeTextFieldModel.m
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "MBHomeTextFieldModel.h"

@implementation MBHomeTextFieldModel
- (instancetype)initTextFieldModelWith:(MBHomeTextFieldType)type
                                 title:(NSString *)title
                           placeHolder:(NSString *)placeHolder
                             keyString:(NSString *)keyString
                           valueString:(NSString *)valueString
                              cellType:(MBHomeCellType)cellType
{
    self = [super init];
    self.textFieldType = type;
    self.title = title;
    self.keyString = keyString;
    self.valueString = valueString;
    self.placeHolder = placeHolder;
    self.cellType = cellType;
    return self;
}
@end

@implementation MBHomeBeaconModel

@end

@implementation MBHomeBeaconResponse

@end

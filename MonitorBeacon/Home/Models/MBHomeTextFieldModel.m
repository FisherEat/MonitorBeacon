//
//  MBHomeTextFieldModel.m
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "MBHomeTextFieldModel.h"

@implementation MBHomeBeaconCellModel

- (instancetype)initWithCellType:(MBHomeCellType)cellType model:(id)cellModel
{
    if (self = [super init]) {
        self.cellType = cellType;
        self.model = cellModel;
    }
    return self;
}

@end

@implementation MBHomeTextFieldModel
- (instancetype)initTextFieldModelWith:(MBHomeTextFieldType)type
                                 title:(NSString *)title
                           placeHolder:(NSString *)placeHolder
                           valueString:(NSString *)valueString
{
    self = [super init];
    self.textFieldType = type;
    self.title = title;
    self.valueString = valueString;
    self.placeHolder = placeHolder;
    return self;
}
@end

@implementation MBHomeBeaconModel

@end

@implementation MBHomeBeaconResponse

@end

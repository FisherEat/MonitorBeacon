//
//  MBHomeHistoryModel.h
//  MonitorBeacon
//
//  Created by schiller on 16/7/19.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBHomeTextFieldModel.h"

@class MBHomeBeaconModel;
@interface MBHomeHistoryModel : NSObject
+ (MBHomeHistoryModel *)shareHistory;

- (void)addHistoryInterval:(MBHomeBeaconModel *)model;
- (void)clearHistory;
- (NSArray *)beaconHistory;

@end

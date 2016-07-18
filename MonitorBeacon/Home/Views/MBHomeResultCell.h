//
//  MBHomeResultCell.h
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBHomeTextFieldModel.h"

@interface MBHomeResultCell : UITableViewCell
@property (nonatomic, strong) UILabel *uuidLabel;
@property (nonatomic, strong) UILabel *majorLabel;
@property (nonatomic, strong) UILabel *minorLabel;
@property (nonatomic, strong) UILabel *remarkLabel;
- (void)bindModel:(id)model;
@end

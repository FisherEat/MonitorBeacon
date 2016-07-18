//
//  MBHomeBeaconTextFieldCellTableViewCell.h
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBHomeTextFieldModel.h"

@protocol MBHomeTextFieldDelegate<NSObject>

- (void)mb_textFieldDidEndEdit:(MBHomeTextFieldModel *)model;

@end

@interface MBHomeBeaconTextFieldCellTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MBHomeTextFieldModel *tfModel;
@property (nonatomic, weak) id <MBHomeTextFieldDelegate>delegate;
- (void)bindModel:(MBHomeTextFieldModel *)model;
@end

//
//  MBHomeConfirmButtonCellTableViewCell.h
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBHomeConfirmButtonCellDelegate <NSObject>

- (void)confirmButtonDidSelected;
@end

@interface MBHomeConfirmButtonCellTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, weak) id<MBHomeConfirmButtonCellDelegate>delegate;
@end

//
//  MBHomeConfirmButtonCellTableViewCell.m
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "MBHomeConfirmButtonCellTableViewCell.h"
#import "PureLayout.h"
#import "BRAppConfig.h"

@implementation MBHomeConfirmButtonCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self.contentView addSubview:self.confirmBtn];
    [self.confirmBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 50, 10, 50)];
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton newAutoLayoutView];
        _confirmBtn.layer.backgroundColor = COLOR_SUPER_ORANGE.CGColor;
        _confirmBtn.layer.cornerRadius = 3.0;
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"确认搜索" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)confirm
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmButtonDidSelected)]) {
        [self.delegate confirmButtonDidSelected];
    }
}
@end

//
//  MBHomeResultCell.m
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "MBHomeResultCell.h"
#import "PureLayout.h"
#import "BRAppConfig.h"

@interface MBHomeResultCell ()

@end
@implementation MBHomeResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self.contentView addSubview:self.remarkLabel];
    
    [self.remarkLabel autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
    [self.remarkLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0];
}

- (void)bindModel:(MBHomeBeaconResponse *)model
{
    if (!model && !model.data && model.data) {
        _remarkLabel.text = [NSString stringWithFormat:@"查询结果remark：%@",model.data];
    }else {
        _remarkLabel.text = [NSString stringWithFormat:@"发生错误%@", model.message];
    }
}

- (UILabel *)remarkLabel
{
    if (!_remarkLabel) {
        _remarkLabel = [UILabel newAutoLayoutView];
        _remarkLabel.textColor = [UIColor grayColor];
        _remarkLabel.font = kFont(14);
    }
    return _remarkLabel;
}
@end

//
//  MBHomeBeaconTextFieldCellTableViewCell.m
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "MBHomeBeaconTextFieldCellTableViewCell.h"
#import "PureLayout.h"
#import "BRAppConfig.h"

@implementation MBHomeBeaconTextFieldCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.inputTextField];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0];
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.inputTextField autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLabel withOffset:10.0];
    [self.inputTextField autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0];
    [self.inputTextField autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.inputTextField autoSetDimension:ALDimensionHeight toSize:40.0];
    
}

- (void)bindModel:(id)model
{
    if (![model isKindOfClass:[MBHomeTextFieldModel class]] || !model) {
        return;
    }
    self.tfModel = (MBHomeTextFieldModel *)model;
    
    self.titleLabel.text = self.tfModel.title;
    self.inputTextField.placeholder = self.tfModel.placeHolder;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = kFont(14);
        _titleLabel.textColor = [UIColor grayColor];
    }
    
    return _titleLabel;
}

- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [UITextField newAutoLayoutView];
        _inputTextField.backgroundColor = [UIColor clearColor];
        _inputTextField.delegate = self;
        _inputTextField.font = kFont(14);
        _inputTextField.layer.borderWidth = 1.0;
        _inputTextField.layer.cornerRadius = 3.0;
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _inputTextField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.tfModel.valueString = [NSString stringWithFormat:@"%@%@",textField.text, string];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tfModel.valueString = textField.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mb_textFieldDidEndEdit:)]) {
        [self.delegate mb_textFieldDidEndEdit:self.tfModel];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

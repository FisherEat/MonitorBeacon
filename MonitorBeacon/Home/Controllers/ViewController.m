//
//  ViewController.m
//  MonitorBeacon
//
//  Created by gaolong on 16/7/17.
//  Copyright © 2016年 gaolong. All rights reserved.
//

#import "ViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "PureLayout.h"

#import "MBHomeBeaconTextFieldCellTableViewCell.h"
#import "MBHomeConfirmButtonCellTableViewCell.h"
#import "MBHomeResultCell.h"

#import "MBHomeTextFieldModel.h"
#import "BRAppConfig.h"
#import "TWURLRequest.h"
#import "MJExtension.h"

NSString *const textFieldCellIdentifier = @"MBHomeBeaconTextFieldCellTableViewCell";
NSString *const confirmButtonCellIdentifier = @"MBHomeConfirmButtonCellTableViewCell.h";
NSString *const resultCellIndentifier = @"MBHomeResultCell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MBHomeTextFieldDelegate, MBHomeConfirmButtonCellDelegate>
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MBHomeBeaconModel *beaconModel;
@property (nonatomic, strong) UIButton *sendMsgBtn;
@property (nonatomic, strong) UIButton *clearBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.beaconModel = [MBHomeBeaconModel new];
    [self constructData];
    [self setUpViews];
}

- (void)setUpViews
{
    [self setUpTabelView];
    [self setUpButtons];
}

- (void)setUpTabelView
{
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:64.5];
}

- (void)setUpButtons
{
    [self.view addSubview:self.sendMsgBtn];
    [self.view addSubview:self.clearBtn];
    
    [self.sendMsgBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.sendMsgBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0];
    [self.sendMsgBtn autoSetDimensionsToSize:CGSizeMake(100, 40)];
    
    [self.clearBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.clearBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0];
    [self.clearBtn autoSetDimensionsToSize:CGSizeMake(100, 40)];
}

- (void)constructData
{
    [self.dataArray removeAllObjects];
    MBHomeTextFieldModel *uuidModel = [[MBHomeTextFieldModel alloc] initTextFieldModelWith:MBHomeTextFieldTypeUUID title:@"UUID:" placeHolder:@"必填，UUID"  valueString:@""];
    MBHomeBeaconCellModel *uuidCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeTextField model:uuidModel];
    [self.dataArray addObject:uuidCellModel];
    
    
    MBHomeTextFieldModel *majorModel = [[MBHomeTextFieldModel alloc] initTextFieldModelWith:MBHomeTextFieldTypeMajor title:@"Major:" placeHolder:@"major, 必填" valueString:@""];
    MBHomeBeaconCellModel *majorCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeTextField model:majorModel];
    [self.dataArray addObject:majorCellModel];
    
    MBHomeTextFieldModel *minorModel = [[MBHomeTextFieldModel alloc]initTextFieldModelWith:MBHomeTextFieldTypeMinor title:@"Minor:" placeHolder:@"Minor, 必填" valueString:@""];
    MBHomeBeaconCellModel *minorCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeTextField model:minorModel];
    [self.dataArray addObject:minorCellModel];
    
    MBHomeBeaconCellModel *confirmCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeConfirmButton model:nil];
    [self.dataArray addObject:confirmCellModel];
}

- (TPKeyboardAvoidingTableView *)tableView
{
    if (!_tableView) {
        _tableView = [TPKeyboardAvoidingTableView newAutoLayoutView];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.allowsSelection = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MBHomeBeaconTextFieldCellTableViewCell class] forCellReuseIdentifier:textFieldCellIdentifier];
        [_tableView registerClass:[MBHomeConfirmButtonCellTableViewCell class] forCellReuseIdentifier:confirmButtonCellIdentifier];
        [_tableView registerClass:[MBHomeResultCell class] forCellReuseIdentifier:resultCellIndentifier];
    }
    return _tableView;
}

- (UIButton *)sendMsgBtn
{
    if (!_sendMsgBtn) {
        _sendMsgBtn = [UIButton newAutoLayoutView];
        [_sendMsgBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        [_sendMsgBtn setTitleColor:HEXCOLOR(0x00c988) forState:UIControlStateNormal];
        [_sendMsgBtn addTarget:self action:@selector(sendBeaconMsg) forControlEvents:UIControlEventTouchUpInside];
        _sendMsgBtn.titleLabel.font = kFont(16);
    }
    return _sendMsgBtn;
}

- (UIButton *)clearBtn
{
    if (!_clearBtn) {
        _clearBtn = [UIButton newAutoLayoutView];
        [_clearBtn setTitle:@"清空输入框" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:HEXCOLOR(0x00c988) forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearAllInput) forControlEvents:UIControlEventTouchUpInside];
        _clearBtn.titleLabel.font = kFont(16);
    }
    return _clearBtn;
}

- (void)sendBeaconMsg
{
    
}

- (void)clearAllInput
{
    [self.dataArray removeAllObjects];
    self.beaconModel = [MBHomeBeaconModel new];
    [self constructData];
    [self.tableView reloadData];
}

- (BOOL)validateInputTexts
{
    if ([self isNilOrEmpty:self.beaconModel.uuid]) {
        mAlertView(@"Error", @"请输入UUID值")
        return NO;
    }
    if ([self isNilOrEmpty:self.beaconModel.major]) {
        mAlertView(@"Error", @"请输入Major值")
        return NO;
    }
    if ([self isNilOrEmpty:self.beaconModel.minor]) {
        mAlertView(@"Error", @"请输入Minor值");
        return NO;
    }
    return YES;
}

- (BOOL)isNilOrEmpty:(NSString *)str{
    if (!str || ![str isKindOfClass:[NSString class]]|| [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    MBHomeBeaconCellModel *cellModel = self.dataArray[indexPath.row];
    switch (cellModel.cellType) {
        case MBHomeCellTypeTextField:
        {
            MBHomeBeaconTextFieldCellTableViewCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:textFieldCellIdentifier forIndexPath:indexPath];
            [textFieldCell bindModel:cellModel.model];
            textFieldCell.delegate = self;
            cell = textFieldCell;
        }
            break;
        case MBHomeCellTypeConfirmButton:
        {
            MBHomeConfirmButtonCellTableViewCell *confirmButtonCell = [tableView dequeueReusableCellWithIdentifier:confirmButtonCellIdentifier forIndexPath:indexPath];
            confirmButtonCell.delegate = self;
            cell = confirmButtonCell;
        }
            break;
        case MBHomeCellTypeResult:
        {
            MBHomeResultCell *resultCell = [tableView dequeueReusableCellWithIdentifier:resultCellIndentifier forIndexPath:indexPath];
            [resultCell bindModel:cellModel.model];
            cell = resultCell;
        }
            break;
        default:
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIdentifier"];
        }
            break;
    }
    
    return cell;
}


#pragma mark - MBHomeTextFieldDelegate
- (void)mb_textFieldDidEndEdit:(MBHomeTextFieldModel *)model
{
    switch (model.textFieldType) {
        case MBHomeTextFieldTypeUUID:
        {
            self.beaconModel.uuid = model.valueString;
        }
            break;
        case MBHomeTextFieldTypeMajor:
        {
            self.beaconModel.major = model.valueString;
        }
            break;
            
        case MBHomeTextFieldTypeMinor:
        {
            self.beaconModel.minor = model.valueString;
        }
            break;
        default:
            break;
    }
}

#pragma mark - MBHomeConfirmButtonCellDelegate
- (void)confirmButtonDidSelected
{
    if (![self validateInputTexts]) {
        return;
    }
    NSDictionary *params = @{@"uuid": NSSTRING_NOT_NIL(self.beaconModel.uuid),
                             @"major": NSSTRING_NOT_NIL(self.beaconModel.major),
                             @"minor": NSSTRING_NOT_NIL(self.beaconModel.minor)};
    WEAKSELF();
    [TWURLRequest post:@"http://114.55.67.228:9090/beacon/info" params:params completionHandler:^(id data, NSError *error) {
        if (error) {
            mAlertView(@"Error", @"接口或者查询错误");
            return ;
        }

        [weakSelf updateResultData:data];
        
    }];
}

- (void)updateResultData:(id)response
{
    MBHomeBeaconResponse *responseData = [MBHomeBeaconResponse mj_objectWithKeyValues:response];
    MBHomeBeaconCellModel *cellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeResult model:responseData];
    
    if (self.dataArray.count == 4) {
        [self.dataArray addObject:cellModel];
        [self.tableView reloadData];
    }else {
        [self.dataArray replaceObjectAtIndex:4 withObject:cellModel];
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

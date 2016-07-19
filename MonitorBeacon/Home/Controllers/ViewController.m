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
#import "MBHomeHistoryModel.h"

NSString *const textFieldCellIdentifier = @"MBHomeBeaconTextFieldCellTableViewCell";
NSString *const confirmButtonCellIdentifier = @"MBHomeConfirmButtonCellTableViewCell.h";
NSString *const resultCellIndentifier = @"MBHomeResultCell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, MBHomeTextFieldDelegate, MBHomeConfirmButtonCellDelegate>
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) MBHomeBeaconModel *beaconModel;
@property (nonatomic, strong) UIButton *clearHistoryBtn;
@property (nonatomic, strong) UIButton *clearBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.beaconModel = [MBHomeBeaconModel new];
    [self initDataDic];
    [self constructInputData];
    [self setUpViews];
}

- (void)initDataDic
{
    self.dataDic = [NSMutableDictionary dictionary];
    self.dataDic[@(MBHomeSectionTypeInput)] = [NSMutableArray array];
    self.dataDic[@(MBHomeSectionTypeResult)] = [NSMutableArray array];
    self.dataDic[@(MBHomeSectionTypeHistory)]  = [NSMutableArray array];
}

- (void)historyData
{
    
}

#pragma mark - init views
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
    [self.view addSubview:self.clearHistoryBtn];
    [self.view addSubview:self.clearBtn];
    
    [self.clearHistoryBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.clearHistoryBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20.0];
    [self.clearHistoryBtn autoSetDimensionsToSize:CGSizeMake(100, 40)];
    
    [self.clearBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [self.clearBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20.0];
    [self.clearBtn autoSetDimensionsToSize:CGSizeMake(100, 40)];
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

- (UIButton *)clearHistoryBtn
{
    if (!_clearHistoryBtn) {
        _clearHistoryBtn = [UIButton newAutoLayoutView];
        [_clearHistoryBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        [_clearHistoryBtn setTitleColor:HEXCOLOR(0x00c988) forState:UIControlStateNormal];
        [_clearHistoryBtn addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
        _clearHistoryBtn.titleLabel.font = kFont(16);
    }
    return _clearHistoryBtn;
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

#pragma mark - construct or update dataDic
- (void)constructInputData
{
    NSMutableArray *dataArray = self.dataDic[@(MBHomeSectionTypeInput)];
    [dataArray removeAllObjects];
    
    MBHomeTextFieldModel *uuidModel = [[MBHomeTextFieldModel alloc] initTextFieldModelWith:MBHomeTextFieldTypeUUID title:@"UUID:" placeHolder:@"必填，UUID"  valueString:@""];
    MBHomeBeaconCellModel *uuidCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeTextField model:uuidModel];
    [dataArray addObject:uuidCellModel];
    
    MBHomeTextFieldModel *majorModel = [[MBHomeTextFieldModel alloc] initTextFieldModelWith:MBHomeTextFieldTypeMajor title:@"Major:" placeHolder:@"major, 必填" valueString:@""];
    MBHomeBeaconCellModel *majorCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeTextField model:majorModel];
    [dataArray addObject:majorCellModel];
    
    MBHomeTextFieldModel *minorModel = [[MBHomeTextFieldModel alloc]initTextFieldModelWith:MBHomeTextFieldTypeMinor title:@"Minor:" placeHolder:@"Minor, 必填" valueString:@""];
    MBHomeBeaconCellModel *minorCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeTextField model:minorModel];
    [dataArray addObject:minorCellModel];
    
    MBHomeBeaconCellModel *confirmCellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeConfirmButton model:nil];
    [dataArray addObject:confirmCellModel];
    
    self.dataDic[@(MBHomeSectionTypeInput)] = dataArray;
}

- (void)updateResultData:(MBHomeBeaconResponse *)response
{
    [self constructResultData:response];
    [self.tableView reloadData];
}

- (void)constructResultData:(MBHomeBeaconResponse *)response
{
    NSMutableArray *resultArray = self.dataDic[@(MBHomeSectionTypeResult)];
    [resultArray removeAllObjects];
    MBHomeBeaconCellModel *cellModel = [[MBHomeBeaconCellModel alloc] initWithCellType:MBHomeCellTypeResult model:response];
    [resultArray addObject:cellModel];
    self.dataDic[@(MBHomeSectionTypeResult)] = resultArray;
}

#pragma mark - methods deal with data
- (void)clearHistory
{
    [[MBHomeHistoryModel shareHistory] clearHistory];
}

- (void)clearAllInput
{
    self.beaconModel = [MBHomeBeaconModel new];
    [self constructInputData];
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

#pragma mark - UITabelViewDelegate & UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataDic.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *rows = self.dataDic[@(section)];
    return rows.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    NSMutableArray *rows = self.dataDic[@(indexPath.section)];
    
    MBHomeBeaconCellModel *cellModel = rows[indexPath.row];
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
    
   [[MBHomeHistoryModel shareHistory] addHistoryInterval:self.beaconModel];
    
    NSDictionary *params = @{@"uuid": NSSTRING_NOT_NIL(self.beaconModel.uuid),
                             @"major": NSSTRING_NOT_NIL(self.beaconModel.major),
                             @"minor": NSSTRING_NOT_NIL(self.beaconModel.minor)};
    WEAKSELF();
    [TWURLRequest post:@"http://114.55.67.228:9090/beacon/info" params:params completionHandler:^(id data, NSError *error) {
        if (error) {
            mAlertView(@"Error", @"接口或者查询错误");
            return ;
        }
        
        MBHomeBeaconResponse *responseData = [MBHomeBeaconResponse mj_objectWithKeyValues:data];
        [weakSelf updateResultData:responseData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

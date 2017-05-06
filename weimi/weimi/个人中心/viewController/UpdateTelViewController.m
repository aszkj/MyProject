
//
//  UpdateTelViewController.m
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "UpdateTelViewController.h"
#import "UpdateUserInfoTableViewCell.h"
#import <WEMEUsercontrollerApi.h>

@interface UpdateTelViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSTimer *_getVeryCodeTimer;
    NSInteger _veryCodeSeconds;
}

@property (nonatomic, strong) UpdateUserInfoTableViewCell *updateTelCell;
@property (nonatomic, strong) UpdateUserInfoTableViewCell *updateCodeCell;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *tableViewFooter;
@property (nonatomic, strong) UIButton *updateBtn;

@end

NSString *const UpdateUserTelCell = @"UpdateUserInfoTableViewCell";

@implementation UpdateTelViewController

-(void)dealloc
{
    [kNotification removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.view.backgroundColor = kWhiteColor;
    self.title = @"修改手机号码";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.updateBtn];
    [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(140/3));
        make.top.equalTo(self.tableView.mas_bottom).with.offset(8);
        make.left.equalTo(@KLeftMargin);
        make.right.equalTo(@-KLeftMargin);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(@130);
    }];
    
    [kNotification addObserver:self selector:@selector(contentTextChange) name:UITextFieldTextDidChangeNotification object:nil];
}

#pragma mark - getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = updateUserInfoCellHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UpdateUserInfoTableViewCell class] forCellReuseIdentifier:UpdateUserTelCell];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"UpdateTel"],@"placeholder":@"请输入您的手机号码"}];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"UpdateTel_yanzhengma"],@"placeholder":@"请输入验证码"}];
    }
    return _dataSource;
}
-(UIButton *)updateBtn
{
    if (!_updateBtn) {
        _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _updateBtn.enabled = NO;
        [_updateBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_updateBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
//        [_updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBack"] forState:UIControlStateNormal];
//        [_updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBack_select"] forState:UIControlStateSelected];
        _updateBtn.layer.cornerRadius = 5.0;
        _updateBtn.backgroundColor = chatStatus_Color;
        [_updateBtn addTarget:self action:@selector(updateTel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}
-(UIView *)tableViewFooter
{
    if (!_tableViewFooter) {
        _tableViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140/3 + 30)];
        _tableViewFooter.backgroundColor = [UIColor clearColor];
        
    }
    return _tableViewFooter;
}

-(UpdateUserInfoTableViewCell *)updateTelCell
{
    if (!_updateTelCell) {
        _updateTelCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    return _updateTelCell;
}
-(UpdateUserInfoTableViewCell *)updateCodeCell
{
    if (!_updateCodeCell) {
        _updateCodeCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    }
    return _updateCodeCell;
}


#pragma mark - private methord

#pragma mark - 修改手机号码
- (void)updateTel:(UIButton *)update
{
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud show:YES];
    WEAK_SELF
    [[WEMEUsercontrollerApi sharedAPI] changephoneUsingGETWithCompletionBlock:self.updateTelCell.textField.text code:self.updateCodeCell.textField.text completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        if (IsEmpty(error) && output.success.integerValue == YES)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"修改手机号码成功";
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            if (weak_self.updateTelBlock)
            {
                weak_self.updateTelBlock(weak_self.updateTelCell.textField.text);
            }
            [weak_self.navigationController popViewControllerAnimated:YES];
            
        }
        else
        {
            [NSError checkErrorFromServer:error response:output];
        }
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];

    }];
    NSLog(@"修改手机号码");    
}

#pragma mark - 发送验证码
-(void)sendVeryCodeTimer{

    if (![Util isValidateMobile:self.updateTelCell.textField.text])
    {
        [Util ShowAlertWithOnlyMessage:@"手机号码输入有误"];
        self.updateTelCell.textField.text = @"";
        self.updateCodeCell.textField.text = @"";
        return;
    }
    
    WEAK_SELF
    [[WEMEUsercontrollerApi sharedAPI] changePhoneverifycodeUsingGETWithCompletionBlock :self.updateTelCell.textField.text completionHandler:^(WEMESimpleResponse *output, NSError *error) {
        if (IsEmpty(error) && output.success.integerValue == YES)
        {
            _veryCodeSeconds = 60;
            weak_self.updateCodeCell.identifyingBtn.enabled = NO;
            _getVeryCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weak_self selector:@selector(subVeryCodeSeconds) userInfo:nil repeats:YES];
        }
        else
        {
            [NSError checkErrorFromServer:error response:output];
        }
    }];
}


-(void)subVeryCodeSeconds {
    
    _veryCodeSeconds -- ;
    
    UpdateUserInfoTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString *title = nil;
    if (!_veryCodeSeconds)
    {
        cell2.identifyingBtn.enabled = YES;
        [_getVeryCodeTimer invalidate];
        _getVeryCodeTimer = nil;
        
        title = @"重新发送";
        [cell2.identifyingBtn setTitle:title forState:UIControlStateNormal];
    }else {
        title = [NSString stringWithFormat:@"重新发送(%lds)",_veryCodeSeconds];
    }
    cell2.identifyingBtn.titleLabel.text = title;
    [cell2.identifyingBtn setTitle:title forState:UIControlStateDisabled];
}

- (void)contentTextChange
{
    UpdateUserInfoTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UpdateUserInfoTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (IsEmpty(cell1.textField.text) || IsEmpty(cell2.textField.text))
    {
        _updateBtn.selected = NO;
        _updateBtn.enabled = NO;
    }
    else
    {
        _updateBtn.selected = YES;
        _updateBtn.enabled = YES;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UpdateUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UpdateUserTelCell];
    if (self.dataSource.count > indexPath.row) {
        NSDictionary *dataDict = _dataSource[indexPath.row];
        cell.titleImageView.image = dataDict[@"image"];
        cell.textField.placeholder = dataDict[@"placeholder"];
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        cell.textField.secureTextEntry = NO;
        if ([dataDict[@"placeholder"] rangeOfString:@"验证码"].length > 0)
        {
            WEAK_SELF
            cell.identifyingBtn.hidden = NO;
            cell.sendIdentifyingBlcok = ^(){
                [weak_self sendVeryCodeTimer];
            };
        }
    }
    return cell;
}





@end

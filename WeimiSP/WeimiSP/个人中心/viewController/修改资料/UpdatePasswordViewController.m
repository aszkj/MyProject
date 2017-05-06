//
//  UpdatePasswordViewController.m
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "UpdateUserInfoTableViewCell.h"
#import <WEMEUsercontrollerApi.h>

@interface UpdatePasswordViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *tableViewFooter;
@property (nonatomic, strong) UIButton *updateBtn;

@end

NSString *const UpdateUserCell = @"UpdateUserInfoTableViewCell";

@implementation UpdatePasswordViewController
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
    self.view.backgroundColor = VCBackgroundColor;
    self.title = @"修改密码";
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
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
        _tableView.tableFooterView = self.tableViewFooter;
        _tableView.rowHeight = updateUserInfoCellHeight;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_tableView setSeparatorColor:UIColorFromRGB(0xe5e5e5)];
        [_tableView registerClass:[UpdateUserInfoTableViewCell class] forCellReuseIdentifier:UpdateUserCell];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"UpdatePassword_xiu"],@"placeholder":@"请输入旧密码"}];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"UpdatePassword_new"],@"placeholder":@"请输入新密码"}];
        [_dataSource addObject:@{@"image":[UIImage imageNamed:@"UpdatePassword_new"],@"placeholder":@"请输入新密码"}];
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
        [_updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBack"] forState:UIControlStateNormal];
        [_updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBack_select"] forState:UIControlStateSelected];
        [_updateBtn addTarget:self action:@selector(updatePassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateBtn;
}
-(UIView *)tableViewFooter
{
    if (!_tableViewFooter) {
        _tableViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 140/3 + 30)];
        _tableViewFooter.backgroundColor = [UIColor clearColor];
        [_tableViewFooter addSubview:self.updateBtn];
        [_updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(140/3));
            make.bottom.equalTo(@0);
            make.left.equalTo(@KLeftMargin);
            make.right.equalTo(@-KLeftMargin);
        }];
    }
    return _tableViewFooter;
}

#pragma mark - private methord

#pragma mark - 修改用户密码
- (void)updatePassword:(UIButton *)update
{
    UpdateUserInfoTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UpdateUserInfoTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UpdateUserInfoTableViewCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if ([cell2.textField.text isEqualToString:cell3.textField.text])
    {
        NSLog(@"修改密码");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud show:YES];
        [self.view endEditing:YES];
        WEAK_SELF
        [[WEMEUsercontrollerApi sharedAPI] changepasswordUsingGETWithCompletionBlock:cell1.textField.text password:cell2.textField.text completionHandler:^(WEMESimpleResponse *output, NSError *error) {
            if (IsEmpty(error) && output.success.integerValue == YES)
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"新密码修改成功";
                hud.margin = 10.f;
                hud.yOffset = 150.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1];
                [weak_self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [NSError checkErrorFromServer:error response:output];
            }
//                if (!IsEmpty(output.errorDescription))
//            {
//                [Util ShowAlertWithOnlyMessage:output.errorDescription];
//            }
//            else
//            {
//                [Util ShowAlertWithOnlyMessage:@"修改密码失败，请检查网络..."];
//            }
            [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码输入不一致，请重新输入..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        cell1.textField.text = @"";
        cell2.textField.text = @"";
        cell3.textField.text = @"";
    }
    
}
- (void)contentTextChange
{
    UpdateUserInfoTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UpdateUserInfoTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UpdateUserInfoTableViewCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (IsEmpty(cell1.textField.text) || IsEmpty(cell2.textField.text) || IsEmpty(cell3.textField.text))
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
    UpdateUserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UpdateUserCell];
    if (self.dataSource.count > indexPath.row) {
        NSDictionary *dataDict = _dataSource[indexPath.row];
        cell.titleImageView.image = dataDict[@"image"];
        cell.textField.placeholder = dataDict[@"placeholder"];
    }
    return cell;
}

    

@end

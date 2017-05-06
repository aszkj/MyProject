//
//  WMERSearchViewController.m
//  jingGang
//
//  Created by thinker on 15/10/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WMERSearchViewController.h"
#import "Util.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "PublicInfo.h"
#import "IQKeyboardManager.h"
#import "WInputMERViewController.h"
#import "WMERResultViewController.h"
#import "WInputXingViewController.h"

@interface WMERSearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic  ) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UITextField *SearchContentTextField;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WMERSearchViewController

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"itemName"];
    cell.textLabel.textColor = UIColorFromRGB(0X666666);
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self hiddenKey];
    NSLog(@"select ---- %ld",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = self.dataSource[indexPath.row];
    if ([dict[@"type"] intValue] == 1) {
        WInputXingViewController *VC = [[WInputXingViewController alloc] initWithNibName:@"WInputXingViewController" bundle:nil];
        VC.api_itemId = dict[@"id"];
        [self.navigationController pushViewController:VC animated:YES];
    }
    else
    {
        WInputMERViewController *VC = [[WInputMERViewController alloc] initWithNibName:@"WInputMERViewController" bundle:nil];
        VC.api_itemId = dict[@"id"];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma makr - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self requestData];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 网络请求数据
- (void)requestData
{
    if (![Util varifyValidOfStr:self.SearchContentTextField.text]) {
        return;
    }
    [self.dataSource removeAllObjects];
    
    ReportSearchRequest *searchRequest = [[ReportSearchRequest alloc] init:GetToken];
    searchRequest.api_name = self.SearchContentTextField.text;
    WEAK_SELF
    [self.vapiManager reportSearch:searchRequest success:^(AFHTTPRequestOperation *operation, ReportSearchResponse *response) {
        NSLog(@"search ---- %@",response);
        for (NSDictionary *dict in response.resultItemBOs) {
            [weak_self.dataSource addObject:dict];
        }
        [weak_self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ceshi ---- %@",error);
        [weak_self errorHandle:error];
    }];
}

#pragma mark - 实例化UI
- (void)initUI
{
    self.dataSource = [NSMutableArray array];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    //搜索框
    self.SearchContentTextField = [[UITextField alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 100, __StatusScreen_Height + 5 , 200, 30)];
    self.SearchContentTextField.placeholder = @"请输入搜索内容";
    self.SearchContentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.SearchContentTextField.delegate = self;
    self.SearchContentTextField.returnKeyType = UIReturnKeySearch;
    self.SearchContentTextField.textColor = [UIColor whiteColor];
    self.SearchContentTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.SearchContentTextField.backgroundColor = UIColorFromRGB(0X42aad6);
    self.navigationItem.titleView = self.SearchContentTextField;

    //取消按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"搜索" forState:UIControlStateSelected];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 25);
    [rightBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;

    self.view.backgroundColor = background_Color;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
//返回上一级界面
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)hiddenKey
{
    [self.SearchContentTextField resignFirstResponder];
}

#pragma mark - 取消按钮
- (void)cancel:(UIButton *)btn
{
    NSLog(@"cancel");
    [self requestData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
//    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
//    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:NO];
}

@end

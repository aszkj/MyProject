//
//  KeyWordSearchController.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/30.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "KeyWordSearchController.h"
#import "ComplainModel.h"
#import "ComplainCell.h"
#import "ComplainDetailController.h"
@interface KeyWordSearchController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

/**
 *  --导航搜索栏
 */
@property (strong,nonatomic) UITextField *searchTextField;

/**
 *  页数
 */
@property (nonatomic,strong)   NSNumber *pageNum;
/**
 *  搜索出来的数组
 */
@property (nonatomic,strong)  NSMutableArray *arraySearchData;
@property (nonatomic,strong)  UITableView *tableview;
@end

@implementation KeyWordSearchController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 100, __StatusScreen_Height + 5 , 200, 30)];
    self.searchTextField.placeholder = @"请输入搜索内容";
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.delegate = self;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.textColor = [UIColor whiteColor];
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.backgroundColor = UIColorFromRGB(0X42aad6);
    self.navigationItem.titleView = self.searchTextField;
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchTextField becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupContent];
}

// 初始化界面--
- (void)setupContent {
    //点击搜索按钮
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 40, kNavBarAndStatusBarHeight-15)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = rightBar;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [self.view addSubview:self.tableview];
}

/**
 *  监听用户点击搜索的事件 --
 */
- (void)searchClick {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.pageNum = [NSNumber numberWithInteger:1];
    [self netWorkRequestList];
}

- (void)netWorkRequestList
{
    WEAK_SELF
    VApiManager *netManaget = [[VApiManager alloc]init];
    
    ComplaintsUsersListRequest *request = [[ComplaintsUsersListRequest alloc]init:GetToken];
    
    request.api_status = [NSNumber numberWithInteger:self.complainStatus];
    //    1处理中，新投诉    3已完成
    request.api_pageNum = self.pageNum;
    
    request.api_pageSize = [NSNumber numberWithInteger:10];
    
    request.api_name = [NSString stringWithFormat:@"%@",self.searchTextField.text];
    
    [netManaget complaintsUsersList:request success:^(AFHTTPRequestOperation *operation, ComplaintsUsersListResponse *response) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response keyValues]];
        
        [weak_self setupDataWithIsCompletedWithDic:dic];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];

}

/**
 *  处理数据源
 *
 */
- (void)setupDataWithIsCompletedWithDic:(NSDictionary *)dic{
    
    NSArray *array = [NSArray arrayWithArray:dic[@"groupComplaintBOs"]];
    
    

    [self.arraySearchData removeAllObjects];
            for (NSInteger i = 0; i < array.count; i++) {
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:array[i]];
                [self.arraySearchData addObject:[ComplainModel objectWithKeyValues:dict]];
            }
        //假数据
//    for (NSInteger i = 0; i < 6; i++) {
//        ComplainModel *model = [[ComplainModel alloc]init];
//        model.name = @"哈哈哈";
//        model.id   = @"12";
//        model.storeName = @"太平洋";
//        model.addTime = @"1900-10-10 10:10";
//        if (self.complainStatus == 1) {
//            model.isHandled = YES;
//        }else{
//            model.isHandled = NO;
//        }
    
//        [self.arraySearchData addObject:model];
//    }
    
    [self.tableview reloadData];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

#pragma mark - UItabelViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arraySearchData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *searchCell = @"searchCell";
    ComplainCell *cell   = [tableView dequeueReusableCellWithIdentifier:searchCell];
    if (!cell) {
        cell = [[ComplainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCell];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.compModel = self.arraySearchData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ComplainDetailController *detailController = [[ComplainDetailController alloc] init];
    
    ComplainModel *model = self.arraySearchData[indexPath.row];

    if (self.complainStatus == 1) {
        detailController.isHandled = YES;
    }else{
        detailController.isHandled = NO;
    }
    
    detailController.apiID = [NSString stringWithFormat:@"%@",model.id];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark -getter
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = [UIColor clearColor];
    }
    return _tableview;
}
- (NSMutableArray *)arraySearchData
{
    if (!_arraySearchData) {
        _arraySearchData = [NSMutableArray array];
    }
    return _arraySearchData;
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchClick];
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hiddenKey];
    self.navigationController.navigationBar.translucent =NO;
}
- (void) hiddenKey
{
    [self.searchTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

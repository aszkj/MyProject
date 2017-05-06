//
//  XKJHShopEnterCategoryViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopEnterCategoryViewController.h"
#import "XKJHShopCategoryTableViewCell.h"



@interface XKJHShopEnterCategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;//数据源
@property (nonatomic, strong) NSMutableArray *selectData;//选中之后的数据

@end

static NSString *shopCategoryTableViewCell = @"shopCategoryTableViewCell";

@implementation XKJHShopEnterCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setData];
}
- (void) setData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    [hud show:YES];
    GroupGroupClassListRequest *groupListRequest = [[GroupGroupClassListRequest alloc] init:GetToken];
    groupListRequest.api_ret = [self.titleString containsString:@"主营类目"] ? @(1) : @(2);
    groupListRequest.api_parentId = [self.titleString containsString:@"主营类目"] ? @(1): self.api_parentId;
    [_vapiManager groupGroupClassList:groupListRequest success:^(AFHTTPRequestOperation *operation, GroupGroupClassListResponse *response) {
//        NSLog(@"cheshi ---- %@",response);
        if ([self.titleString containsString:@"主营类目"])
        {
            for (NSDictionary *dict in response.groupClassList)
            {
                [self.dataSource addObject:dict];
            }
        }
        else
        {
            for (NSDictionary *dict in response.classDetails)
            {
                [self.dataSource addObject:dict];
            }
        }
        [MBProgressHUD hideHUDForView:self.view animated: YES];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated: YES];
        [Util ShowAlertWithOnlyMessage:@"数据加载失败"];
        NSLog(@"cheshi ---- %@",error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHShopCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCategoryTableViewCell];
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.titleNameLabel.text = dict[@"gcName"];
    if (self.selectData.count > 0)
    {
        if ([self.selectData[0][@"id"] intValue] == [dict[@"id"] intValue])
        {
            cell.selectBtn.selected = YES;
        }
        else
        {
            cell.selectBtn.selected = NO;
        }
    }
    WEAK_SELF
    cell.selectBlock = ^(BOOL select){
        if ([self.titleString containsString:@"主营类目"])//单选
        {
            [self.selectData removeAllObjects];
            [self.selectData addObject:dict];
            [self.tableView reloadData];
        }
        else  //多选
        {
            if (select)
            {
                [weak_self.selectData addObject:self.dataSource[indexPath.row]];
            }
            else
            {
                [weak_self.selectData removeObject:self.dataSource[indexPath.row]];
            }
        }
    };
    return cell;
}

- (void)initUI
{
    _vapiManager = [[VApiManager alloc] init];
    self.view.backgroundColor = VCBackgroundColor;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    self.dataSource = [NSMutableArray array];
    self.selectData = [NSMutableArray array];
    
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"XKJHShopCategoryTableViewCell" bundle:nil] forCellReuseIdentifier:shopCategoryTableViewCell];
    //提交按钮
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor = [UIColor clearColor];
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    commitBtn.frame = CGRectMake(15, 15, kScreenWidth - 30 , 45);
    [commitBtn setTitle:@"确   定" forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.backgroundColor = status_color;
    commitBtn.layer.cornerRadius = 5;
    [footerView addSubview:commitBtn];
    self.tableView.tableFooterView = footerView;

}
- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 确定事件
- (void)certainAction
{
    if (self.selectResult)
    {
        NSMutableString *str = [NSMutableString string];
        if (self.selectData.count > 0)
        {
            for (NSDictionary *dict in self.selectData)
            {
                [str appendFormat:@"%@,",dict[@"gcName"]];
            }
            [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
        }
        NSMutableString *strID = [NSMutableString string];
        if (self.selectData.count > 0)
        {
            for (NSDictionary *dict in self.selectData)
            {
                [strID appendFormat:@"%@,",dict[@"id"]];
            }
            [strID deleteCharactersInRange:NSMakeRange(strID.length - 1, 1)];
        }
        self.selectResult(str,self.selectData.count > 0 ? self.selectData[0][@"id"] : nil,strID);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setTitleString:(NSString *)titleString
{
    NSArray *array = [titleString componentsSeparatedByString:@"✻ "];
    _titleString = array[1];
    [Util setNavTitleWithTitle:_titleString ofVC:self];
}

@end

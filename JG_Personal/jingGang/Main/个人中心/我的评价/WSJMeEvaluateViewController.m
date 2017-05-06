//
//  WSJMeEvaluateViewController.m
//  jingGang
//
//  Created by thinker on 15/8/18.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJMeEvaluateViewController.h"
#import "PublicInfo.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "WSJEvaluateTableViewCell.h"
#import "WSJEvaluateAddViewController.h"
#import "KJGoodsDetailViewController.h"
#import "WSProgressHUD.h"
#import "MJRefresh.h"

@interface WSJMeEvaluateViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    VApiManager *_vapiManager;
    NSInteger    _page;
}
//提示是否数据为空
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel     *labelK;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WSJMeEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - 网络数据请求
- (void) requestData
{
    SelfEvaluateListRequest *evaluateListRequest = [[SelfEvaluateListRequest alloc] init:GetToken];
    evaluateListRequest.api_pageNum  = @(_page);
    evaluateListRequest.api_pageSize = @(10);
    WEAK_SELF
    [_vapiManager selfEvaluateList:evaluateListRequest success:^(AFHTTPRequestOperation *operation, SelfEvaluateListResponse *response) {
        NSLog(@"我的评论 ---- %@",response);
        for (NSDictionary *dict in response.selfEvaluate)
        {
            WSJEvaluateModel *model = [[WSJEvaluateModel alloc] init];
            model.isMeEvaluate      = YES;
            model.goodsID           = dict[@"id"];
            model.titleImageURL     = dict[@"goodsMainPhotoPath"];
            model.titleName         = dict[@"goodsName"];
            model.evaluateContent   = dict[@"evaluateInfo"];
            model.date              = dict[@"addTime"];
            NSMutableCharacterSet *charecter = [[NSMutableCharacterSet alloc] init];
            [charecter addCharactersInString:@";"];
            [charecter addCharactersInString:@"|"];
            for (NSString *str in [dict[@"evaluatePhotos"] componentsSeparatedByCharactersInSet:charecter])
            {
                if (str.length > 0)
                {
                    [model.dataImageArray addObject:str];
                }
            }
            if (dict[@"reply"] != nil)
            {
                model.shopkeeper = [NSString stringWithFormat:@"[掌柜回复]：%@",dict[@"reply"]];
            }
            if (dict[@"addevaInfo"] != nil)
            {
                model.supplement = [NSString stringWithFormat:@"[追加评论]：%@",dict[@"addevaInfo"]];
            }
            [weak_self.dataSource addObject:model];
        }
        [weak_self.tableView reloadData];
        if (weak_self.dataSource.count > 0)
        {
            weak_self.imageV.hidden = YES;
            weak_self.labelK.hidden = YES;
        }
        else
        {
            weak_self.imageV.hidden = NO;
            weak_self.labelK.hidden = NO;
        }
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self.tableView headerEndRefreshing];
        [weak_self.tableView footerEndRefreshing];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJEvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meEvaluateCell"];
    WSJEvaluateModel *model;
    if (self.dataSource.count > indexPath.row)
    {
        model = self.dataSource[indexPath.row];
    }
    WEAK_SELF
    cell.supplementBlock = ^ (void){//TODO: 追加按钮触发
        WSJEvaluateAddViewController *evaluateVC = [[WSJEvaluateAddViewController alloc] initWithNibName:@"WSJEvaluateAddViewController" bundle:nil];
        evaluateVC.goods_id = model.goodsID;
        evaluateVC.model    = model;
        [weak_self.navigationController pushViewController:evaluateVC animated:YES];
    };
    [cell willCellWithModel:model];
    return cell;
}
#pragma mark  - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSJEvaluateModel *model;
    if (self.dataSource.count > indexPath.row)
    {
        model = self.dataSource[indexPath.row];
    }
    return model.height;
}
#pragma mark - 实例化UI
- (void)initUI
{
    _page = 1;
    _vapiManager = [[VApiManager alloc] init];
    self.tableView.tableFooterView = [UIView new];
    self.dataSource = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSJEvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"meEvaluateCell"];
    WEAK_SELF
    [self.tableView addHeaderWithCallback:^{
        [weak_self.dataSource removeAllObjects];
        _page = 1;
        [weak_self requestData];
    }];
    [self.tableView addFooterWithCallback:^{
        _page ++;
        [weak_self requestData];
    }];
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void) btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"我的评价";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
    [self.tableView headerBeginRefreshing];
}

@end

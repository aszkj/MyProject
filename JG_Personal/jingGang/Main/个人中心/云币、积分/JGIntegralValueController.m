//
//  JGIntegralValueController.m
//  jingGang
//
//  Created by dengxf on 15/12/25.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGIntegralValueController.h"
#import "JGIntegralHeaderView.h"
#import "JGCloudValueCell.h"
#import "ConfigureDataSource.h"
#import "VApiManager.h"
#import "GlobeObject.h"
#import "MJExtension.h"
#import "JGIntegralValueModel.h"
#import "MJRefresh.h"
#import "JGIntegarlCloudController.h"
#import "JGUserValueBottomView.h"
#import "JGCloudValueController.h"
#import "IntegralNewHomeController.h"

@interface JGIntegralValueController ()<UITableViewDelegate>

@property (assign, nonatomic) ControllerValueType valueType;

@property (strong,nonatomic) UITableView *tableView;

@property (nonatomic, strong) ConfigureDataSource *configureDataSource;

@property (nonatomic, strong) NSMutableArray *arrayDate;

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic,strong) JGIntegralHeaderView *headView;

@property (nonatomic,assign) NSInteger valueAllCount;

@property (nonatomic,strong) JGUserValueBottomView *bottonView;


@end

@implementation JGIntegralValueController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc]init];
        //添加上拉加载下拉刷新
        WEAK_SELF
        [_tableView addHeaderWithCallback:^{
            weak_self.pageNum = 1;
            if (self.valueType == IntegralControllerType) {
                [weak_self requestIntegralDataWithPageNum:[NSNumber numberWithInteger:weak_self.pageNum] isNeedRemoveObj:YES];
            }else if (self.valueType == CloudValueControllerType){
                [weak_self requestYunMoneyDataWithPageNum:[NSNumber numberWithInteger:weak_self.pageNum] isNeedRemoveObj:YES];
            }
            
        }];
        [_tableView addFooterWithCallback:^{
            //如果数组记录数量超过总数量择不加载数据
            if (weak_self.arrayDate.count >= weak_self.valueAllCount) {
                [weak_self hideHubWithOnlyText:@"已加载全部数据"];
                [weak_self.tableView footerEndRefreshing];
                return;
            }
            weak_self.pageNum++;
            
            if (weak_self.pageNum == 1) {
                weak_self.pageNum = 2;
            }
            if (self.valueType == IntegralControllerType) {
                [weak_self requestIntegralDataWithPageNum:[NSNumber numberWithInteger:weak_self.pageNum] isNeedRemoveObj:NO];
            }else if (weak_self.valueType == CloudValueControllerType){
                [weak_self requestYunMoneyDataWithPageNum:[NSNumber numberWithInteger:weak_self.pageNum] isNeedRemoveObj:NO];
            }
        }];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)arrayDate
{
    if (!_arrayDate) {
        _arrayDate = [NSMutableArray array];
    }
    return _arrayDate;
}


- (instancetype)initWithControllerType:(ControllerValueType)valueType {
    if (self = [super init]) {
        
        self.valueType = valueType;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pageNum = 1;
    NSString *title = @"";
    NSString *rightTitle = @"";

    if (self.valueType == IntegralControllerType) {
        //积分
        title = @"我的积分";
        rightTitle = @"积分规则";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self requestIntegralDataWithPageNum:[NSNumber numberWithInteger:self.pageNum] isNeedRemoveObj:YES];
    }else if(self.valueType == CloudValueControllerType){
        //云币
        title = @"我的云币";
        rightTitle = @"云币规则";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self requestYunMoneyDataWithPageNum:[NSNumber numberWithInteger:self.pageNum] isNeedRemoveObj:YES];
    }
    self.navigationItem.rightBarButtonItem = [self setupTitle:rightTitle titleColor:[UIColor whiteColor] target:self action:@selector(detailAction)];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = [UIFont systemFontOfSize:20.0];
    titleLable.text = title;
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化界面
    [self configContent];

}

- (UIBarButtonItem *)setupTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)detailAction {
    JGIntegarlCloudController *jg = [[JGIntegarlCloudController alloc] init];
    
    if (self.valueType == IntegralViewType) {
        jg.RuleValueType = IntegralRuleType;
    }else if (self.valueType == CloudValueViewType){
        jg.RuleValueType = CloudValueRuleType;
    }
    [self.navigationController pushViewController:jg animated:YES];
}
/**
 *  初始化界面
 */
- (void)configContent {
    
    CGFloat bottomViewHeight = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.x = 0;
    self.tableView.y = 0;
    self.tableView.width = ScreenWidth;
    self.tableView.height = ScreenHeight - NavBarHeight - bottomViewHeight;
    
    WeakSelf;
    JGUserValueBottomView *bottonView = [[JGUserValueBottomView alloc] initWithType:self.valueType clickButtonAction:^(BottomButtonType type) {
        // type 代表点击按钮的类型
        StrongSelf;
        if (type == BottomButtonExchangeType) {
            IntegralNewHomeController *integralNewHomeController = [[IntegralNewHomeController alloc]init];
            [strongSelf.navigationController pushViewController:integralNewHomeController animated:YES];
        }else{
            JGCloudValueController *cloudValueController = [[JGCloudValueController alloc] initWithControllerType:type];
            cloudValueController.totleValue = bself.strCloudVelues;
            [strongSelf.navigationController pushViewController:cloudValueController animated:YES];
        }

    }];
    
    bottonView.x = 0;
    bottonView.y = CGRectGetMaxY(self.tableView.frame);
    bottonView.width = kScreenWidth;
    bottonView.height = bottomViewHeight;
    [self.view addSubview:bottonView];
    self.bottonView = bottonView;
    //设置数据源
    WEAK_SELF
    ConfigureDataCellBlock configureCellBlock = ^(JGCloudValueCell *cell , JGIntegralValueModel *model){
        if (weak_self.valueType == IntegralViewType) {
            cell.valueType = IntegralCellType;
            cell.integralModel = model;
        }else if (weak_self.valueType == CloudValueViewType){
            cell.valueType = CloudValueCellType;
            cell.cloudValuesModel = model;
        }
        
    };
    
    self.configureDataSource = [[ConfigureDataSource alloc]initWithItems:self.arrayDate
                                                               cellClass:NSClassFromString(@"JGCloudValueCell")
                                                          cellIdentifier:@"JGCloudValueCell"
                                                      configureCellBlock:configureCellBlock];
    self.tableView.dataSource = self.configureDataSource;
}

#pragma mark ---tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.headView = [[JGIntegralHeaderView alloc] initWithHeaderViewValue:self.strCloudVelues];
    self.headView .x = 0;
    self.headView .y = 0;
    self.headView .width = ScreenWidth;
    self.headView .height = 110;
    if (self.valueType == IntegralControllerType) {
        self.headView .valueType = IntegralViewType;
    }else{
        self.headView .valueType = CloudValueViewType;
    }
    self.headView.totleValue = self.strCloudVelues;
    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110;
}
/**
 *  请求我的积分明细数据
 */

- (void)requestIntegralDataWithPageNum:(NSNumber *)pageNum isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    WEAK_SELF
    VApiManager *vapiManager = [[VApiManager alloc]init];
    UsersIntegralListRequest *request = [[UsersIntegralListRequest alloc]init:GetToken];
    request.api_pageNum = pageNum;
    request.api_pageSize = @10;
    JGLog(@"page:%ld",[pageNum integerValue]);
    [vapiManager usersIntegralList:request success:^(AFHTTPRequestOperation *operation, UsersIntegralListResponse *response) {
        weak_self.strCloudVelues = [NSString stringWithFormat:@"%@",response.integralBalance];
        //这里存储记录的总数量，超出总数量就不刷新
        weak_self.valueAllCount = [response.userIntegralCount integerValue];
        
        [weak_self disposeIntegralDataWithArray:response.userIntegralDetailBO isNeedRemoveObj:isNeedRemoveObj];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
        [weak_self.tableView footerEndRefreshing];
        [weak_self.tableView headerEndRefreshing];
    }];
    
}


/**
 *  处理网络接受到的积分、云币详情数据
 */
- (void)disposeIntegralDataWithArray:(NSArray *)array isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    
    if (isNeedRemoveObj) {
        [self.arrayDate removeAllObjects];
    }
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dicDetailsList = [NSDictionary dictionaryWithDictionary:array[i]];
        
        [self.arrayDate addObject:[JGIntegralValueModel objectWithKeyValues:dicDetailsList]];
    }
    
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshing];
}

/**
 *  请求我的云币明细数据
 */

- (void)requestYunMoneyDataWithPageNum:(NSNumber *)pageNum isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    WEAK_SELF
    VApiManager *vapiManager = [[VApiManager alloc]init];
    UsersYunMoneyListRequest *request = [[UsersYunMoneyListRequest alloc]init:GetToken];
    request.api_pageNum = pageNum;
    request.api_pageSize = @10;
    
    [vapiManager usersYunMoneyList:request success:^(AFHTTPRequestOperation *operation, UsersYunMoneyListResponse *response) {
        [weak_self disposeIntegralDataWithArray:response.userYunMoneyBO isNeedRemoveObj:isNeedRemoveObj];
        weak_self.strCloudVelues = [NSString stringWithFormat:@"%@",response.availableBalance];
        //这里存储记录的总数量，超出总数量就不刷新
        weak_self.valueAllCount = [response.userYunMoneyCount integerValue];
        
        weak_self.bottonView.cloudValue = weak_self.valueAllCount;
        
        
        //云币有变动后通知个人中心云币数量也作出修改
        if([self.delegate respondsToSelector:@selector(nofiticationCloudMoneyValueChange:)]){
            [self.delegate nofiticationCloudMoneyValueChange:weak_self.strCloudVelues];
        }
        
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:weak_self.view animated:YES];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end

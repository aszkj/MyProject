//
//  WIntegralCartViewController.m
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralCartViewController.h"
#import "WIntegralTableViewCell.h"
#import "WIntegralDeleteTableViewCell.h"
#import "WIntegralShopPrompt.h"
#import "MJRefresh.h"
#import "TMCache.h"
#import "MJExtension.h"
#import "IntegralShopHomeController.h"
#import "NSObject+MJExtension.h"
#import "PublicInfo.h"
#import "IntegralGoodsDetails.h"
#import "IntegralConfirmOrderViewController.h"
#import "WIntegralListViewController.h"
#import "IntegralGoodsDetailController.h"

@interface WIntegralCartViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _UserIntegral;//用户剩余的积分
    NSInteger _needIntegral;//用户需要的积分
    
    UIButton *_editRight;//右上角编辑按钮
    TMCache *_integralCache;//读取缓存
}
@property (nonatomic, strong) WIntegralShopPrompt *promtView;//没数据提示信息

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;

@end


NSString *const integralCell = @"WIntegralTableViewCell";
NSString *const integralDeleteCell = @"WIntegralDeleteTableViewCell";

@implementation WIntegralCartViewController
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self calculateIntegral];
    if (self.dataSource.count == 0) {
        _editRight.hidden =  YES;
        self.promtView.hidden = NO;
    }
    else
    {
        _editRight.hidden = NO;
        self.promtView.hidden = YES;
    }
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralGoodsDetails *detailsData;
    if (self.dataSource.count > indexPath.row) {
        detailsData = self.dataSource[indexPath.row];
    }
    WEAK_SELF
    if (_editRight.selected)  //删除状态cell
    {
        WIntegralDeleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:integralDeleteCell];
        cell.indexPath = indexPath;
        cell.dataCell = detailsData;
        //编辑状态点击删除
        cell.deleteCell = ^(NSIndexPath *index){
            [weak_self cancelShop:index];
        };
        //修改数量重新计算所需积分
        cell.changeShopCount = ^(){
            [weak_self calculateIntegral];
        };
        return cell;
    }
    //普通状态cell
    WIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:integralCell];
    cell.dataCell = detailsData;
    return cell;
}
#pragma mark - 删除cell
- (void)cancelShop:(NSIndexPath *)index
{
    //删除UI上的cell
    for (NSInteger i = 1; i < self.dataSource.count - index.row; i++) {
        NSIndexPath *loopIndex = [NSIndexPath indexPathForRow:index.row+i inSection:index.section];
        WIntegralDeleteTableViewCell *shopCell = (WIntegralDeleteTableViewCell *)[self.tableView cellForRowAtIndexPath:loopIndex];
        NSIndexPath *newIndex = [NSIndexPath indexPathForRow:index.row+i-1 inSection:index.section];
        shopCell.indexPath = newIndex;
    }
    [self.dataSource removeObjectAtIndex:index.row];
    [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_editRight.selected) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IntegralGoodsDetailController *goodsDetailsVC = [[IntegralGoodsDetailController alloc] initWithNibName:@"IntegralGoodsDetailController" bundle:nil];
    IntegralGoodsDetails *details = self.dataSource[indexPath.row];
    goodsDetailsVC.integralGoodsID = details.apiId;
    [self.navigationController pushViewController:goodsDetailsVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


#pragma mark - 提交事件
- (IBAction)commitAction:(id)sender {
    NSLog(@"提交事件");
    if (_needIntegral > _UserIntegral) {
        [Util ShowAlertWithOnlyMessage:@"您的积分余额不足..."];
        return;
    }
    IntegralConfirmOrderViewController *VC = [[IntegralConfirmOrderViewController alloc] initWithNibName:@"IntegralConfirmOrderViewController" bundle:nil];
    VC.IntegralGoods = self.dataSource;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 实例化UI
- (void)initUI
{
    _integralCache = [TMCache sharedCache];
    self.dataSource = [NSMutableArray array];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WIntegralTableViewCell" bundle:nil] forCellReuseIdentifier:integralCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIntegralDeleteTableViewCell" bundle:nil] forCellReuseIdentifier:integralDeleteCell];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 100;
    
    
    [Util setNavTitleWithTitle:@"确认订单" ofVC:self];
    _editRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _editRight.frame = CGRectMake(0, 0, 45, 30);
    [_editRight setTitle:@"编辑" forState:UIControlStateNormal];
    [_editRight setTitle:@"完成" forState:UIControlStateSelected];
    [_editRight addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_editRight];
}

#pragma mark - 编辑和完成事件
- (void)editAction:(UIButton *)edit
{
    edit.selected = ! edit.selected;
    [self.tableView reloadData];
}
#pragma mark - 计算积分数量
- (void)calculateIntegral
{
    _needIntegral = 0;//需要积分
    for (IntegralGoodsDetails *details in self.dataSource)
    {
        _needIntegral += details.igGoodsIntegral.intValue * details.igExchangeCount.intValue;
    }
    [self calculateResultIntegralWithNeed:_needIntegral];
}
#pragma mark - 需要的积分与剩余的积分
- (void)calculateResultIntegralWithNeed:(NSInteger)need
{
    NSInteger surplus = _UserIntegral - need;//剩余的积分
    NSMutableAttributedString *attributeString;
    if (surplus >= 0) {
        attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总共需要%ld积分  您还剩余%ld积分",need,surplus]];
    }
    else
    {
        attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总共需要%ld积分  您的剩余积分不足",need]];
    }
    
    NSDictionary *attributDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0],NSFontAttributeName,status_color,NSForegroundColorAttributeName, nil];
    NSRange needRange = [attributeString.string rangeOfString:[NSString stringWithFormat:@"%ld",need]];
    [attributeString addAttributes:attributDict range:needRange];
    
    if (surplus >= 0) {
        NSRange surplusRange = [attributeString.string rangeOfString:[NSString stringWithFormat:@"%ld",surplus] options:NSBackwardsSearch];
        [attributeString addAttributes:attributDict range:surplusRange];
    }
    self.resultLabel.attributedText = attributeString.copy;
}
- (WIntegralShopPrompt *)promtView
{
    if (_promtView == nil) {
        _promtView = [[NSBundle mainBundle] loadNibNamed:@"WIntegralShopPrompt" owner:self options:nil][0];
        _promtView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64);
        WEAK_SELF
        _promtView.goShoppint = ^(void){
            NSLog(@"随便逛逛");
            NSArray *arrayVC = weak_self.navigationController.viewControllers;
            UIViewController *VC;
            for (UIViewController *vc in arrayVC) {
                if ([vc isKindOfClass:[IntegralShopHomeController class]]) {
                    VC = vc;
                    break;
                }
            }
            [weak_self.navigationController popToViewController:VC animated:YES];
        };
        [self.view addSubview:_promtView];
    }
    return _promtView;
}

- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 读取缓存数据
- (void)requestData
{
    [self.dataSource removeAllObjects];
    NSArray *array = [_integralCache objectForKey:kIntegralGoodsCacheKey];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        IntegralGoodsDetails *Integral = [IntegralGoodsDetails objectWithKeyValues:dict];
        [Integral setValue:dict[@"apiId"] forKey:@"apiId"];
        [dataArray addObject:Integral];
    }
//    array = [IntegralGoodsDetails objectArrayWithKeyValuesArray:array];
    [self.dataSource addObjectsFromArray:dataArray];
    [self.tableView reloadData];
}
#pragma mark - 查询用户积分
-(void)getUserIntegral
{
    UsersIntegralGetRequest *request = [[UsersIntegralGetRequest alloc] init:GetToken];
    WEAK_SELF
    [self.vapiManager usersIntegralGet:request success:^(AFHTTPRequestOperation *operation, UsersIntegralGetResponse *response) {
        NSDictionary *integralDic = (NSDictionary *)response.integral;
        if (integralDic) {
            _UserIntegral = [integralDic[@"integral"] integerValue];
            [weak_self calculateIntegral];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
    [self getUserIntegral];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSArray *array = [IntegralGoodsDetails keyValuesArrayWithObjectArray:self.dataSource];
    [_integralCache setObject:array forKey:kIntegralGoodsCacheKey];
}

@end

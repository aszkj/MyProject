//
//  JGCouponViewController.m
//  jingGang
//
//  Created by HanZhongchou on 16/1/22.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGCouponViewController.h"
#import "JGCouponListCell.h"
#import "JGCouponDataModel.h"
#import "AppDelegate.h"
#import "GoToStoreExperiseController.h"
@interface JGCouponViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *arrayDataSource;

@property (nonatomic,assign) NSInteger pageNum;
@property (weak, nonatomic) IBOutlet UIButton *buttonGoStore;
@property (weak, nonatomic) IBOutlet UIView *viewNoThink;
@property (nonatomic,assign) NSInteger couponAllCount;

@end

@implementation JGCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的优惠券";
 
    
    //一进来就网络请求数据
    self.pageNum = 1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self netWorkRequestWithPageNum:self.pageNum isNeedRemoveObj:YES];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- private
- (void)netWorkRequestWithPageNum:(NSInteger)pageNum isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    
    
    UserCustomerCouponRequest *request = [[UserCustomerCouponRequest alloc]init:GetToken];
    request.api_pageNum = [NSNumber numberWithInteger:pageNum];
    request.api_pageSize = @10;
    
    WEAK_SELF
    [self.vapiManager userCustomerCoupon:request success:^(AFHTTPRequestOperation *operation, UserCustomerCouponResponse *response) {
        [weak_self disposeDataWithArray:response.couponInfos isNeedRemoveObj:isNeedRemoveObj];
        weak_self.couponAllCount = [response.userCouponCount integerValue];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showSuccess:@"网络错误，请检查网络" toView:self.view delay:1];
        [weak_self.tableView footerEndRefreshing];
        [weak_self.tableView headerEndRefreshing];
    }];
}

/**
 *  处理网络接受到的优惠券数据
 */
- (void)disposeDataWithArray:(NSArray *)array isNeedRemoveObj:(BOOL)isNeedRemoveObj
{
    
    if (isNeedRemoveObj) {
        [self.arrayDataSource removeAllObjects];
    }
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dicDetails = [NSDictionary dictionaryWithDictionary:array[i]];
        NSDictionary *dicCoupon = [NSDictionary dictionaryWithDictionary:dicDetails[@"coupon"]];
        [self.arrayDataSource addObject:[JGCouponDataModel objectWithKeyValues:dicCoupon]];
    }
    
    if (self.arrayDataSource.count == 0) {
        self.viewNoThink.hidden = NO;
        self.tableView.hidden = YES;
    }else{
        self.tableView.hidden = NO;
        self.viewNoThink.hidden = YES;
        [self.view addSubview:self.tableView];
    }
    
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshing];
}





#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifile = @"JGCouponListCell";
    
    JGCouponListCell *cell = (JGCouponListCell *)[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JGCouponListCell" owner:self options:nil];
        cell = [nib lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.arrayDataSource.count > 0) {
        cell.model = self.arrayDataSource[indexPath.row];
    }
    
    
    return cell;
}
- (IBAction)goStorebuttonClick:(id)sender {
//    GoToStoreExperiseController *goToStoreExperiseVC = [[GoToStoreExperiseController alloc]init];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate gogogoWithTag:3];

}

#pragma mark ---UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82.0;
}


#pragma mark --- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //添加上拉加载下拉刷新
        WEAK_SELF
        [_tableView addHeaderWithCallback:^{
            weak_self.pageNum = 1;
            [weak_self netWorkRequestWithPageNum:weak_self.pageNum isNeedRemoveObj:YES];
            
        }];
        [_tableView addFooterWithCallback:^{
            if (weak_self.arrayDataSource.count >= weak_self.couponAllCount) {
                [weak_self hideHubWithOnlyText:@"已加载全部数据"];
                [weak_self.tableView footerEndRefreshing];
                return;
            }
            weak_self.pageNum++;
            [weak_self netWorkRequestWithPageNum:weak_self.pageNum isNeedRemoveObj:NO];
            
        }];
 
    }
    return _tableView;
}
- (NSMutableArray *)arrayDataSource
{
    if (!_arrayDataSource) {
        _arrayDataSource = [NSMutableArray array];
    }
    return _arrayDataSource;
}


@end

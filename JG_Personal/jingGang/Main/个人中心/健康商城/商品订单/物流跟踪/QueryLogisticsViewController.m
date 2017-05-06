//
//  QueryLogisticsViewController.m
//  jingGang
//
//  Created by thinker on 15/8/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "QueryLogisticsViewController.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "JGLogisticsFollowCell.h"
#import "APIManager.h"
#import "ShopCenterListReformer.h"

@interface QueryLogisticsViewController () <UITableViewDelegate,UITableViewDataSource,APIManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UILabel     *orderDetail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray     *dataSource;
@property (nonatomic) APIManager *wuliuMananger;

@end

@implementation QueryLogisticsViewController

static NSString *cellIdentifier = @"QueryLogisticsTableViewCell";
static NSString *headCellIdentifier = @"HeadTableViewCell";


#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    
    [self setUIContent];
//    [self setViewsMASConstraint];
    self.wuliuMananger = [[APIManager alloc] initWithDelegate:self];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.wuliuMananger getWuliuExpressCode:self.expressCode expressID:self.expressCompanyId];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animate {
    
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *strAllContect = [NSString stringWithFormat:@"%@",[self.dataSource xf_safeObjectAtIndex:indexPath.row]];

    //裁剪出物流信息
    NSString *strContect = [strAllContect substringToIndex:(strAllContect.length - 20)];

//    NSString *strGoodsName = [NSString stringWithFormat:@"%@",model.goodName];
    
    CGSize sizeContect = CGSizeMake(kScreenWidth - 30, MAXFLOAT);
    NSDictionary *dicContect = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    
    CGSize ssizeContect = [strContect boundingRectWithSize:sizeContect
                                                           options:NSStringDrawingUsesLineFragmentOrigin attributes:dicContect
                                                           context:nil].size;
    CGFloat cellHeight = ssizeContect.height + 5 + 16;
    if (cellHeight < 50.0) {
        cellHeight = 50.0;
    }
    return cellHeight;

}




#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JGLogisticsFollowCell";
    JGLogisticsFollowCell *cell = (JGLogisticsFollowCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JGLogisticsFollowCell" owner:self options:nil];
        cell = [nib lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataSource.count >0) {

        NSString *strAllContect = [NSString stringWithFormat:@"%@",[self.dataSource xf_safeObjectAtIndex:indexPath.row]];
        //裁剪出物流时间时间
        NSString *strTime = [strAllContect substringFromIndex:(strAllContect.length - 20)];
        
        //裁剪出物流信息
        NSString *strContect = [strAllContect substringToIndex:(strAllContect.length - 20)];
        cell.labelLogisticsFollowContext.text = strContect;
        cell.labelLgogisticsFollowTime.text = strTime;
    }
    

    
    
    return cell;
}



#pragma mark - 网络返回
- (void)apiManagerDidSuccess:(APIManager *)manager
{
    if (manager == self.wuliuMananger) {
        ShopExpressTransViewResponse *response = manager.successResponse;
        NSDictionary *transDic = (NSDictionary *)response.trans;
//        NSString *expressEompanyName = transDic[@"expressEompanyName"];
        NSString *expressEompanyName = transDic[@"expressName"];
        [self setOrderDetailCompanyName:expressEompanyName expressCode:self.expressCode];
        NSArray *transDetail = transDic[@"data"];
        for (NSDictionary *transData in transDetail) {
            [self.dataSource addObject:[ShopCenterListReformer getTransContextFromData:transData]];
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (self.dataSource.count == 0) {
            [self showBackgroundView];
        }
    }
}

- (void)apiManagerDidFail:(APIManager *)manager
{
    if (manager == self.wuliuMananger) {
        [self showBackgroundView];
    }
}

- (void)showBackgroundView {
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:self.tableView.frame];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.text = @"无法查询到物流,请稍后再试";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tableView.backgroundView = infoLabel;
}

#pragma mark - event response



#pragma mark - private methods

- (void)initTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50.0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.tableHeaderView = [self tableHeaderView];
}

- (void)setBarButtonItem {
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain  target:self  action:nil];
    //    self.navigationItem.backBarButtonItem = backButton;
    [self setLeftBarAndBackgroundColor];

}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    [self initTableView];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setOrderDetailCompanyName:nil expressCode:self.expressCode];
    self.title = @"物流跟踪";
}

- (void)setOrderDetailCompanyName:(NSString *)comapnyName expressCode:(NSString *)expressCode {
    if (comapnyName == nil) { comapnyName = @" ";}
    if (expressCode == nil) { comapnyName = @" ";}
    self.orderDetail.text = [NSString stringWithFormat:@" %@ 单号 \n %@",comapnyName,expressCode];
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(3, 30, kScreenWidth - 6, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}


#pragma mark - getters and settters

- (UIView *)tableHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(6, 6, kScreenWidth - 12, 15)];
    title.font = [UIFont systemFontOfSize:13];
    title.text = @"物流详情";
    [headerView addSubview:title];
    
    UIView *lineView = [self lineView];
    [headerView addSubview:lineView];
        return headerView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }

    return _dataSource;
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
    
}


@end

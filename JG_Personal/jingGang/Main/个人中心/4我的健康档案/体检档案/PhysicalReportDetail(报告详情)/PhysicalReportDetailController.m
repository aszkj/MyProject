//
//  PhysicalReportDetailController.m
//  jingGang
//
//  Created by HanZhongchou on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "PhysicalReportDetailController.h"
#import "SaveReportDoneController.h"
#import "PhysicalReportDetailTopView.h"
#import "PhysicalReportDetailCell.h"
#import "VApiManager.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "PhysicalReportDetailModel.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "MJExtension.h"
#import "WSJAddMERViewController.h"
#import "WInputXingViewController.h"
#import "WInputMERViewController.h"
#import "MERMenusViewController.h"
@interface PhysicalReportDetailController ()<UITableViewDataSource,UITableViewDelegate,PhysicalRetailTopViewDelegate,PhysicalReportDetailCellDelegat>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayReportDetail;    //报告详情数组
@property (nonatomic,strong) PhysicalReportDetailTopView *viewTop;
@property (nonatomic,strong) UIButton *buttonSave;      //保存提交按钮
@property (nonatomic,strong) VApiManager *netManager;   //网络请求类
@property (nonatomic,assign) NSInteger   pageNum;         //页数
@property (nonatomic,assign) BOOL        isNeedRemoveObj; //是否需要移除数组中的元素
@property (nonatomic,strong) UIScrollView *scrollViewBg;   //背景scrollView
@property (nonatomic,strong) NSDictionary *dicDetailReportInfo;//网络传来的体检详情字典
@property (nonatomic,strong) UIButton     *buttonCheckReport;//查看结果按钮
@end

@implementation PhysicalReportDetailController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@年%@月%@日体检报告",self.strYear,self.strMonth,self.strDay];
    //初始化UI
    [self loadUI];
    self.pageNum = 1;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self netWorkRequest];
}

#pragma mark - Delegate
#pragma mark - UITableViewDelegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayReportDetail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    PhysicalReportDetailCell *cell = (PhysicalReportDetailCell *)[tableView dequeueReusableCellWithIdentifier:identifer];
    if(!cell){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PhysicalReportDetailCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    PhysicalReportDetailModel *model = self.arrayReportDetail[indexPath.row];
    cell.model = model;
    cell.delegate = self;
    cell.indexPath = indexPath;
    NSString *str = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"status"]];
    cell.strStatus = str;
    return cell;
}


#pragma mark - physicalReportDetailTopViewDelegate
- (void)editButtonClickNofitication
{
    WSJAddMERViewController *VC = [[WSJAddMERViewController alloc] init];
    VC.type = kEditMERType;
    VC.strYear = self.strYear;
    VC.strMonth = self.strMonth;
    VC.strDay = self.strDay;
    VC.isComePhysicalReportDetailVc = YES;
    VC.api_id = self.dicDetailReportInfo[@"id"];
    VC.strReportName = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"resultname"]];
    VC.strCheckHospital = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"hospital"]];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - PhysicalReportDetailCellDelegate
//点击cell中的编辑按钮事件
- (void)editButtonClickWithPhysicalReportDetailCell:(PhysicalReportDetailCell *)cell indexPath:(NSIndexPath *)indexPath
{
    PhysicalReportDetailModel *model = [[PhysicalReportDetailModel alloc]init];
    model = self.arrayReportDetail[indexPath.row];
    NSString *strReportId = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"id"]];
    NSString *strCreatetime= [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"createtime"]];
    
    //根据type跳转到阴阳选择页面或者是数值输入页面 1阴阳  0输入
    if (model.type == 1) {

        
        WInputXingViewController *VC = [[WInputXingViewController alloc]init];
        VC.detailsModel = model;//[NSNumber numberWithInteger:[model.id integerValue]];
        VC.api_replyId = [NSNumber numberWithInteger:[strReportId integerValue]];
        VC.createTime = strCreatetime;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        WInputMERViewController *VC = [[WInputMERViewController alloc]init];
        VC.detailsModel = model;//[NSNumber numberWithInteger:[model.id integerValue]];
        VC.api_replyId = [NSNumber numberWithInteger:[strReportId integerValue]];
        VC.createTime = strCreatetime;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark - private
- (void)loadUI
{
    [self.view addSubview:self.scrollViewBg];

    self.viewTop.delegate = self;
    //设置tableview的frame
}


//网络请求方法
- (void)netWorkRequest
{
    typeof (self) bself = self;
    ReportResultDetailsRequest *request = [[ReportResultDetailsRequest alloc]init:GetToken];
    request.api_id = bself.apiId;
    NSInteger intgerPageSize = 10;
    request.api_pageSize = [NSNumber numberWithInteger:intgerPageSize];
    request.api_pageNum = [NSNumber numberWithInteger:bself.pageNum];
    [self.netManager reportResultDetails:request success:^(AFHTTPRequestOperation *operation, ReportResultDetailsResponse *response){
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[response.report keyValues]];
        
        bself.viewTop.viewPoint = bself.view.center;
        bself.tableView.tableHeaderView = [bself.viewTop loadDataWithDic:dic];
        bself.dicDetailReportInfo = dic;
        [bself loadNetWorkData:dic];
        
        
        [bself.scrollViewBg headerEndRefreshing];
        [bself.scrollViewBg footerEndRefreshing];
        [MBProgressHUD hideHUDForView:bself.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [bself.scrollViewBg headerEndRefreshing];
        [bself.scrollViewBg footerEndRefreshing];
        [MBProgressHUD hideHUDForView:bself.view animated:YES];
        NSLog(@"%@",error);
    }];
}

/**
 *  处理网络传来的数据
 */
- (void)loadNetWorkData:(NSDictionary *)dic
{
    NSArray *array = [NSArray arrayWithArray:dic[@"detailsList"]];

    if (self.isNeedRemoveObj) {
        [self.arrayReportDetail removeAllObjects];
        self.isNeedRemoveObj = NO;
    }
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dicDetailsList = [NSDictionary dictionaryWithDictionary:array[i]];

        [self.arrayReportDetail addObject:[PhysicalReportDetailModel objectWithKeyValues:dicDetailsList]];
    }

    //体检报告状态：1未提交、2待处理、3已处理
    //    status;1、3状态显示编辑按钮
    NSString *status = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"status"]];
    if ([status isEqualToString:@"1"] || [status isEqualToString:@"3"]) {
        self.navigationItem.rightBarButtonItem = [self rightButton];
    }
    if ([status isEqualToString:@"1"]) {
        [self.buttonSave setTitle:@"提交" forState:UIControlStateNormal];
        [self setSaveButtonFrameWith:YES];
    }if([status isEqualToString:@"2"]){
        [self.buttonSave setTitle:@"已提交处理中" forState:UIControlStateNormal];
        [self setSaveButtonFrameWith:YES];
        self.buttonSave.enabled = NO;
    }else if ([status isEqualToString:@"3"]){
        [self setSaveButtonFrameWith:NO];
    }

    [self.tableView reloadData];
    

    

    
    //刷新数据后要重新设置scrrllView和背景imageView的高度
    CGSize scrollViewTempSize = self.scrollViewBg.contentSize;
    scrollViewTempSize.height = self.tableView.contentSize.height + 50;
    self.scrollViewBg.contentSize = scrollViewTempSize;
    if (self.scrollViewBg.contentSize.height < __MainScreen_Height) {
        CGSize scrollViewSize = _scrollViewBg.contentSize;
        scrollViewSize.height = __MainScreen_Height +1;
        self.scrollViewBg.contentSize = scrollViewSize;
    }
    
    
    CGRect tableViewRect = self.tableView.frame;
    tableViewRect.size.height = self.scrollViewBg.contentSize.height;
    self.tableView.frame = tableViewRect;
}
//下拉刷新方法
- (void)tableViewHeaderRereshing{
    self.isNeedRemoveObj = YES;
    self.pageNum = 1;
    [self netWorkRequest];
}
//上拉加载方法
- (void)tableviewFooterRereshing{
    self.isNeedRemoveObj = NO;
    self.pageNum++;
    [self netWorkRequest];
}

/**
 *  设置saveButton的frame
 */
- (void)setSaveButtonFrameWith:(BOOL)isSetFrame
{
    if (isSetFrame) {
        self.buttonSave.frame = CGRectMake(25, 45, self.tableView.frame.size.width - 50, 42);
        self.buttonSave.layer.cornerRadius = 4;
        self.buttonCheckReport.hidden = YES;
    }else{
        [self.buttonSave setTitle:@"重新提交" forState:UIControlStateNormal];
        CGFloat buttonSaveX = CGRectGetMaxX(self.buttonCheckReport.frame) + 10;
        self.buttonSave.frame = CGRectMake(buttonSaveX, 45, self.buttonCheckReport.frame.size.width, 42);
        self.buttonSave.layer.cornerRadius = 20;
        self.buttonCheckReport.hidden = NO;
        
    }
}

#pragma mark -- Action
/**
 *  提交保存按钮事件
 */
- (void)saveButtonClick
{
    typeof (self) blockSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ReportResultDetailsUpdateRequest *request = [[ReportResultDetailsUpdateRequest alloc]init:GetToken];
    request.api_replyId = self.apiId;
    [self.netManager reportResultDetailsUpdate:request success:^(AFHTTPRequestOperation *operation, ReportResultDetailsUpdateResponse *response) {
        
        [blockSelf netWorkRequest];
        blockSelf.isNeedRemoveObj = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:blockSelf.view animated:YES];
    }];
}
/**
 *  查看报告结果按钮事件
 */
- (void)checkReportbuttonCilck
{
    SaveReportDoneController *vc = [[SaveReportDoneController alloc]init];
    vc.navigationItem.title = self.navigationItem.title;
    vc.strReportResult = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"result"]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightButtonClick
{
    MERMenusViewController *VC = [[MERMenusViewController alloc]init];
    VC.apiId = self.apiId;
    VC.createtime = [NSString stringWithFormat:@"%@",self.dicDetailReportInfo[@"createtime"]];
    [kUserDefaults setObject:self.apiId forKey:kMERID];
    [kUserDefaults setObject:self.dicDetailReportInfo[@"createtime"] forKey:kMERTime];
    [self.navigationController pushViewController:VC animated:YES];
}
//重写返回按钮
- (void)btnClick
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
}
#pragma mark --getter
- (PhysicalReportDetailTopView *)viewTop
{
    if (!_viewTop) {
        _viewTop = [[PhysicalReportDetailTopView alloc]init];
        _viewTop.viewPoint = self.view.center;
    }
    return _viewTop;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(22, 22, __MainScreen_Width - 44, __MainScreen_Height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [self loadTableViewFootView];
        _tableView.tableHeaderView = [self.viewTop loadDataWithDic:nil];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *imageViewBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, _tableView.contentSize.height + 55)];
        imageViewBg.image = [UIImage imageNamed:@"Physical_Report_BgImage"];
        imageViewBg.userInteractionEnabled = YES;
        
        _tableView.backgroundView = imageViewBg;
    }
    return _tableView;
}
//数据数组
- (NSMutableArray *)arrayReportDetail
{
    if (!_arrayReportDetail) {
        _arrayReportDetail = [NSMutableArray array];
    }
    return _arrayReportDetail;
}
//底部提交保存按钮
- (UIButton *)buttonSave
{
    if (!_buttonSave) {
        _buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonSave.frame = CGRectMake(25, 45, self.tableView.frame.size.width - 50, 42);
        _buttonSave.backgroundColor = rgb(21, 150, 219, 1);
        [_buttonSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonSave addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_buttonSave setTitle:@"提交" forState:UIControlStateNormal];
        _buttonSave.layer.cornerRadius = 4;
    }
    return _buttonSave;
}
//加载底部tableview底部View
- (UIView *)loadTableViewFootView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 142)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:self.buttonSave];
    [view addSubview:self.buttonCheckReport];
    return view;
}


- (UIScrollView *)scrollViewBg
{
    if (!_scrollViewBg) {
        _scrollViewBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height)];
        CGSize tempSize = self.tableView.contentSize;
        tempSize.height = self.tableView.contentSize.height + 50;
        _scrollViewBg.contentSize = tempSize;
        _scrollViewBg.showsVerticalScrollIndicator = NO;
        [self.scrollViewBg addSubview:self.tableView];
        
        typeof (self) bself = self;
        
        [self.scrollViewBg addHeaderWithCallback:^{
            [bself tableViewHeaderRereshing];
        }];
        
        [self.scrollViewBg addFooterWithCallback:^{
            [bself tableviewFooterRereshing];
        }];

        
    }
    return _scrollViewBg;
}

//右侧按钮
- (UIBarButtonItem *)rightButton
{
    UIButton *navRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navRightButton.frame= CGRectMake(0, 0, 20, 20);
    [navRightButton setBackgroundImage:[UIImage imageNamed:@"MER_add"] forState:UIControlStateNormal];
    [navRightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navRightButton];
    return item;
}

/**
 *  查看报告按钮
 */
- (UIButton *)buttonCheckReport
{
    if (!_buttonCheckReport) {
        _buttonCheckReport = [UIButton buttonWithType:UIButtonTypeCustom];
        _buttonCheckReport.frame = CGRectMake(5, 45, (self.tableView.frame.size.width - 10 - 10)/2, 42);
        _buttonCheckReport.backgroundColor = rgb(21, 150, 219, 1);
        [_buttonCheckReport setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buttonCheckReport addTarget:self action:@selector(checkReportbuttonCilck) forControlEvents:UIControlEventTouchUpInside];
        [_buttonCheckReport setTitle:@"查看结果" forState:UIControlStateNormal];
        _buttonCheckReport.layer.cornerRadius = 20;
        _buttonCheckReport.hidden = YES;
    }
    return _buttonCheckReport;
}

- (NSDictionary *)dicDetailReportInfo
{
    if (!_dicDetailReportInfo) {
        _dicDetailReportInfo = [NSDictionary dictionary];
    }
    return _dicDetailReportInfo;
}


- (VApiManager *)netManager
{
    if (!_netManager) {
        _netManager = [[VApiManager alloc]init];
    }
    return _netManager;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  GoodsConsultlistShowConstroller.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsConsultlistShowConstroller.h"
#import "KGGoodsConsultCell.h"
#import "VApiManager.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Util.h"
#import "GlobeObject.h"
#import "NSDate+Addition.h"
#import "GoodsConsultModel.h"
#import "GoodsConsultController.h"
#import "ZkgLoadingHub.h"
#import "MJRefresh.h"
#import "NodataShowView.h"

static NSString *KGGoodsConsultCellID = @"KGGoodsConsultCellID";

@interface GoodsConsultlistShowConstroller ()<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray  *_consultArr;//咨询list
    VApiManager     *_vapManager;
    BOOL           _isFirstLoad;
    ZkgLoadingHub   *hub;
    
    NodataShowView  *_nodataView;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *consultTableView;

@property (weak, nonatomic) IBOutlet UITableView *goodsConsultTableView;

@end

@implementation GoodsConsultlistShowConstroller

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //请求咨询列表
    [self _requestConsultList];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [_nodataView hide];
}


#pragma mark - private Method
-(void)_init{
    _isFirstLoad = YES;
    [self.goodsConsultTableView registerNib:[UINib nibWithNibName:@"KGGoodsConsultCell" bundle:nil] forCellReuseIdentifier:KGGoodsConsultCellID];
    _vapManager = [[VApiManager alloc] init];
    self.goodsConsultTableView.tableFooterView = [UIView new];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = NavBarColor;
    UIButton *navButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [navButton setBackgroundImage:[UIImage imageNamed:@"com_new"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(consult) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"com_new" target:self action:@selector(consult)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    _vapManager = [[VApiManager alloc] init];
    [Util setNavTitleWithTitle:@"商品咨询" ofVC:self];
    //返回
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    [self.consultTableView addHeaderWithCallback:^{
        [self _requestConsultList];
    }];
}


-(void)_requestConsultList{
    if (_isFirstLoad) {
        hub = [[ZkgLoadingHub alloc] initHubInView:self.view withLoadingType:LoadingSystemtype];
    }
    if (_nodataView) {//如果nodataview不为空，说明之前请求失败过
        //先移除
        [_nodataView removeFromSuperview];
    }
    GoodsConsultListRequest *request = [[GoodsConsultListRequest alloc] init:GetToken];
    request.api_consulType = @1;
    request.api_goodsId = self.consultGoodsID;
    
    [_vapManager goodsConsultList:request success:^(AFHTTPRequestOperation *operation, GoodsConsultListResponse *response) {
        NSLog(@"consult list %@",response);
        if (_isFirstLoad) {
            [hub endLoading];
            _isFirstLoad = NO;
        }else{
            [self.consultTableView headerEndRefreshing];
        }
        
        _consultArr = [NSMutableArray arrayWithCapacity:response.goodsConsultList.count];
        for (NSDictionary *dic in response.goodsConsultList) {
            GoodsConsultModel *model = [[GoodsConsultModel alloc] initWithJSONDic:dic];
            [_consultArr addObject:model];
        }
        [self.goodsConsultTableView reloadData];
        
        if (!_consultArr.count) {//没数据，做没数据处理
            WEAK_SELF
         _nodataView = [NodataShowView showInContentView:self.view withReloadBlock:^{
               [weak_self _requestConsultList];
           } requestResultType:No_GoodsConsultType];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hub endLoading];
        WEAK_SELF
       _nodataView = [NodataShowView showInContentView:self.view withReloadBlock:^{
            [weak_self _requestConsultList];
        } requestResultType:NetworkRequestFaildType];
    }];
 }


#pragma mark - table View delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _consultArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    KGGoodsConsultCell *cell = [tableView dequeueReusableCellWithIdentifier:KGGoodsConsultCellID forIndexPath:indexPath];
    GoodsConsultModel *model = _consultArr[indexPath.row];
    cell.consultCusterNameLabel.text = model.consultUserName;
    cell.consultTimeLabel.text = model.addTime;
    cell.consultContentLabel.text = model.consultContent;
    cell.repyContentLabel.text = model.consultReply;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   GoodsConsultModel *model = _consultArr[indexPath.row];
    return model.cellHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Method
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)consult {
    GoodsConsultController *consultVC = [[GoodsConsultController alloc] init];
    [self.navigationController pushViewController:consultVC animated:YES];
    consultVC.consultGoodsID = self.consultGoodsID;
    consultVC.goodsName = self.goodsName;
}


@end

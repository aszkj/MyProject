//
//  WSJShopHomeViewController.m
//  jingGang
//
//  Created by thinker on 15/8/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShopHomeViewController.h"
#import "PublicInfo.h"
#import "commodityListView.h"
#import "Masonry.h"
#import "WSJSearchResultViewController.h"
#import "WSJBabyCategoryViewController.h"
#import "VApiManager.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GlobeObject.h"
#import "UIImageView+WebCache.h"
#import "WSJBabyCategoryModel.h"
#import "KJGoodsDetailViewController.h"
#import "VApiManager+Aspects.h"

@interface WSJShopHomeViewController ()
{
    VApiManager *_vapiManager;
}

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel     *titleNameLabel;
//收藏按钮
@property (weak, nonatomic) IBOutlet UIButton    *collectBtn;
//描述、服务、物流====评分
@property (weak, nonatomic) IBOutlet UILabel     *describeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *serveLabel;
@property (weak, nonatomic) IBOutlet UILabel     *logisticsLabel;
@property (weak, nonatomic) IBOutlet UIView      *statusView;
//商品列表
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) NSMutableArray *dataSift;//筛选数据

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation WSJShopHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self requestData];
}
#pragma mark - 网络数据请求
- (void) requestData
{
    //店铺信息
    ShopStoreInfoGetRequest *infoRequest = [[ShopStoreInfoGetRequest alloc] init:GetToken];
    infoRequest.api_storeId = self.api_storeId;
    [_vapiManager shopStoreInfoGet:infoRequest  success:^(AFHTTPRequestOperation *operation, ShopStoreInfoGetResponse *response) {
        NSLog(@"商品详情 ---- %@",response);
        NSDictionary *dict = (NSDictionary *)response.storeInfo;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(dict[@"storeLogoPath"], self.titleImageView.frame.size.width, self.titleImageView.frame.size.height)]];
            self.titleNameLabel.text = dict[@"storeName"];
            self.describeLabel.text = [NSString stringWithFormat:@"%.1lf",[dict[@"storeDescription"] floatValue]];
            self.serveLabel.text = [NSString stringWithFormat:@"%.1lf",[dict[@"storeService"] floatValue]];
            self.logisticsLabel.text = [NSString stringWithFormat:@"%.1lf",[dict[@"storeShip"] floatValue]];
            
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
    //筛选数据
    if (!self.dataSift.count)
    {
        MerchStoreCommonInfoRequest *commoInfoRequest = [[MerchStoreCommonInfoRequest alloc] init:GetToken];
        commoInfoRequest.api_storeId = self.api_storeId;
        [_vapiManager merchStoreCommonInfo:commoInfoRequest success:^(AFHTTPRequestOperation *operation, MerchStoreCommonInfoResponse *response) {
            for (NSDictionary *dict in response.storeInfo)
            {
                WSJBabyCategoryModel *model = [[WSJBabyCategoryModel alloc] init];
                model.className = dict[@"className"];
                model.ID = dict[@"id"];
                for (NSDictionary *d in dict[@"childs"])
                {
                    [model.dataChilds addObject:d];
                }
                [self.dataSift addObject:model];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
    }
    if (IsEmpty(GetToken)) {  //判断是否登录
        return;
    }
    //判断是否收藏过
    SelfFavaListRequest *favaListReqeust = [[SelfFavaListRequest alloc] init:GetToken];
    favaListReqeust.api_type = @(4);
    favaListReqeust.api_pageNum = @(1);
    favaListReqeust.api_pageSize = @(10);
    [_vapiManager selfFavaList:favaListReqeust success:^(AFHTTPRequestOperation *operation, SelfFavaListResponse *response) {
        NSLog(@"收藏店铺 ---- %@",response.selfStroeList);
        for (NSDictionary *d in response.selfStroeList)
        {
            if ([d[@"id"] intValue] == [self.api_storeId intValue])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.collectBtn.selected = YES;
                });
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}
#pragma mark - 初始化UI
- (void) initUI
{
    self.dataSift = [NSMutableArray array];
    if (self.api_storeId == nil)
    {
        self.api_storeId = @(10);
    }
    _vapiManager = [[VApiManager alloc] init];
    self.statusView.layer.cornerRadius = 10;
    //返回上一级控制器按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    commodityListView *listView = [[NSBundle mainBundle] loadNibNamed:@"commodityListView" owner:nil options:nil][0];
    listView.type = storeList;
    listView.ID = self.api_storeId;
    listView.categoryID = nil;
    [listView reloadData];
    [self.contentView addSubview:listView];
    WEAK_SELF
    [listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weak_self.contentView);
        make.width.equalTo(weak_self.contentView);
        make.height.equalTo(weak_self.contentView);
    }];
    __weak commodityListView *commodity = listView;

    listView.siftAction = ^(NSArray *data){
        WSJBabyCategoryViewController *categoryVC = [[WSJBabyCategoryViewController alloc] init];
        categoryVC.data = weak_self.dataSift;
        categoryVC.api_storeId = weak_self.api_storeId;
        categoryVC.siftAction = ^(NSNumber *ID){
            commodity.categoryID = ID;
            [commodity reloadData];
        };
        [weak_self.navigationController pushViewController:categoryVC animated:YES];
    };
    listView.selectRowBlock = ^(NSDictionary *dict){
        NSLog(@"选中商品的id ---- %@",dict[@"id"]);
        KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] initWithNibName:@"KJGoodsDetailViewController" bundle:nil];
        goodsDetailVC.goodsID = dict[@"id"];
        [weak_self.navigationController pushViewController:goodsDetailVC animated:YES];
    };
    listView.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}
#pragma mark - 收藏店铺事件
- (IBAction)collectBtn:(UIButton *)sender
{
    
    UNLOGIN_HANDLE
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        UsersFavoritesRequest *favorites = [[UsersFavoritesRequest alloc] init:GetToken];
        favorites.api_fid = [self.api_storeId stringValue];
        favorites.api_type = @"4";
        [_vapiManager usersFavorites:favorites success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
//            NSLog(@"收藏成功 ---- %@",self.api_storeId);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
    }
    else
    {
        SelfFavaDeleteRequest *deleteRequest = [[SelfFavaDeleteRequest alloc] init:GetToken];
        deleteRequest.api_id = self.api_storeId;
        deleteRequest.api_type = @"4";
        [_vapiManager selfFavaDelete:deleteRequest success:^(AFHTTPRequestOperation *operation, SelfFavaDeleteResponse *response) {
            NSLog(@"删除收藏店铺成功%@",@"ok");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            ;
        }];
    }
}
//返回上一级界面
- (void) btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"店铺";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = l;
    self.navigationController.navigationBar.translucent = NO;
}

@end

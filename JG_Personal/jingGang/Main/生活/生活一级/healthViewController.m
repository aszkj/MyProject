//
//  healthViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.


#import "healthViewController.h"
#import "mainTableViewCell.h"
#import "WWSideslipViewController.h"
#import "userDefaultManager.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "UIImageView+AFNetworking.h"
#import "WebDayVC.h"
#import "H5Base_url.h"
#import "RecommentCodeDefine.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "UIView+BlockGesture.h"
#import "H5page_URL.h"
#import "GlobeObject.h"
#import "TMCache.h"
#import "MJExtension.h"
#import "AppDelegate.h"
#import "mainPublicTableViewCell.h"
#import "mainPublicTableViewHeader.h"
#import "CareChoosenCollectionView.h"
#import "GoodStoreRecommendTableView.h"
#import "mapObject.h"
#import "UIViewExt.h"
#import "GoodsDetailModel.h"
#import "PStoreInfoModel.h"
#import "sunViewController.h"
#import "Masonry.h"

#import "JGActivityDetailController.h"


#define defaultRecommentCount 4
#define healthData @"LIFE_INDEX_HEATH"


@interface healthViewController ()<SDCycleScrollViewDelegate>
{
    UITableView         *_myTableView;
    UIButton            *_head_btn;
    BOOL                 _headYorN;
    NSMutableArray      *arr_data;
    VApiManager         *vapManage;
    NSMutableArray      *headImgArr;
    
    UILabel         *_label1;
    UILabel         *_label2;
    UILabel         *_label3;



   
    NSInteger reqNum;
    
    NSString *headImgUrl;
    int timeCount;
    
    TMCache             *_cache;
    BOOL                _hasCache;
    
    CareChoosenCollectionView *careChoosenCollectionView;
    GoodStoreRecommendTableView *goodStoreRecommendTableView;
    UIView *goodsChooseenHeaderView;
    UIView *goodStoreHeaderView;
    
    NSNumber *_longtitude; //纬度
    NSNumber *_latitude;//经度
    NSNumber *_cityID;//城市ID

    
}

@end

NSString * const healthTableViewCell = @"mainPublicTableViewCell";

@implementation healthViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 友盟统计
    [MobClick beginLogPageView:kLifeViewController];
    
    [self requestCommuntity:healthData];
    [self requestCommuntity:Shenghuo_shouye_guanggao];
    [self addHeaderFresh];
    
    _longtitude = [[mapObject sharedMap] baiduLongitude];
    _latitude = [[mapObject sharedMap] baiduLatitude];
    _cityID = [[mapObject sharedMap] baiduCityID];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 友盟统计
    [MobClick endLogPageView:kLifeViewController];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    vapManage = [[VApiManager alloc]init];
    arr_data = [[NSMutableArray alloc]init];
    
    //初始化缓存
    [self _initCacheData];
    
    //初始化基类信息
    [self _initBaseVCInfo];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __Other_Height)];
    topView.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
#pragma mark - 修改
    [Util setNavTitleWithTitle:@"健康生活" ofVC:self];

    // Do any additional setup after loading the view.
    
    if (_hasCache) {//如果有缓存,
        
        [self creatUI];
    }
}

-(void)creatUI
{
    float table_height = _midleView.frame.origin.y+_midleView.frame.size.height;//中间图片的大小地址
    _myTableView = [[UITableView alloc]init];
    _myTableView.frame = CGRectMake(0, table_height+10, __MainScreen_Width, __table_cell1_h*arr_data.count+__table_section_h);
    _myTableView.backgroundColor = [UIColor orangeColor];
    [_myTableView registerNib:[UINib nibWithNibName:@"mainPublicTableViewCell" bundle:nil] forCellReuseIdentifier:healthTableViewCell];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.scrollEnabled = NO;
    [_myScrollView addSubview:_myTableView];
    
    
#pragma mark - 修改后的
#pragma mark - 精选商品修改的
    goodsChooseenHeaderView = BoundNibView(@"CareChoosenGoodsHeaderView", UIView);
    goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame)+10, kScreenWidth, 30);
    [_myScrollView addSubview:goodsChooseenHeaderView];
    
//    [goodsChooseenHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_myTableView);
//        make.top.equalTo(_myTableView.mas_bottom).with.offset(10);
//        make.right.equalTo(_myTableView);
//        make.height.equalTo(@30);
//    }];
    
    careChoosenCollectionView = [[CareChoosenCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, kCareChoosenGoodsCellHeight*2) collectionViewLayout:nil];
    [_myScrollView addSubview:careChoosenCollectionView];
//    [careChoosenCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_myTableView);
//        make.top.equalTo(goodsChooseenHeaderView.mas_bottom).with.offset(0);
//        make.right.equalTo(_myTableView);
//        make.height.equalTo(@(kCareChoosenGoodsCellHeight*2));
//    }];
    

#pragma mark - 好店推荐修改的
    goodStoreHeaderView = BoundNibView(@"GoodStoreRecommendHeaderView", UIView);
    goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame)+10, kScreenWidth, 30);
    [_myScrollView addSubview:goodStoreHeaderView];
//    [goodStoreHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(careChoosenCollectionView.mas_bottom).with.offset(10);
//        make.left.equalTo(careChoosenCollectionView);
//        make.width.equalTo(@(kScreenWidth));
//        make.height.equalTo(@30);
//    }];
    
    goodStoreRecommendTableView = [[GoodStoreRecommendTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, GoodStoreCellHeight*defaultRecommentCount) style:UITableViewStylePlain];
    [_myScrollView addSubview:goodStoreRecommendTableView];
//    [goodStoreRecommendTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(goodStoreHeaderView.mas_bottom);
//        make.left.equalTo(@0);
//        make.width.equalTo(@(kScreenWidth));
//        make.height.equalTo(@(GoodStoreCellHeight*defaultRecommentCount));
//        make.bottom.equalTo(_myScrollView.mas_bottom).with.offset(0);
//    }];
    _myScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(goodStoreRecommendTableView.frame));
    
    //请求精选商品
    [self _requestCareChoosenGoods];

//    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, img2.frame.origin.y+img2.frame.size.height);
}

#pragma mark - 请求精选商品
-(void)_requestCareChoosenGoods{
    
    VApiManager *vapManager = [[VApiManager alloc] init];
    SnsCrcListRequest *request = [[SnsCrcListRequest alloc] init:GetToken];
    request.api_lat = _latitude;
    request.api_lon = _longtitude;
    request.api_cityId = _cityID;
    request.api_posCode = Life_careChoosenGoods_Code;
    
    [vapManager snsCrcList:request success:^(AFHTTPRequestOperation *operation, SnsCrcListResponse *response) {
        
        NSLog(@"生活首页精选商品 response %@",response);
        NSInteger itemCount = response.advList.count;
        if (itemCount > 0) {//有推荐商品
           
            NSInteger goodsCount=0;
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:response.advList.count];
            for (NSDictionary *dic in response.advList) {
                NSInteger recommendTypeNum = [dic[@"adType"] integerValue];
                if (recommendTypeNum != 2) {//过滤非商品的
                    continue;
                }
                goodsCount ++;
                GoodsDetailModel *model = [[GoodsDetailModel alloc] initWithJSONDic:dic[@"shopGoods"]];
                model.goodsMainPhotoPath = dic[@"adImgPath"];
                [arr addObject:model];
            }
            
            itemCount = goodsCount;
            NSInteger heightN = itemCount % 2 ? (itemCount / 2 + 1) : itemCount/2;
            goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame)+10, kScreenWidth, 30);
            careChoosenCollectionView.frame = CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, heightN *kCareChoosenGoodsCellHeight);
            
            goodsChooseenHeaderView.hidden = NO;
            careChoosenCollectionView.hidden = NO;

            careChoosenCollectionView.dataArr = (NSArray *)arr;
            [careChoosenCollectionView reloadData];
        }else {//没有，隐藏，高度置为1
            [self _careChoosenGoodsNodataSoleve];
        }
        //请求好店推荐
        [self _requestGoodStoreRecommend];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求好店推荐
        [self _requestGoodStoreRecommend];
        [self _careChoosenGoodsNodataSoleve];
        
    }];
}

#pragma mark - 请求好店推荐
-(void)_requestGoodStoreRecommend {
    
    VApiManager *vapManager = [[VApiManager alloc] init];
    SnsCrcListRequest *request = [[SnsCrcListRequest alloc] init:GetToken];
    request.api_lat = _latitude;
    request.api_lon = _longtitude;
    request.api_cityId = _cityID;
    request.api_posCode = Life_goodStoreRecommend_Code;
    [vapManager snsCrcList:request success:^(AFHTTPRequestOperation *operation, SnsCrcListResponse *response) {
        
        if (response.errorCode.integerValue == 2) {
            [Util enterLoginPage];
            return;
        }
        NSLog(@"生活首页好店推荐 response %@",response);
        NSInteger itemCount = response.advList.count;
        if (itemCount > 0) {
          
            
            NSInteger storeCount=0;
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:response.advList.count];
            for (NSDictionary *dic in response.advList) {
                NSInteger recommendTypeNum = [dic[@"adType"] integerValue];
                if (recommendTypeNum != 5) {//过滤非店铺的
                    continue;
                }
                storeCount ++;
                NSDictionary *dicStore = dic[@"pStoreInfo"];
                
                PStoreInfoModel *model = [[PStoreInfoModel alloc] initWithJSONDic:dicStore];
                model.photoPath = dic[@"adImgPath"];
                [arr addObject:model];
            }
            
            itemCount = storeCount;
            goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame)+10, kScreenWidth, 30);
            goodStoreRecommendTableView.frame = CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, itemCount *GoodStoreCellHeight);
            goodStoreHeaderView.hidden = NO;
            goodStoreRecommendTableView.hidden = NO;

            goodStoreRecommendTableView.dataArr = (NSArray *)arr;
            [goodStoreRecommendTableView reloadData];
            
        }else {//好店推荐没数据处理
            [self _goodStoreRecommendNoDataSoleve];
        }
        [self _setContentSize];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self _goodStoreRecommendNoDataSoleve];
        [self _setContentSize];
        
    }];
}


#pragma mark - 设置scrollView的contentSize
-(void)_setContentSize {
    _myScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(goodStoreRecommendTableView.frame));
}

#pragma mark - 精选商品没数据处理
- (void)_careChoosenGoodsNodataSoleve {
    careChoosenCollectionView.hidden = YES;
    goodsChooseenHeaderView.hidden = YES;
    goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_myTableView.frame), kScreenWidth, 1);
    careChoosenCollectionView.frame = CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, 1);
}


#pragma mark - 好店推荐没数据处理
-(void)_goodStoreRecommendNoDataSoleve {
    
    goodStoreHeaderView.hidden = YES;
    goodStoreRecommendTableView.hidden = YES;
    goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame), kScreenWidth, 1);
    goodStoreRecommendTableView.frame = CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, 1);
}





-(void)BtnTapClick
{
    UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该功能暂未开放！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}


#pragma mark  - 初始化缓存信息
-(void)_initCacheData{
    
    _cache = [TMCache sharedCache];
    
    //相关资讯
    arr_data = [_cache objectForKey:Tuijianwei_healthQuery_cache_lifeID];
    if (arr_data.count > 0) {
        _hasCache = YES;
    }
    
//    NSLog(@"缓存 arr_data %@",arr_data);
    
}



//每日精华推荐请求
-(void)requestCommuntity:(NSString *)code
{
    
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    SnsRecommendListRequest *snsRecommendListRequest = [[SnsRecommendListRequest alloc] init:accessToken];
    
    snsRecommendListRequest.api_posCode = code;
    
    reqNum++;
    [vapManage snsRecommendList:snsRecommendListRequest success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
        reqNum--;
        if (reqNum == 0) {
            [_myScrollView headerEndRefreshing];
        }
        if ([code isEqualToString:Shenghuo_shouye_guanggao]) {
            headImgArr = [self deallWithNetWorkData:response.advList] ;
            [self calCulateHeadScrollSizeWithArr];
            //广告缓存
            [_cache setObject:response.advList forKey:Tuijianwei_ad_cache_lifeID];
            return;
        }
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *arr = [dict objectForKey:@"advList"];
        if (arr.count <= 0) {
            return;
        }
        
        NSMutableArray *requestData = [NSMutableArray arrayWithCapacity:arr.count];
        for (int i=0; i<arr.count; i++) {
            [requestData addObject:arr[i]];
        }
        arr_data = requestData;
        //相关咨询缓存
        if (arr_data.count > 0) {
            [_cache setObject:arr_data forKey:Tuijianwei_healthQuery_cache_lifeID];
        }
        if (!_hasCache) {//如果没有缓存,第一次
            [self creatUI];
        }
        [_myTableView reloadData];
        
        //  NSLog(@" -----codeCOmDa.count%d",codeComDa.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        reqNum--;
        if (reqNum == 0) {
            [_myScrollView headerEndRefreshing];
        }
    }];
    
}

#pragma mark - 头部刷新
- (void)addHeaderFresh{
    
    WEAK_SELF
    [_myScrollView addHeaderWithCallback:^{
        [weak_self requestCommuntity:healthData];
        [weak_self requestCommuntity:Shenghuo_shouye_guanggao];
        [weak_self _requestCareChoosenGoods];
    }];
}
//重新布局
- (void) againComposition
{
    float table_height = _midleView.frame.origin.y+_midleView.frame.size.height;//中间图片的大小地址
    _myTableView.frame = CGRectMake(0, table_height+10, __MainScreen_Width, __table_cell1_h*arr_data.count+__table_section_h);
    CGRect frame;
    frame = goodsChooseenHeaderView.frame;
    frame.origin.y = CGRectGetMaxY(_myTableView.frame) + 10;
    goodsChooseenHeaderView.frame = frame;
    
    frame = careChoosenCollectionView.frame;
    frame.origin.y = CGRectGetMaxY(goodsChooseenHeaderView.frame);
    careChoosenCollectionView.frame = frame;
    
    frame = goodStoreHeaderView.frame;
    frame.origin.y = CGRectGetMaxY(careChoosenCollectionView.frame) + 10;
    goodStoreHeaderView.frame = frame;
    
    frame = goodStoreRecommendTableView.frame;
    frame.origin.y = CGRectGetMaxY(goodStoreHeaderView.frame);
    goodStoreRecommendTableView.frame = frame;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self againComposition];
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if (arr_data.count>6) {
        return 6;
    }else
    {
        num = arr_data.count+1;
    }
    return num;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 0;
    if (indexPath.row < arr_data.count ) {
        height = __table_cell1_h;
    }else{
        height = 10;
    }
    return height;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mainPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:healthTableViewCell];
    if (indexPath.section == 0) {
        if (indexPath.row < arr_data.count) {
            if (arr_data.count >0) {
                NSDictionary *dictss = arr_data[indexPath.row];
                NSString *url = [NSString stringWithFormat:@"%@_%ix%i",[dictss objectForKey:@"adImgPath"],(int)cell.left_img.frame.size.width*2,(int)cell.left_img.frame.size.height*2];
                [cell.left_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"background"]];
                cell.name_lab.text = [dictss objectForKey:@"adTitle"];
                cell.sub_lab.text = [dictss objectForKey:@"adText"];
            }
        }else{
            cell.left_img.image = nil;
            cell.name_lab.text = nil;
            cell.sub_lab.text = nil;
            cell.bg_img.hidden = YES;
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary *ser = arr_data[indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:[ser objectForKey:@"adTitle"] forKey:@"circleTitle"];
        NSString *str = [NSString stringWithFormat:@"%@%@",Base_URL,[ser objectForKey:@"adUrl"]];
        NSLog(@"%@",str);
        WebDayVC *web = [[WebDayVC alloc]init];
        web.strUrl = str;
        int type = [[ser objectForKey:@"adType"] intValue];
        if (type == 1) {
            web.dic = ser;
        }
        UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
        nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
        [self presentViewController:nas animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return __table_section_h;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    mainPublicTableViewHeader *headerView = [[NSBundle mainBundle] loadNibNamed:@"mainPublicTableViewHeader" owner:self options:nil][0];
    headerView.titleNameLabel.text = @"健康咨讯";
    return headerView;
}


//控制表格线条从左边开始
-(void)viewDidLayoutSubviews
{
    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)rightBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)headBtnClick
{
#pragma mark - leftSM
    AppDelegate *appDelegate = kAppDelegate;
    if (!_headYorN) {
//        [[WWSideslipViewController instance]doSomeThingtoLeft];
        [appDelegate.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else{
//        [[WWSideslipViewController instance]doSomeThingtoRight];
        [appDelegate.drawerController closeDrawerAnimated:YES completion:nil];
    }
    _headYorN = !_headYorN ;
//    if (appDelegate.leftSlideViewController.closed) {
//        [appDelegate.leftSlideViewController openLeftView];
//    }else{
//        [appDelegate.leftSlideViewController closeLeftView];
//    }

}

#pragma mark - 处理头部scroll view
#pragma top scroll 修改的

-(void)calCulateHeadScrollSizeWithArr{
    //获取图片url数组
    NSMutableArray *clearImgUrlArr = [NSMutableArray arrayWithCapacity:headImgArr.count];
    for (PositionAdvertBO *model in headImgArr) {
        NSString *clearImgUrl = [NSString stringWithFormat:@"%@_%ix%i",model.adImgPath,(int)_topScrollView.frame.size.width*2,(int)_topScrollView.frame.size.height*2];
        [clearImgUrlArr addObject:clearImgUrl];
    }
    //    NSLog(@"clear img arr %@",clearImgUrlArr);
    _topScrollView.delegate = self;
    _topScrollView.imageURLStringsGroup = (NSArray *)clearImgUrlArr;
}

#pragma mark - Top ScrollView delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    PositionAdvertBO *model = headImgArr[index];
    
    //NSString *str = [NSString stringWithFormat:@"https:/%@",model.adUrl];
    NSString *str = [NSString stringWithFormat:@"%@%@",Base_URL,model.adUrl];
    [[NSUserDefaults standardUserDefaults]setObject:model.adText forKey:@"circleTitle"];
  //  [[NSUserDefaults standardUserDefaults]objectForKey:@"circleTitle"]

    WebDayVC *web = [[WebDayVC alloc]init];
    web.strUrl = str;
    PositionAdvertBO *bo = headImgArr[index];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:model.adUrl forKey:@"adUrl"];
    [dic setObject:model.adType forKey:@"adType"];
    [dic setObject:model.adTitle forKey:@"adTitle"];
    [dic setObject:model.adText forKey:@"adText"];
    [dic setObject:model.adImgPath forKey:@"adImgPath"];
    [dic setObject:model.itemId forKey:@"itemId"];

    int type = [bo.adType intValue];
    if (type == 1) {
        web.dic = dic;
    }

    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
    nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self presentViewController:nas animated:YES completion:nil];
}

#pragma mark -//处理网络请求的数据
-(NSMutableArray *)deallWithNetWorkData:(NSArray *)netDataArr{
    NSMutableArray *arr = [ NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in netDataArr) {
        PositionAdvertBO *model = [[PositionAdvertBO alloc] init];
        model.adUrl = dic[@"adUrl"];
        model.adType = dic[@"adType"];
        model.adTitle = dic[@"adTitle"];
        model.adText = dic[@"adText"];
        model.adImgPath = dic[@"adImgPath"];
        model.itemId = dic[@"itemId"];
        [arr addObject:model];
        RELEASE(model);
    }
    return arr;
}

#pragma mark --------------------- 初始化基类视图，数据信息  ---------------------
-(void)_initBaseVCInfo {
    [self initBaseVCInfo];
    [self _setCirlcleData];
}


#pragma mark ----------------------- 八大分类 -----------------------
#pragma mark - 配置八大分类数据源
-(void)_setCirlcleData {
    NSArray *lifeCircleItems = @[@{@"gcName":@"空气",@"mobileIcon":@"life_1"},
                                @{@"gcName":@"阳光",@"mobileIcon":@"life_2"},
                                @{@"gcName":@"水",@"mobileIcon":@"life_3"},
                                @{@"gcName":@"食物",@"mobileIcon":@"life_4"},
                                @{@"gcName":@"膳食",@"mobileIcon":@"life_5"},
                                @{@"gcName":@"运动",@"mobileIcon":@"life_6"},
                                @{@"gcName":@"睡眠",@"mobileIcon":@"life_7"},
                                @{@"gcName":@"心理",@"mobileIcon":@"life_8"}];
    self.middleDataArr = lifeCircleItems;
}



#pragma mark - 点击八大分类点击事件
-(void)clickCircleAtIndex:(NSInteger)circleIndex {
    sunViewController * sunVc = [[sunViewController alloc]init];
    //圈子号
    switch (circleIndex) {
        case 0://空气
        {
            sunVc.btn_tag = 100;
            sunVc.careChoosenCode = Life_Air_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Air_goodStoreRecommend_Code;
            NSString * cityStr = [userDefaultManager GetLocalDataString:@"city"];
            if (cityStr.length == 0) {
                sunVc.name_str = @"空气-深圳";
            }else{
                sunVc.name_str = [NSString stringWithFormat:@"空气-%@",cityStr];
            }
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"空气篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 1;
        }

            break;
        case 1://阳光
        {
            sunVc.btn_tag = 200;
            sunVc.name_str = @"阳光";
            sunVc.careChoosenCode = Life_Sun_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Sun_goodStoreRecommend_Code;
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"阳光篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 1;
        }

            break;
        case 2://水
        {
            sunVc.careChoosenCode = Life_Water_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Water_goodStoreRecommend_Code;
            NSLog(@"health ---- 2");
            sunVc.btn_tag = 300;
            sunVc.name_str = @"水";
            sunVc.midel_img_name = @"life_psy";
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"水篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 1;
        }

            break;
        case 3://食物
        {
            sunVc.btn_tag = 400;
            sunVc.name_str = @"食物";
            sunVc.careChoosenCode = Life_Food_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Food_goodStoreRecommend_Code;
            sunVc.midel_img_name = @"life_psy";
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"食物篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 2;
        }

            break;
        case 4://膳食
        {
            sunVc.btn_tag = 500;
            sunVc.name_str = @"膳食";
            sunVc.careChoosenCode = Life_Shanshi_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Shanshi_goodStoreRecommend_Code;
            sunVc.midel_img_name = @"life_back_calculator";
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"膳食篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 2;
        }

            break;
        case 5://运动
        {
            sunVc.careChoosenCode = Life_Exercise_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Exercise_goodStoreRecommend_Code;
            sunVc.btn_tag = 600;
            sunVc.name_str = @"运动";
            sunVc.midel_img_name = @"life_sport";
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"运动篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 3;
        }

            break;
        case 6://睡眠
        {
            sunVc.btn_tag = 700;
            sunVc.name_str = @"睡眠";
            sunVc.careChoosenCode = Life_Sleep_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Sleep_goodStoreRecommend_Code;
            sunVc.midel_img_name = @"life_psy";
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"睡眠篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 4;
        }

            break;
        case 7://心理
        {
            sunVc.btn_tag = 800;
            sunVc.name_str = @"心理";
            sunVc.careChoosenCode = Life_Psychology_careChoosenGoods_Code;
            sunVc.goodStoreRecommendCode = Life_Psychology_goodStoreRecommend_Code;
            sunVc.midel_img_name = @"life_psy";
            sunVc.logo_textArr = [NSArray arrayWithObjects:@"心理篇",@"新发现",@"新体验", nil];
            sunVc.witch_vc = 4;
        }
            break;
        default:
            break;
    }
    sunVc.name_Array = [NSArray arrayWithObjects:@"检测方法",@"相关资讯",@"好店推荐", nil];
    [self.navigationController pushViewController:sunVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

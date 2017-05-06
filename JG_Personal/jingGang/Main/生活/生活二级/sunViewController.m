//
//  sunViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "sunViewController.h"
#import "PublicInfo.h"
#import "AppDelegate.h"
#import "healthChildTableViewCell.h"
#import "mainTableViewCell.h"
#import "foodViewController.h"
#import "ZhengZhuangListVC.h"
#import "userDefaultManager.h"
#import "GlobeObject.h"
#import "RecommentCodeDefine.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
#import "H5page_URL.h"
#import "HealthDetailsViewController.h"
#import "UIView+BlockGesture.h"
#import "JGBlueToothManager.h"
#import "UIButton+Block.h"
#import "devicesViewController.h"
#import "UIView+BlockGesture.h"
#import "ZongHeZhengVC.h"
#import "SDCycleScrollView.h"
#import "comunitchildViewController.h"
#import "projectViewController.h"
#import "WebDayVC.h"
#import "Util.h"
#import "NSDate+Utilities.h"

#import "CareChoosenCollectionView.h"
#import "GoodStoreRecommendTableView.h"
#import "mapObject.h"
#import "UIViewExt.h"
#import "GoodsDetailModel.h"
#import "PStoreInfoModel.h"
#import "ListVC.h"
#import "GifManager.h"
#define mainDataReq @"INDEX_ELITE"
#define defaultRecommentCount 4

#import "mainPublicTableViewCell.h"
#import "mainPublicTableViewHeader.h"

@interface sunViewController ()<SDCycleScrollViewDelegate>
{
    UITableView   *_mytableView;
    UIScrollView  *_myScrollView;
//    UIScrollView  *_topScrollView;
    SDCycleScrollView *_topScrollView;
    VApiManager *vapManage;
    NSMutableArray *dataArray;
    NSMutableArray *secondDataArray;
    int reqNum;
    UILabel * main_lab;
    NSMutableArray *imageArray;
    UIImageView * lit_img_view;//空气中间小广告
    NSMutableArray *_headerImgArr;
    int  timeCount;
    FLAnimatedImageView *_sportBgView; //运动背景图
    CareChoosenCollectionView *careChoosenCollectionView;
    GoodStoreRecommendTableView *goodStoreRecommendTableView;
    UIView *goodsChooseenHeaderView;
    UIView *goodStoreHeaderView;
    
    NSNumber *_longtitude; //纬度
    NSNumber *_latitude;//经度
    NSNumber *_cityID;//城市ID
}

@end

NSString *const sunPublicTableViewCell = @"mainPublicTableViewCell";

@implementation sunViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    JGBlueToothManager *_JGBlueToothManager = [JGBlueToothManager shareInstances];
    main_lab.text = [NSString stringWithFormat:@"%ld",_JGBlueToothManager.userBodySyncModel.steps];
    
//    if (self.btn_tag == 100) {
//        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:64.0/255 green:159.0/255 blue:178.0/255 alpha:1];
//    }else {
        self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    [_myTimer invalidate];_myTimer = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    vapManage = [[VApiManager alloc]init];
    
    _longtitude = [[mapObject sharedMap] baiduLongitude];
    _latitude = [[mapObject sharedMap] baiduLatitude];
    _cityID = [[mapObject sharedMap] baiduCityID];
    
    
#pragma mark - 修改
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _name_str;
    
    
//    [self.navigationController.navigationBar addSubview:titleLabel];[titleLabel release];
    self.navigationItem.titleView = titleLabel;
    RELEASE(titleLabel);
    
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //增加好点的返回键
//    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"backToMain" isLeftItem:YES inResponseObject:self];
    
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    RELEASE(leftBtn);
    RELEASE(leftButton);
    
    
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
    RELEASE(rightBtn);
    RELEASE(rightButton);

    [self greatUI];
    dataArray = [[NSMutableArray alloc] init];
    secondDataArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    [self addHeaderFresh];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self _setScrollContentSize];
}


- (void)greatUI
{
    
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height-kStatuBarAndNavBarHeight);
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];
    
#pragma mark - topScrollView
    CGRect frame;
    if (__MainScreen_Height == 480) {
        frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height/3-10);
    }else{
        frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height/4+20);
    }
    _topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageURLStringsGroup:nil];
    _topScrollView.backgroundColor = [UIColor lightGrayColor];
    _topScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _topScrollView.autoScrollTimeInterval = 5.0f;
    [_myScrollView addSubview:_topScrollView];
    _mytableView = [[UITableView alloc]init];
    [_mytableView registerNib:[UINib nibWithNibName:@"mainPublicTableViewCell" bundle:nil] forCellReuseIdentifier:sunPublicTableViewCell];
    if (self.btn_tag == 100) {
        _topScrollView.hidden = YES;
        //天气父视图
        UIView * top_view = [[UIView alloc]init];
        top_view.backgroundColor = [UIColor colorWithRed:64.0/255 green:159.0/255 blue:178.0/255 alpha:1];
        top_view.frame = CGRectMake(0, 0, __MainScreen_Width, _topScrollView.frame.origin.y+_topScrollView.frame.size.height-10);
        [_myScrollView addSubview:top_view];
        //TODO:----------------天气背景图片
        UIImageView *weatherBackImageView = [[UIImageView alloc] initWithFrame:top_view.frame];
        NSInteger weather_str1 = [[userDefaultManager GetLocalDataString:@"weather_st1"] integerValue];;
        NSLog(@"天气背景图 ---- %02ld",weather_str1);
        weatherBackImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"weather%02ld",weather_str1]];
        [top_view addSubview:weatherBackImageView];
        
        //天气温度
        UILabel * weather_tem = [[UILabel alloc]init];
        weather_tem.frame = CGRectMake(45, 15, __MainScreen_Width * 2 / 3 - 45 , 45);
        weather_tem.textColor = [UIColor whiteColor];
        weather_tem.font = [UIFont systemFontOfSize:40];
        if ([userDefaultManager GetLocalDataString:@"maxWeather"]) {
            weather_tem.text = [NSString stringWithFormat:@"%@~%@",[userDefaultManager GetLocalDataString:@"maxWeather"],[userDefaultManager GetLocalDataString:@"minWeather"]];
        }else{
            weather_tem.text = @"暂无数据";
        }
        [top_view addSubview:weather_tem];
        
        NSDateComponents *comps = [self getCurrentDate];
        NSArray * arrWeek=[NSArray arrayWithObjects:@"星日",@"星一",@"星二",@"星三",@"星四",@"星五",@"星六", nil];
        //当前日期
        UILabel * weather_date = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMinX(weather_tem.frame), CGRectGetMaxY(weather_tem.frame), CGRectGetWidth(weather_tem.frame), 20)];
        weather_date.textColor = [UIColor whiteColor];
        weather_date.font = [UIFont systemFontOfSize:18];
        weather_date.text = [NSString stringWithFormat:@"%04ld年%02ld月%02ld日",comps.year,comps.month,comps.day];
        [top_view addSubview:weather_date];
        //周几和天气
        UILabel * weather_week = [[UILabel alloc ]initWithFrame:CGRectMake(CGRectGetMinX(weather_tem.frame), CGRectGetMaxY(weather_date.frame), CGRectGetWidth(weather_tem.frame), 20)];
        weather_week.textColor = [UIColor whiteColor];
        weather_week.font = [UIFont systemFontOfSize:18];
        NSString *statusStr = [userDefaultManager GetLocalDataString:@"weather"];
        weather_week.text = [NSString stringWithFormat:@"%@   %@",arrWeek[comps.weekday-1],statusStr ? statusStr:@""];
        [top_view addSubview:weather_week];
        
        //天气图片
        UIImageView *weather_StatusImage = [[UIImageView alloc ]initWithFrame:CGRectMake(__MainScreen_Width * 2 / 3 + 30, CGRectGetMinY(weather_tem.frame) , __MainScreen_Width  / 3 - 60, __MainScreen_Width / 3 - 60)];
        weather_StatusImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"weatherStatus%02ld",weather_str1]];
        [top_view addSubview:weather_StatusImage];
        
        float line_lab_spase = __MainScreen_Width/3;
        NSString * str = [userDefaultManager GetLocalDataString:@"pm"];
        NSString * str2 = [userDefaultManager GetLocalDataString:@"sd_num"];
        NSString * str3 = [userDefaultManager GetLocalDataString:@"weather_wind"];
        NSLog(@"pm ----- %@  wind ----- %@",str,str3);
        NSArray * array = [NSArray arrayWithObjects:@"风向",@"PM2.5",@"湿度", nil];
        NSArray * array_weather = [NSArray arrayWithObjects:str3,str,str2, nil];
        NSArray * array_weather2 = [NSArray arrayWithObjects:@"东风",@"80",@"47%", nil];
        CGFloat y = (CGRectGetHeight(top_view.frame) - CGRectGetMaxY(weather_week.frame) - 40) / 2  + CGRectGetMaxY(weather_week.frame);
        for (int i = 0; i < 3; i ++) {
            if (i < 2) {
                UILabel * line_lab = [[UILabel alloc]init];
                line_lab.frame = CGRectMake((i+1)*line_lab_spase, y, 0.5, 40);
                line_lab.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
                [top_view addSubview:line_lab];
                RELEASE(line_lab);
            }
            UILabel * name_lab = [[UILabel alloc]init];
            name_lab.frame = CGRectMake(i*line_lab_spase+5, y, line_lab_spase, 13);
            name_lab.text = [array objectAtIndex:i];
            name_lab.textAlignment = NSTextAlignmentCenter;
            name_lab.textColor = [UIColor whiteColor];
            name_lab.font = [UIFont systemFontOfSize:14];
            [top_view addSubview:name_lab];
            RELEASE(name_lab);
            
            UILabel * weather_lab = [[UILabel alloc]init];
            weather_lab.frame = CGRectMake(i*line_lab_spase+5, name_lab.frame.origin.y+name_lab.frame.size.height+5, line_lab_spase, 20);
            NSString * str = [userDefaultManager GetLocalDataString:@"pm"];
            if (str.length == 0) {
                weather_lab.text = [array_weather2 objectAtIndex:i];
            }else{
                weather_lab.text = [array_weather objectAtIndex:i];
            }
            weather_lab.textAlignment = NSTextAlignmentCenter;
            weather_lab.textColor = [UIColor whiteColor];
            weather_lab.font = [UIFont systemFontOfSize:17];
            [top_view addSubview:weather_lab];
            RELEASE(weather_lab);
        }
        
        lit_img_view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yunAd"]];
        lit_img_view.tag = 10081;
        lit_img_view.frame = CGRectMake(0, top_view.frame.origin.y+top_view.frame.size.height+10, __MainScreen_Width, 55);
        [_myScrollView addSubview:lit_img_view];

        UIButton * btn = [[UIButton alloc]initWithFrame:lit_img_view.frame];
        [btn addTarget:self action:@selector(btn_click) forControlEvents:UIControlEventTouchUpInside];
        [_myScrollView addSubview:btn];
        
        _mytableView.frame = CGRectMake(0, lit_img_view.frame.origin.y+lit_img_view.frame.size.height+10, __MainScreen_Width, __life_table_cell1_h*0+__table_cell1_h*0+10+__table_section_h*2);
        
        
        RELEASE(top_view);
        RELEASE(weather_img);
        RELEASE(weather_lab);
        RELEASE(weather_lab2);
        RELEASE(btn);
        
    }else if (self.btn_tag == 200|| self.btn_tag == 300 || self.btn_tag == 400 || self.btn_tag == 700) {
        _mytableView.frame = CGRectMake(0, _topScrollView.frame.origin.y+_topScrollView.frame.size.height+10, __MainScreen_Width, __life_table_cell1_h*0+__table_cell1_h*0+10+__table_section_h*2);
    }else if (self.btn_tag == 600 || self.btn_tag == 500 || self.btn_tag == 800 ){
        UIImageView * img_view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_midel_img_name]];
        img_view.tag = 10081;
//        img_view.frame = CGRectMake(0, _topScrollView.frame.origin.y+_topScrollView.frame.size.height, __MainScreen_Width, 95);
         img_view.frame = CGRectMake(0, _topScrollView.frame.origin.y+_topScrollView.frame.size.height, __MainScreen_Width, __MainScreen_Width / 4);
        [_myScrollView addSubview:img_view];

        if (self.btn_tag == 500) {//膳食界面
            UIButton * food_btn = [[UIButton alloc]init];
            food_btn.frame = CGRectMake(0, 0, 33, 33);
            [food_btn setBackgroundImage:[UIImage imageNamed:@"life_calculator"] forState:UIControlStateNormal];
            food_btn.center = CGPointMake(62, img_view.frame.origin.y+img_view.frame.size.height/2-10);
            food_btn.tag = 5;
            [food_btn addTarget:self action:@selector(littleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_myScrollView addSubview:food_btn];
            
            UILabel * food_btn_lab = [[UILabel alloc]init];
            food_btn_lab.frame = CGRectMake(0, food_btn.frame.origin.y+food_btn.frame.size.height+8, 125, 13);
            food_btn_lab.text = @"食物计算器";
            food_btn_lab.font = [UIFont systemFontOfSize:13];
            food_btn_lab.textAlignment = NSTextAlignmentCenter;
            food_btn_lab.textColor = [UIColor whiteColor];
            [_myScrollView addSubview:food_btn_lab];
            
            UILabel * name_lab = [[UILabel alloc]init];
            name_lab.frame = CGRectMake(125, 15, __MainScreen_Width-125, 10);
            name_lab.textColor = [UIColor whiteColor];
            name_lab.font = [UIFont systemFontOfSize:13];
            name_lab.textAlignment = NSTextAlignmentCenter;
            name_lab.text = @"膳食建议";
            [img_view addSubview:name_lab];
            
            UILabel * name_lab2 = [[UILabel alloc]init];
            name_lab2.frame = CGRectMake(125, name_lab.frame.origin.y+name_lab.frame.size.height, __MainScreen_Width-125, 20);
            name_lab2.textColor = [UIColor whiteColor];
            name_lab2.font = [UIFont systemFontOfSize:13];
            name_lab2.textAlignment = NSTextAlignmentCenter;
            name_lab2.text = @"Recommendation of dietary";
            [img_view addSubview:name_lab2];
        
            UIButton * test_btn = [[UIButton alloc]init];
            test_btn.frame = CGRectMake(0, 0, 101, 32);
            test_btn.tag = 6;
            test_btn.center = CGPointMake(125+(__MainScreen_Width-125)/2, img_view.frame.origin.y+img_view.frame.size.height/2+16);
            [test_btn setTitle:@"开始计算" forState:UIControlStateNormal];
            test_btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [test_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [test_btn setBackgroundImage:[UIImage imageNamed:@"life_button"] forState:UIControlStateNormal];
            [test_btn setBackgroundImage:[UIImage imageNamed:@"life_button_pressed"] forState:UIControlStateHighlighted];
            [test_btn addTarget:self action:@selector(littleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_myScrollView addSubview:test_btn];
            
            RELEASE(food_btn);
            RELEASE(food_btn_lab);
            RELEASE(name_lab);
            RELEASE(name_lab2);
            RELEASE(test_btn);

        }else if (self.btn_tag == 600) {//运动界面
            
            _sportBgView = [[FLAnimatedImageView alloc] initWithFrame:img_view.bounds];
            [img_view addSubview:_sportBgView];
            
            UILabel * name_lab = [[UILabel alloc]init];
            name_lab.frame = CGRectMake(__MainScreen_Width/2, 15, 200, 10);
            name_lab.textColor = [UIColor whiteColor];
            name_lab.font = [UIFont systemFontOfSize:13];
            name_lab.text = @"今天运动步数";
            [img_view addSubview:name_lab];
            
            UILabel * name_lab2 = [[UILabel alloc]init];
            name_lab2.frame = CGRectMake(name_lab.frame.origin.x+5, name_lab.frame.origin.y+name_lab.frame.size.height, 200, 20);
            name_lab2.textColor = [UIColor whiteColor];
            name_lab2.font = [UIFont systemFontOfSize:13];
            name_lab2.text = @"Today steps";
            [img_view addSubview:name_lab2];
            
            main_lab = [[UILabel alloc]init];
            main_lab.frame = CGRectMake(name_lab2.frame.origin.x, name_lab2.frame.origin.y+name_lab2.frame.size.height-5, 200, 40);
            main_lab.textColor = [UIColor whiteColor];
            main_lab.font = [UIFont systemFontOfSize:35];
            [img_view addSubview:main_lab];
            
            img_view.userInteractionEnabled = YES;
            [img_view addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                //进入手环页面
            }];
            
        }else if (self.btn_tag == 800){//心理界面
            UILabel * name_lab = [[UILabel alloc]init];
            name_lab.frame = CGRectMake(0, 15, __MainScreen_Width, 10);
            name_lab.textColor = [UIColor whiteColor];
            name_lab.font = [UIFont systemFontOfSize:13];
            name_lab.textAlignment = NSTextAlignmentCenter;
            name_lab.text = @"心理测试题";
            [img_view addSubview:name_lab];
            
            UILabel * name_lab2 = [[UILabel alloc]init];
            name_lab2.frame = CGRectMake(0, name_lab.frame.origin.y+name_lab.frame.size.height, __MainScreen_Width, 20);
            name_lab2.textColor = [UIColor whiteColor];
            name_lab2.textAlignment = NSTextAlignmentCenter;
            name_lab2.font = [UIFont systemFontOfSize:13];
            name_lab2.text = @"Psychological test";
            [img_view addSubview:name_lab2];
            
            UIButton * test_btn = [[UIButton alloc]init];
            test_btn.frame = CGRectMake(0, 0, 101, 32);
            test_btn.tag = 8;
            test_btn.center = CGPointMake(__MainScreen_Width/2, img_view.frame.origin.y+img_view.frame.size.height/2+16);
            [test_btn setTitle:@"开始测试" forState:UIControlStateNormal];
            test_btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [test_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [test_btn setBackgroundImage:[UIImage imageNamed:@"life_button"] forState:UIControlStateNormal];
            [test_btn setBackgroundImage:[UIImage imageNamed:@"life_button_pressed"] forState:UIControlStateHighlighted];
            [test_btn addTarget:self action:@selector(littleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_myScrollView addSubview:test_btn];
            
            RELEASE(name_lab);
            RELEASE(name_lab2)
            RELEASE(test_btn);
        }
        _mytableView.frame = CGRectMake(0, img_view.frame.origin.y+img_view.frame.size.height+10, __MainScreen_Width, __table_cell1_h*0+__table_section_h);
    }
    _mytableView.scrollEnabled = NO;
    _mytableView.delegate = self;
    _mytableView.dataSource = self;
    [_myScrollView addSubview:_mytableView];
    

     #pragma mark - 修改的，推荐
     #pragma mark - 精选商品修改的
     goodsChooseenHeaderView = BoundNibView(@"CareChoosenGoodsHeaderView", UIView);
     goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_mytableView.frame)+10, kScreenWidth, 30);
     [_myScrollView addSubview:goodsChooseenHeaderView];
     careChoosenCollectionView = [[CareChoosenCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, kCareChoosenGoodsCellHeight*2) collectionViewLayout:nil];
     [_myScrollView addSubview:careChoosenCollectionView];
     
     #pragma mark - 好店推荐修改的
     goodStoreHeaderView = BoundNibView(@"GoodStoreRecommendHeaderView", UIView);
     goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame)+10, kScreenWidth, 30);
     [_myScrollView addSubview:goodStoreHeaderView];
     
     goodStoreRecommendTableView = [[GoodStoreRecommendTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, GoodStoreCellHeight*defaultRecommentCount) style:UITableViewStylePlain];
     [_myScrollView addSubview:goodStoreRecommendTableView];
     
     //设置scrollView 内容尺寸
//     [self _setScrollContentSize];
    [self performSelector:@selector(_setScrollContentSize) withObject:nil afterDelay:1.0];
    
     //请求精选商品
     [self _requestCareChoosenGoods];

}

-(void)_setScrollContentSize {

        _myScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(goodStoreRecommendTableView.frame));


}

#pragma mark - 请求精选商品
-(void)_requestCareChoosenGoods{
    
    VApiManager *vapManager = [[VApiManager alloc] init];
    SnsCrcListRequest *request = [[SnsCrcListRequest alloc] init:GetToken];
    request.api_lat = _latitude;
    request.api_lon = _longtitude;
    request.api_cityId = _cityID;
    request.api_posCode = self.careChoosenCode;
    
    [vapManager snsCrcList:request success:^(AFHTTPRequestOperation *operation, SnsCrcListResponse *response) {
        
        NSLog(@"首页精选商品 response %@",response);
        NSInteger itemCount = response.advList.count;
//        itemCount = 4;
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
            goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_mytableView.frame)+10, kScreenWidth, 30);
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
    request.api_posCode = self.goodStoreRecommendCode;
    
    [vapManager snsCrcList:request success:^(AFHTTPRequestOperation *operation, SnsCrcListResponse *response) {
        
        NSLog(@"首页好店推荐 response %@",response);
        NSInteger itemCount = response.advList.count;
        if (itemCount > 0) {
           
            NSInteger storeCount = 0;
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

        }else {
            [self _goodStoreRecommendNoDataSoleve];
        }
        
        [self performSelector:@selector(_setScrollContentSize) withObject:nil afterDelay:1.0f];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self _goodStoreRecommendNoDataSoleve];
        [self performSelector:@selector(_setScrollContentSize) withObject:nil afterDelay:1.0f];
    }];
}

#pragma mark - 精选商品没数据处理
- (void)_careChoosenGoodsNodataSoleve {
    
    careChoosenCollectionView.hidden = YES;
    goodsChooseenHeaderView.hidden = YES;
    goodsChooseenHeaderView.frame = CGRectMake(0, CGRectGetMaxY(_mytableView.frame), kScreenWidth, 1);
    careChoosenCollectionView.frame = CGRectMake(0, CGRectGetMaxY(goodsChooseenHeaderView.frame), kScreenWidth, 1);
}



#pragma mark - 好店推荐没数据处理
-(void)_goodStoreRecommendNoDataSoleve {
    
    goodStoreHeaderView.hidden = YES;
    goodStoreRecommendTableView.hidden = YES;
    goodStoreHeaderView.frame = CGRectMake(0, CGRectGetMaxY(careChoosenCollectionView.frame), kScreenWidth, 1);
    goodStoreRecommendTableView.frame = CGRectMake(0, CGRectGetMaxY(goodStoreHeaderView.frame), kScreenWidth, 1);
}








- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.btn_tag == 100|| self.btn_tag == 300 || self.btn_tag == 400 || self.btn_tag == 200) {
        if (section == 0) {//2
            return dataArray.count+1;
        }else{
            return secondDataArray.count;
        }
    }else if (self.btn_tag == 600){
        return secondDataArray.count;
    }else{
        return secondDataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 0;
    if (self.btn_tag == 200 || self.btn_tag == 100|| self.btn_tag == 300 || self.btn_tag == 400) {
        if (indexPath.section == 0) {
           // NSInteger count = dataArray.count > 2?2:dataArray.count;
            NSInteger count = dataArray.count ;
           // count = count == 0 ? 2 : count;//2
            if (indexPath.row < count) {
                height = __life_table_cell1_h;
            }else{
                height = 10;
            }
        }else{
            height = __table_cell1_h;
        }
    }else if (self.btn_tag == 600){
        height = __table_cell1_h;
    }else {
        height = __table_cell1_h;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.btn_tag == 200 || self.btn_tag == 100|| self.btn_tag == 300 || self.btn_tag == 400) {
        if (indexPath.section == 0) {
            static NSString  *cellstr = @"cell1";
            healthChildTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
            if (!cell) {
                NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"healthChildTableViewCell" owner:self options:nil];
                NSInteger a = indexPath.row%2;
                if (a==1) {//调整顺序
                    a = 0;
                }else{
                    a = 1;
                }
                cell = [array objectAtIndex:a];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (dataArray && dataArray.count > 0 && dataArray.count > indexPath.row) {
                PositionAdvertBO *bo = dataArray[indexPath.row];
                if (indexPath.row%2 == 1) {
                    cell.name_lab.text = bo.adTitle;
                    cell.dis_lab.text = bo.adText;
                     NSString *url = [NSString stringWithFormat:@"%@_%ix%i",bo.adImgPath,(int)cell.left_img.frame.size.width*2,(int)cell.left_img.frame.size.height*2];
                    [cell.left_img sd_setImageWithURL:[NSURL URLWithString:url]];
                }else{
                    cell.name_lab2.text = bo.adTitle;
                    cell.dis_lab2.text = bo.adText;
                    NSString *url = [NSString stringWithFormat:@"%@_%ix%i",bo.adImgPath,(int)cell.right_img.frame.size.width*2,(int)cell.right_img.frame.size.height*2];
                    [cell.right_img sd_setImageWithURL:[NSURL URLWithString:url]];
                }
               
            }
           // NSInteger count = dataArray.count > 2?2:dataArray.count;
           // count = count == 0 ? 2 : count;
            NSInteger count = dataArray.count;
            if (indexPath.row < count) {
                tableView.rowHeight = __life_table_cell1_h;
                cell.contentView.hidden = NO;
            }else{
                tableView.rowHeight = 10;
                cell.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
                cell.left_img.hidden = YES;
                cell.left_lab.hidden = YES;
                cell.name_lab.hidden = YES;
                cell.dis_lab.hidden = YES;
                cell.contentView.hidden = YES;
            }
            return cell;
        }else{
            static NSString * cellstr2 = @"cell2";
            mainPublicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:sunPublicTableViewCell];
            if (1) {
//                NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"mainTableViewCell" owner:self options:nil];
//                cell = [array objectAtIndex:0];
                tableView.rowHeight = __table_cell1_h;
                cell.left_img.layer.cornerRadius = 6;
                cell.left_img.clipsToBounds = YES;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (secondDataArray && secondDataArray.count > 0 && indexPath.row < secondDataArray.count) {
                PositionAdvertBO *bo = secondDataArray[indexPath.row];
                cell.name_lab.text = bo.adTitle;
                cell.sub_lab.text = bo.adText;
                [cell.left_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_160x150",bo.adImgPath]]];
            }
            return cell;
        }
    }
    else{
        static NSString * cellstr2 = @"cell2";
        mainTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellstr2];
        if (indexPath.section == 0) {
            NSLog(@"7000000创建单元格");
            if (!cell) {
                NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"mainTableViewCell" owner:self options:nil];
                cell = [array objectAtIndex:0];
                tableView.rowHeight = __table_cell1_h;
                cell.left_img.layer.cornerRadius = 6;
                cell.left_img.clipsToBounds = YES;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (secondDataArray && secondDataArray.count > 0) {
                PositionAdvertBO *bo = secondDataArray[indexPath.row];
                cell.name_lab.text = bo.adTitle;
                cell.sub_lab.text = bo.adText;
                [cell.left_img sd_setImageWithURL:[NSURL URLWithString:bo.adImgPath]];
                NSLog(@"睡眠img_URL ===== %@   当前第%d行",bo.adImgPath,indexPath.row);
            }

        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PositionAdvertBO *model = nil;
    
    NSLog(@"secondeDataArr:%@",secondDataArray);
    NSLog(@"dataArray%@",dataArray);
    NSLog(@"selecte section %ld",indexPath.section);
    if (indexPath.section == 0) {
        if (self.btn_tag == 800 || self.btn_tag == 600 || self.btn_tag == 700 || self.btn_tag == 500) {
            if (secondDataArray.count > indexPath.row) {
               model = secondDataArray[indexPath.row];;
            }
        }else{
            if (dataArray.count > indexPath.row) {
                model = dataArray[indexPath.row];
            }
        }
    }else if (indexPath.section == 1){
        if (secondDataArray.count > indexPath.row) {
             model = secondDataArray[indexPath.row];
        }
    }
    
    NSString *adUrl = @"adUrl";
    if (model && model.adUrl) {
        adUrl = model.adUrl;
    }
    
    NSMutableDictionary *ser = [NSMutableDictionary dictionary];

    NSLog(@"adI %@ %@ %@ %@ %@ %@",model.adImgPath,model.adType,model.adUrl,model.adText,model.adTitle,model.itemId);
    if (model.adImgPath) {
        [ser setObject:model.adImgPath forKey:@"adImgPath"];
    }
    if (model.adType) {
        [ser setObject:model.adType forKey:@"adType"];
    }
    if (model.adUrl) {
        [ser setObject:model.adUrl forKey:@"adUrl"];
    }
    if (model.adTitle) {
        [ser setObject:model.adTitle forKey:@"adTitle"];
    }
    if (model.adText) {
        [ser setObject:model.adText forKey:@"adText"];
    }
    if (model.itemId) {
        [ser setObject:model.itemId forKey:@"itemId"];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@%@",Base_URL,[ser objectForKey:@"adUrl"]];
    NSLog(@"%@",str);
    [[NSUserDefaults standardUserDefaults]setObject:[ser objectForKey:@"adTitle"] forKey:@"circleTitle"];
    WebDayVC *web = [[WebDayVC alloc]init];
    web.strUrl = str;
    int type = [[ser objectForKey:@"adType"] intValue];
    if (type == 1) {
        web.dic = ser;
    }
    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
    nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self presentViewController:nas animated:YES completion:nil];
    
    RELEASE(web);
    RELEASE(nas);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.btn_tag == 200|| self.btn_tag == 100|| self.btn_tag == 300 || self.btn_tag == 400) {
        return 2;
    }else if (self.btn_tag == 600){
        return 1;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return __table_section_h;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.tag = section;//给自定义的表头加tag值
    view.backgroundColor = [UIColor whiteColor];
    
//    NSArray * name_array = [NSArray arrayWithObjects:@"检测方法",@"相关资讯",@"好店推荐", nil];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, __table_section_h-10, __table_section_h-10)];
    img.image = [UIImage imageNamed:[NSString stringWithFormat:@"life_lit%ld",(long)(section + 1)]];
    [view addSubview:img];

    
    UILabel * name_lab = [[UILabel alloc]initWithFrame:CGRectMake(img.frame.size.width+img.frame.origin.x+10, 5, 100, __table_section_h-10)];
    name_lab.text = [_name_Array objectAtIndex:section];
    name_lab.font = [UIFont systemFontOfSize:15];
    if (section == 0) {
        name_lab.textColor = health_color_1;
    }else if (section == 1){
        name_lab.textColor = color_section_1;
    }else{
        name_lab.textColor = color_section_1;
    }
    [view addSubview:name_lab];

    
    UIImageView * logo_img = [[UIImageView alloc]initWithFrame:CGRectMake(name_lab.frame.size.width+name_lab.frame.origin.x-30, 5, 60, 20)];
    logo_img.image = [UIImage imageNamed:[NSString stringWithFormat:@"life_back_word_lit0%ld",(long)section+1]];
    [view addSubview:logo_img];

    
//    NSArray * logo_textArr = [NSArray arrayWithObjects:@"阳光",@"阳光篇",@"新体验", nil];
    UILabel * logo_lab = [[UILabel alloc]initWithFrame:CGRectMake(name_lab.frame.size.width+name_lab.frame.origin.x-30, 5, 60, 20)];
    logo_lab.textColor = [UIColor whiteColor];
    logo_lab.text = [_logo_textArr objectAtIndex:section];
    logo_lab.font = [UIFont systemFontOfSize:13];
    logo_lab.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:logo_lab];

 
    UIButton * right_lab = [[UIButton alloc]initWithFrame:CGRectMake(__MainScreen_Width-75, 5, 60, __table_section_h-10)];
    [right_lab setTitle:@"更多" forState:UIControlStateNormal];
    right_lab.titleLabel.font = [UIFont systemFontOfSize:16];
    [right_lab setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [right_lab addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *more_imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(__MainScreen_Width-26, 8, 12, 14)];
    
    //    [moreBtn setBackgroundImage:[UIImage imageNamed:@"main_more"] forState:UIControlStateNormal];
    more_imgView2.image = [UIImage imageNamed:@"main_more"];
    


    if (self.btn_tag == 200|| self.btn_tag == 100|| self.btn_tag == 300 || self.btn_tag == 400 ) {
        if (section == 1) {
            [view addSubview:right_lab];
            [view addSubview:more_imgView2];

        }
    }else{
        [view addSubview:right_lab];
        [view addSubview:more_imgView2];
    }
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(__MainScreen_Width-80, 0, 80, __table_section_h)];
    rightBtn.tag = section;
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:rightBtn];[rightBtn release];
    
    UILabel * lab = [[UILabel alloc]init];
    lab.frame = CGRectMake(0, 29, __MainScreen_Width, 0.5);
    lab.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [view addSubview:lab];

    
    return AUTO_RELEASE(view);
}
//相关资讯跳转界面
-(void)BtnCLICK
{
    comunitchildViewController * comunitchildVc = [[comunitchildViewController alloc]init];
    switch (self.witch_vc) {
        case 1:
        {
            comunitchildVc.cycleId = 4;
            comunitchildVc.head_img_str = @"com_life02";
            comunitchildVc.JGTitle = @"生活圈";
        }
            break;
        case 2:
        {
            comunitchildVc.cycleId = 2;
            comunitchildVc.head_img_str = @"com_drink02";
            comunitchildVc.JGTitle = @"饮食圈";
        }
            break;
        case 3:
        {
            comunitchildVc.cycleId = 3;
            comunitchildVc.head_img_str = @"com_sport02";
            comunitchildVc.JGTitle = @"运动圈";
        }
            break;
        case 4:
        {
            comunitchildVc.cycleId = 1;
            comunitchildVc.head_img_str = @"com_subh02";
            comunitchildVc.JGTitle = @"亚健康圈";
        }
            break;
            
        default:
            break;
    }
//    comunitchildVc.witch_vc = 1;
    [self.navigationController pushViewController:comunitchildVc animated:YES];
//    [Util preSentVCWithRootVC:comunitchildVc withPrensentVC:self];
}


//控制表格线条从左边开始
-(void)viewDidLayoutSubviews
{
    if ([_mytableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_mytableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_mytableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_mytableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
    NSLog(@"more");
    [self BtnCLICK];
}

- (void)littleBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 5:
        {
            ListVC *listVC = [[ListVC alloc] init];
            listVC.listType = FoodCalculatorType;
            [self.navigationController pushViewController:listVC animated:YES];
            
            
        }
            break;
        case 6:
        {
            //膳食界面膳食建议计算
            foodViewController * foodVc = [[foodViewController alloc]init];
            [self.navigationController pushViewController:foodVc animated:YES];

        }
            break;
        case 7:
        {
            //运动界面
            
            
        }
            break;
        case 8:
        {
            //心理界面计算
            ZongHeZhengVC *zongHeZhengVC = [[ZongHeZhengVC alloc] init];
            zongHeZhengVC.comminType = Commin_From_Heart;
            zongHeZhengVC.selfTestTiID = @59;
            [self.navigationController pushViewController:zongHeZhengVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void) backToMain
{
//    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [app gogogoWithTag:1];
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 请求网络
-(void)_requestAdDataWithCode:(NSString *)addCode{
    
    reqNum++;
    NSString *token = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:token];
    request.api_posCode = addCode;
    [vapManage snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        reqNum--;
        NSLog(@"shanshishouye --- %@",response.advList);
        
        if ([addCode isEqualToString:Kongqi_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Yangguang_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Shui_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Shiwu_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Shanshi_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Yundong_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Shuimian_shouye_xiangguan_zixun]
            || [addCode isEqualToString:Xinli_shouye_xiangguan_zixun]) {
            secondDataArray = [self deallWithNetWorkData:response.advList];
            NSLog(@"相关资讯 ------ %@",secondDataArray);
        }else if ([addCode isEqualToString:Kongqi_shouye_jiangce_fangfa]
                  || [addCode isEqualToString:Yangguang_shouye_jiangce_fangfa]
                  || [addCode isEqualToString:Shui_shouye_jiangce_fangfa]
                  || [addCode isEqualToString:Shiwu_shouye_jiangce_fangfa]){
            dataArray = [self deallWithNetWorkData:response.advList];
            NSLog(@"检测方法 ------ %@",dataArray);
        }else if ([addCode isEqualToString:Yangguang_shouye_jingang_xiangmu]
                  || [addCode isEqualToString:Shanshi_shouye_jingang_xiangmu]
                  || [addCode isEqualToString:Yundong_shouye_jingang_xiangmu]
                  || [addCode isEqualToString:Shuimian_shouye_jingang_xiangmu]
                  || [addCode isEqualToString:Xinli_shouye_jingang_xiangmu]
                  || [addCode isEqualToString:Shui_shouye_jingang_xiangmu]
                  || [addCode isEqualToString:Shiwu_shouye_jingang_xiangmu]){
            NSMutableArray *array = [self deallWithNetWorkData:response.advList];
            [self reloadToScrollView:array];
        }else if ([addCode isEqualToString:Kongqi_shouye_jingang_xiangmu]){
            NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"首页推荐。。。%@",dict);
            NSArray  * img_arr = [dict objectForKey:@"advList"];
            NSString * img_str = [[img_arr objectAtIndex:0] objectForKey:@"adImgPath"];
            [lit_img_view sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_720x124",img_str]] placeholderImage:[UIImage imageNamed:@"yunAd"]];
        }else if ([addCode isEqualToString:Yundong_steps_imgCode]){//运动步数
            NSLog(@"运动步数 %@",response);
            if (response.advList > 0) {
                NSString *urlStr = response.advList[0][@"adImgPath"];
                [self _dealSportBgViewWihtUrl:urlStr];
            }
        }
        if(reqNum == 0){
            [_myScrollView headerEndRefreshing];
        }
        [_mytableView reloadData];
        [self updateFrame];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        reqNum--;
        if(reqNum == 0){
            [_myScrollView headerEndRefreshing];
        }
    }];
}

#pragma mark - 处理运动背景
-(void)_dealSportBgViewWihtUrl:(NSString *)urlStr {
    
    [GifManager loadAnimatedImageWithURL:[NSURL URLWithString:urlStr] progress:nil completionFLImage:^(FLAnimatedImage *animatedImage) {
        _sportBgView.animatedImage = animatedImage;
        
    } completionNormalImage:nil];

}

-(void)updateFrame{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *view in _myScrollView.subviews) {
        if (view.frame.origin.y > _mytableView.bottom) {
            [array addObject:view];
        }
    }
    float bottom = _mytableView.bottom;
    float fs = dataArray.count;
#pragma mark - 空气修改
//    if (fs > 2 || fs <= 0) {
//        fs = 2;
//    }
    float se = secondDataArray.count;
//    if (se > 4 || se <= 0) {
//        se = 4;
//    }
    if (self.btn_tag == 100) {
        UIView *img_view = [_myScrollView viewWithTag:10081];
        _mytableView.frame = CGRectMake(0, img_view.frame.origin.y+img_view.frame.size.height+10, __MainScreen_Width, __life_table_cell1_h*fs+__table_cell1_h*se+10+__table_section_h*2);
    }else if (self.btn_tag == 500 || self.btn_tag == 800 || self.btn_tag == 600){
        UIView *img_view = [_myScrollView viewWithTag:10081];
        _mytableView.frame = CGRectMake(0, img_view.frame.origin.y+img_view.frame.size.height+10, __MainScreen_Width, __table_cell1_h*se+__table_section_h);
    }else{
        _mytableView.frame = CGRectMake(0, _topScrollView.frame.origin.y+_topScrollView.frame.size.height+10, __MainScreen_Width, __life_table_cell1_h*fs+__table_cell1_h*se+10+__table_section_h*2);
        if (self.btn_tag == 700) {
            _mytableView.frame = CGRectMake(0, _topScrollView.frame.origin.y+_topScrollView.frame.size.height+10, __MainScreen_Width, __table_cell1_h*se+10+__table_section_h);
        }
    }
    float temp = bottom - _mytableView.bottom;
    for (UIView *view in array) {
        [view setTop:view.top-temp];
        if (view.tag == 10086) {
            if (self.name_str.length < 3) {
                _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, view.frame.origin.y+view.frame.size.height+__Other_Height+10);
            }else{
                _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, view.frame.origin.y+view.frame.size.height+10);
            }
        }
    }
}
#pragma mark - 处理头部scroll view
-(void)reloadToScrollView:(NSMutableArray *)array {
    
    _headerImgArr = array;
    //获取图片url数组
    NSMutableArray *clearImgUrlArr = [NSMutableArray arrayWithCapacity:array.count];
    for (PositionAdvertBO *model in array) {
        
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
    PositionAdvertBO *model = _headerImgArr[index];
    NSMutableDictionary *ser = [NSMutableDictionary dictionary];
    [ser setObject:model.adImgPath forKey:@"adImgPath"];
    [ser setObject:model.adType forKey:@"adType"];
    [ser setObject:model.adUrl forKey:@"adUrl"];
    [ser setObject:model.adTitle forKey:@"adTitle"];
    [ser setObject:model.adText forKey:@"adText"];
    [ser setObject:model.itemId forKey:@"itemId"];
    NSString *str = [NSString stringWithFormat:@"%@%@",Base_URL,[ser objectForKey:@"adUrl"]];
    NSLog(@"%@",str);
    [[NSUserDefaults standardUserDefaults]setObject:[ser objectForKey:@"adTitle"] forKey:@"circleTitle"];
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

#pragma mark - 头部刷新
- (void)addHeaderFresh{
    
    WEAK_SELF;
    [_myScrollView addHeaderWithCallback:^{
        switch (weak_self.btn_tag) {
            case 100:
            {
                [weak_self _requestAdDataWithCode:Kongqi_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Kongqi_shouye_xiangguan_zixun];
                [weak_self _requestAdDataWithCode:Kongqi_shouye_jiangce_fangfa];
            }
                break;
            case 200:
            {
                [weak_self _requestAdDataWithCode:Yangguang_shouye_xiangguan_zixun];
                [weak_self _requestAdDataWithCode:Yangguang_shouye_jiangce_fangfa];
                [weak_self _requestAdDataWithCode:Yangguang_shouye_jingang_xiangmu];
            }
                break;
            case 300:
            {
                [weak_self _requestAdDataWithCode:Shui_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Shui_shouye_xiangguan_zixun];
                [weak_self _requestAdDataWithCode:Shui_shouye_jiangce_fangfa];
            }
                break;
            case 400:
            {
                [weak_self _requestAdDataWithCode:Shiwu_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Shiwu_shouye_xiangguan_zixun];
                [weak_self _requestAdDataWithCode:Shiwu_shouye_jiangce_fangfa];
            }
                break;
            case 500:
            {
                [weak_self _requestAdDataWithCode:Shanshi_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Shanshi_shouye_xiangguan_zixun];
            }
                break;
            case 600:
            {
                [weak_self _requestAdDataWithCode:Yundong_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Yundong_shouye_xiangguan_zixun];
                [weak_self _requestAdDataWithCode:Yundong_steps_imgCode];
            }
                break;
            case 700:
            {
                [weak_self _requestAdDataWithCode:Shuimian_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Shuimian_shouye_xiangguan_zixun];
            }
                break;
            case 800:
            {
                [weak_self _requestAdDataWithCode:Xinli_shouye_jingang_xiangmu];
                [weak_self _requestAdDataWithCode:Xinli_shouye_xiangguan_zixun];
            }
                break;
            default:
                break;
        }
        [weak_self _requestCareChoosenGoods];
    }];
    [_myScrollView headerBeginRefreshing];
    
}

#pragma mark -//处理网络请求的数据
-(NSMutableArray *)deallWithNetWorkData:(NSArray *)netDataArr{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
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

- (void)btn_click
{
    projectViewController * devicesVc = [[projectViewController alloc]init];
    [self.navigationController pushViewController:devicesVc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDateComponents *)getCurrentDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.timeZone = [[NSTimeZone alloc ] initWithName:@"zh_CH"];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:date];
    return comps;
}


@end

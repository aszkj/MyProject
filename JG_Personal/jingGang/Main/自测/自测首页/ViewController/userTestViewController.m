//
//  userTestViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "userTestViewController.h"
#import "userTestTableViewCell.h"
#import "WWSideslipViewController.h"
#import "userDefaultManager.h"
#import "someTestViewController.h"
#import "VApiManager.h"
#import "RecommentCodeDefine.h"
#import "SelfTestPerDayJinhuaModel.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "UIView+BlockGesture.h"
#import "UIButton+Block.h"
#import "Util.h"
#import "GlobeObject.h"
#import "TMCache.h"
#import "JGBlueToothManager.h"
#import "JGHealthTaskManager.h"
#import "devicesViewController.h"
#import "CompletePersoninfoVC.h"
#import "mydevieseViewController.h"
#import "WebDayVC.h"
#import "H5page_URL.h"
#import "AppDelegate.h"
#import "H5Base_url.h"
#import "DefuController.h"
#import "consultationViewController.h"
#import "ZongHeZhengVC.h"
#import "ZhengZhuangVC.h"

#import "mainPublicTableViewCell.h"
#import "mainPublicTableViewHeader.h"


//表不变部分的高度
#define Table_Not_Change_Height (__text_table_cell1_h*1+__text_table_cell2_h*2+__table_section_h*3+20)
@interface userTestViewController ()<SDCycleScrollViewDelegate>
{
    UIButton          *_head_btn;
    BOOL               _headYorN;
    float             _tableView_height;
    VApiManager        *_vapManager;
    
    NSMutableArray     *adArr;
    NSMutableArray     *headImgArr;
    
    NSArray            *dataArr;
    BOOL                _isComminBeginFresh;//开始进来就刷新
    BOOL               _isPullFresh;//是否下拉刷新，默认下拉
    TMCache            *_cache;      //缓存类
    
    NSString *headImgUrl;
    
    JGBlueToothManager *_jgBlutoothManager;
}

@property (nonatomic) UITableView *myTableView;

@end

NSString *const userTableViewCell = @"mainPublicTableViewCell";

@implementation userTestViewController



- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = kGetColor(232, 36, 39);
    [userDefaultManager SetLocalDataString:@"20" key:@"innerRadius"];
    [userDefaultManager SetLocalDataString:@"25" key:@"outerRadius"];
    [super viewWillAppear:animated];
    
    // 友盟统计
    [MobClick beginLogPageView:kMeasureViewController];

    [_myTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 友盟统计
    [MobClick endLogPageView:kMeasureViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _jgBlutoothManager = [JGBlueToothManager shareInstances];
    
    //初始化父类信息
    [self _initBaseVCInfo];
    
    [self _initCacheData];
    
    //默认下拉刷新
    _isPullFresh = YES;
    _vapManager = [[VApiManager alloc] init];
    adArr = [NSMutableArray arrayWithCapacity:0] ;
    headImgArr = [NSMutableArray arrayWithCapacity:0];
    self.jtitle = @"健康自测";
    
    [_myScrollView addSubview:self.myTableView];
    
    //给整个添加头部刷新
    [self addHeaderFresh];
    //请求网络
    [self _requestAdDataWithCode:Zice_shouye_code];
    [self _requestAdDataWithCode:Zice_shouye_mei_ri_jinghua_code];
    
}



#pragma mark  - 初始化缓存信息
-(void)_initCacheData{

    _cache = [TMCache sharedCache];
    //每日精华缓存
    NSArray *perdayesseneArr = [_cache objectForKey:Tuijianwei_perdayessene_cache_selfTestID];
    dataArr = [PositionAdvertBO objectArrayWithKeyValuesArray:perdayesseneArr];
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    _myTableView.frame = CGRectMake(0, _tableView_height, __MainScreen_Width, __text_table_cell1_h*1+__text_table_cell2_h*2+__table_cell3_h*dataArr.count+__table_section_h*3+20);
    _myTableView.frame = CGRectMake(0, _tableView_height, __MainScreen_Width, __table_cell3_h*dataArr.count+__table_section_h*3+20);
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, _tableView_height+_myTableView.frame.size.height+10);
    NSInteger num = 0;
    switch (section) {
        case 0:
        {
//            num = 1+1;
            num = 0;
        }
            break;
        case 1:
        {
//            num = 2+1;
            num = 0;
        }
            break;
        case 2:
        {
            num = dataArr.count;
        }
            break;
        default:
            break;
    }
    return num;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        mainPublicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userTableViewCell];
        //赋值
        NSLog(@"row %ld",(long)indexPath.row);
        if (dataArr.count > indexPath.row) {
            PositionAdvertBO *model = (PositionAdvertBO *)dataArr[indexPath.row];
            [cell.left_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_%ix%i",model.adImgPath,(int)cell.left_img.frame.size.width*2,(int)cell.left_img.frame.size.height*2]] placeholderImage:[UIImage imageNamed:@"background"]];
            cell.name_lab.text = model.adTitle;
            cell.sub_lab.text = model.adText;
        }
        return cell;
        
    }
    
    userTestTableViewCell * cell = nil;
    if (!cell) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"userTestTableViewCell" owner:self options:nil];
        cell = [arr objectAtIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            if (indexPath.row < 1) {
                tableView.rowHeight = __text_table_cell1_h;
            }else{
                tableView.rowHeight = 10;
            }
        }else if (indexPath.section == 1){
            if (indexPath.row < 2) {
                tableView.rowHeight = __text_table_cell2_h;
            }else{
                tableView.rowHeight = 10;
            }            //            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }else{
            tableView.rowHeight = __table_cell3_h;
            cell._left_img.layer.cornerRadius = 6;
            cell._left_img.clipsToBounds = YES;
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row < 1) {
                cell._left_valuelab.textColor = test_color_1;
                cell._midel_valuelab.textColor = test_color_1;
                cell._right_valuelab.textColor = test_color_1;
                cell._left_valuelab.text = [NSString stringWithFormat:@"%ldSteps",(long)_jgBlutoothManager.userBodySyncModel.steps];
                cell._midel_valuelab.text = [NSString stringWithFormat:@"%ldKm",(long)_jgBlutoothManager.userBodySyncModel.licheng];
                cell._right_valuelab.text = [NSString stringWithFormat:@"%ldKcal",(long)_jgBlutoothManager.userBodySyncModel.kaluoli];
                
            }else{
                cell._left_linelab.hidden = YES;
                cell._reight_linelab.hidden = YES;
                cell._left_downlab.hidden = YES;
                cell._right_downlab.hidden = YES;
                cell._midel_downlab.hidden = YES;
                cell._left_valuelab.hidden = YES;
                cell._midel_valuelab.hidden = YES;
                cell._right_valuelab.hidden = YES;
                cell._left1_img.hidden = YES;
                cell._midel1_img.hidden = YES;
                cell._reight1_img.hidden = YES;
                cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            }
        }else if (indexPath.section == 1){
//            cell._left_view.witch = indexPath.row;
            if (indexPath.row < 2) {
                cell._left_Btn.tag = indexPath.row*2;
                [cell._left_Btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                cell._right_Btn.tag = indexPath.row*2+1;
                [cell._right_Btn addTarget:self action:@selector(cellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                JGHealthTaskManager *_JGHealthTaskManager = [JGHealthTaskManager shareInstances];
                
                if (indexPath.row == 0) {
                    

                    
                    NSInteger progressEye = 100 * (_JGHealthTaskManager.eyeCompletedCount*1.0 / _JGHealthTaskManager.eyesightMaintainceCompletedArr.count);
                     NSInteger progressHear = 100 * (_JGHealthTaskManager.hearingCompletedCount*1.0 / _JGHealthTaskManager.hearingMaintainceCompletedArr.count);
                    
                    [cell._left_view setPercent:progressEye witch:0 animated:YES];
                    [cell._right_view setPercent:progressHear witch:1 animated:YES];
                    
                    
                    
                    cell._left_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.eyeCompletedCount,(unsigned long)_JGHealthTaskManager.eyesightMaintainceCompletedArr.count];
                    cell._left_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressEye,@"%"];
                    
                    
                    cell._right_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.hearingCompletedCount,(unsigned long)_JGHealthTaskManager.hearingMaintainceCompletedArr.count];
                    cell._right_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressHear,@"%"];
                    
                    

                    
                    
                    cell._left_namelab.text = @"视力保健";
                    cell._right_namelab.text = @"听力保健";
                    cell._left2_Img.image = [UIImage imageNamed:@""];
                    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(22, 28, 25, 15)];
                    img.image = [UIImage imageNamed:@"eye"];
                    [cell._left_view addSubview:img];

                    cell._right2_Img.image = [UIImage imageNamed:@"ear"];
                }else if (indexPath.row == 1){
                    
                    
//                    [cell._left_view setPercent:30 witch:2 animated:YES];
//                    [cell._right_view setPercent:60 witch:3 animated:YES];
                    
                    
                    NSInteger progressBlooth = 100 * (_JGHealthTaskManager.bloodControlCompletedCount*1.0 / _JGHealthTaskManager.blooControlceCompletedArr.count);
                    NSInteger progressWeight = 100 * (_JGHealthTaskManager.weightControlCompletedCount*1.0 / _JGHealthTaskManager.weightControlCompletedArr.count);
                    
                    [cell._left_view setPercent:progressBlooth witch:2 animated:YES];
                    [cell._right_view setPercent:progressWeight witch:3 animated:YES];
                    
                    
                    
                    cell._left_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.bloodControlCompletedCount,(unsigned long)_JGHealthTaskManager.blooControlceCompletedArr.count];
                    cell._left_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressBlooth,@"%"];
                    
                    
                    cell._right_marklab.text = [NSString stringWithFormat:@"%ld/%ld",(long)_JGHealthTaskManager.weightControlCompletedCount,(unsigned long)_JGHealthTaskManager.weightControlCompletedArr.count];
                    cell._right_depictlab.text = [NSString stringWithFormat:@"已完成%ld%@",(long)progressWeight,@"%"];

                    
//                    
                    
                    
                    cell._left_namelab.text = @"血压控制";
                    cell._right_namelab.text = @"体重控制";
                    cell._left2_Img.image = [UIImage imageNamed:@"blood"];
                    cell._right2_Img.image = [UIImage imageNamed:@"Weight"];
                }
            }else{
                cell._left_namelab.hidden = YES;
                cell._left2_Img.hidden = YES;
                cell._left_marklab.hidden = YES;
                cell._left_depictlab.hidden = YES;
                cell._left_Btn.hidden = YES;
                cell._left_view.hidden = YES;
                cell._right_namelab.hidden = YES;
                cell._right2_Img.hidden = YES;
                cell._right_marklab.hidden = YES;
                cell._right_depictlab.hidden = YES;
                cell._right_Btn.hidden = YES;
                cell._right_view.hidden = YES;
                cell._line_lab.hidden = YES;
                cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
                
                
            }
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 2) {
        NSLog(@"点击第二部分");
        PositionAdvertBO *model = (PositionAdvertBO *)dataArr[indexPath.row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:model.adImgPath forKey:@"adImgPath"];
        [dic setObject:model.adType forKey:@"adType"];
        [dic setObject:model.adUrl forKey:@"adUrl"];
        [dic setObject:model.adTitle forKey:@"adTitle"];
        [dic setObject:model.adText forKey:@"adText"];
        [dic setObject:model.itemId forKey:@"itemId"];
        [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"adTitle"] forKey:@"circleTitle"];
        WebDayVC *weh = [[WebDayVC alloc]init];
    
        NSString *url = [NSString stringWithFormat:@"%@%@",Base_URL,[dic objectForKey:@"adUrl"]];
        NSLog(@"%@",url);
        weh.strUrl = url;
        weh.ind = 1;
        int type = [[dic objectForKey:@"adType"] intValue];
        if (type == 1) {
            weh.dic = dic;
        }
        UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:weh];
        nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
        [self presentViewController:nas animated:YES completion:nil];
        
        RELEASE(weh);
        RELEASE(nas);
        
    }else if (indexPath.section == 0){//健康监测页
        //未登录处理
        UNLOGIN_HANDLE
        [self _clickHealthTest];
    }
}

#pragma mark - 点击健康监测部分
-(void)_clickHealthTest{

    if (![kUserDefaults objectForKey:@"height"]) {//如果没有身高等相关，推到完善资料页
        
        CompletePersoninfoVC *personInfoVC = [[CompletePersoninfoVC alloc] init];
        personInfoVC.comminTypeInfo = Show_huan_Commin;
        
//        [Util preSentVCWithRootVC:personInfoVC withPrensentVC:self];
        [self.navigationController pushViewController:personInfoVC animated:YES];
        
    }else{//手环绑定页
        [userDefaultManager SetLocalDataString:@"58" key:@"innerRadius"];
        [userDefaultManager SetLocalDataString:@"78" key:@"outerRadius"];
        
//        if (_jgBlutoothManager.bangedPerialUUID) {//如果已经绑定手环，则进入，手环页
            devicesViewController *deviceVC = [[devicesViewController alloc] init];
            deviceVC.commInFromTest = YES;
            [Util asRootOfVC:deviceVC];
//        }else{//否则进入搜索设备页
//            mydevieseViewController *bangdingVC = [[mydevieseViewController alloc] init];
//            bangdingVC.isComminFromSelfVC = YES;
//            [Util asRootOfVC:bangdingVC];
//            
//        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float  height = 0;
    switch (indexPath.section) {
        case 0:
        {
//            if (indexPath.row < 1) {
//                height = __text_table_cell1_h;
//            }else{
//                height = 10;
//            }
            height = 0;
        }
            break;
        case 1:
        {
//            if (indexPath.row < 2) {
//                height = __text_table_cell2_h;
//            }else{
//                height = 10;
//            }
            height = 0;
        }
            break;
        case 2:
        {
            height = __table_cell3_h;
        }
            break;
            
        default:
            break;
    }
    return height;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * name_array = [NSArray arrayWithObjects:@"健康检测",@"健康任务",@"每日精华", nil];
    mainPublicTableViewHeader *headerView = [[NSBundle mainBundle] loadNibNamed:@"mainPublicTableViewHeader" owner:self options:nil][0];
    headerView.statusImageView.hidden = YES;
    headerView.statusLabel.hidden = YES;
    headerView.titleImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"test_section%ld",(long)(section + 1)]];
    headerView.titleNameLabel.text = name_array[section];
    if (section == 0) {
        headerView.titleNameLabel.textColor = test_color_1;
        headerView.rightBtn.hidden = NO;
        WEAK_SELF;
        [headerView.rightBtn addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            UNLOGIN_HANDLE
            [weak_self _clickHealthTest];
        }];
    }else if (section == 1){
        headerView.titleNameLabel.textColor = [UIColor redColor];
        headerView.rightBtn.hidden = YES;
    }else{
        headerView.titleNameLabel.textColor = color_section_3;
        headerView.rightBtn.hidden = NO;
        [headerView.rightBtn addActionHandler:^(NSInteger tag) {
            CustomTabBar * customTabBar = [CustomTabBar instance];
            [customTabBar setSelectedTab:4];
        }];
    }
    return headerView;
}


-(void)preSentVCWithRootVC:(UIViewController *)vc{

    UINavigationController *modalNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:modalNav animated:YES completion:nil];

}//弹出导航模态




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0||section == 1){
        return 0;
    }
    return __table_section_h;
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



#pragma mark - Action & Event
- (void)rightBtnClick:(UIButton *)btn
{
    NSLog(@"tag----> %ld",(long)btn.tag);
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

#pragma mark - 健康任务 点击
- (void)cellBtnClick:(UIButton*)btn
{
    someTestViewController * someTestVc = [[someTestViewController alloc]init];
    someTestVc.bigTaskNum = btn.tag;
    // 添加友盟统计
    if (btn.tag == 0) {
        [MobClick event:kSightHealthMobClickKey];
        
        someTestVc.keyStr = @"视力保健";
        someTestVc.img_name = @"test_back_eye";
        someTestVc.img_name2 = @"test_icon_eye";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"眼保健操",@"闭眼移动",@"随机移动",@"左右移动",@"上下移动",@"圆圈聚焦",@"紧闭双眼",@"两个物体", nil];
    }else if (btn.tag == 1){
        [MobClick event:kListeningHealthMobClickKey];
        
        someTestVc.keyStr = @"听力保健";
        someTestVc.img_name = @"test_back_ear";
        someTestVc.img_name2 = @"test_icon_ear";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"捏耳廓",@"捏耳屏",@"松耳廓",@"拧耳朵",@"拉耳廓", nil];
    }else if (btn.tag == 2){
        [MobClick event:kBloodPressureControlMobClickKey];

        someTestVc.keyStr = @"血压控制";
        someTestVc.img_name = @"test_back_blood";
        someTestVc.img_name2 = @"test_icon_blood";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"降压操", nil];
    }else{
        [MobClick event:kWeightControlControlMobClickKey];
        
        someTestVc.keyStr = @"体重控制";
        someTestVc.img_name = @"test_back_weight";
        someTestVc.img_name2 = @"test_icon_weight";
        someTestVc.name_array = [NSMutableArray arrayWithObjects:@"快速减肥操",@"睡前减肥操", nil];
    }
    

    [self.navigationController pushViewController:someTestVc animated:YES];

}

#pragma mark - nav 左边点解
- (void)headBtnClick
{
#pragma mark - leftSM
    AppDelegate *appDelegate = kAppDelegate;
    if (!_headYorN) {
        //        [[WWSideslipViewController instance]doSomeThingtoLeft];
        [appDelegate.drawerController closeDrawerAnimated:YES completion:nil];
    }else{
        //        [[WWSideslipViewController instance]doSomeThingtoRight];
        [appDelegate.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
    _headYorN = !_headYorN ;

//    AppDelegate *appDelegate = kAppDelegate;
//    if (appDelegate.leftSlideViewController.closed) {
//        [appDelegate.leftSlideViewController openLeftView];
//    }else{
//        [appDelegate.leftSlideViewController closeLeftView];
//    }

}

#pragma mark - 头部刷新
- (void)addHeaderFresh{
    WEAK_SELF
    [_myScrollView addHeaderWithCallback:^{
        
        [weak_self _requestAdDataWithCode:Zice_shouye_code];
        [weak_self _requestAdDataWithCode:Zice_shouye_mei_ri_jinghua_code];
        
    }];
}

#pragma mark - 请求网络
-(void)_requestAdDataWithCode:(NSString *)addCode{
    
    
    NSString *token = [userDefaultManager GetLocalDataString:@"Token"];
    SnsRecommendListRequest *request = [[SnsRecommendListRequest alloc] init:token];
    request.api_posCode = addCode;
    [_vapManager snsRecommendList:request success:^(AFHTTPRequestOperation *operation, SnsRecommendListResponse *response) {
        
        if (response.errorCode.integerValue == 2) {
            [Util enterLoginPage];
            return;
        }

        if ([addCode isEqualToString:Zice_shouye_code]) {//如果是首页广告
//            headImgArr = [[self deallWithNetWorkData:response.advList] retain];
            headImgArr = [[PositionAdvertBO objectArrayWithKeyValuesArray:response.advList] mutableCopy];
            //重新计算头部contentSize
            [self calCulateHeadScrollSizeWithArr];
            //缓存头部广告
            [_cache setObject:response.advList forKey:Tuijianwei_ad_cache_selfTestID];
            
        }else{//若是每日精华
            
            [_myScrollView headerEndRefreshing];
            dataArr = [PositionAdvertBO objectArrayWithKeyValuesArray:response.advList] ;
            
            //刷新表，重新计算表，以及scrollView的高度
             [self calculateTableAndScrollHeightWithArr:dataArr];
//            [_myTableView reloadData];
            //缓存自测每日精华
            [_cache setObject:response.advList forKey:Tuijianwei_perdayessene_cache_selfTestID];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.localizedDescription);
    }];

}




#pragma mark - 处理头部scroll view
-(void)calCulateHeadScrollSizeWithArr {
    
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
    
    WebDayVC *web = [[WebDayVC alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:model.adUrl forKey:@"adUrl"];
    [dic setObject:model.adType forKey:@"adType"];
    [dic setObject:model.adTitle forKey:@"adTitle"];
    [dic setObject:model.adText forKey:@"adText"];
    [dic setObject:model.adImgPath forKey:@"adImgPath"];
    [dic setObject:model.itemId forKey:@"itemId"];
    web.strUrl = [NSString stringWithFormat:@"%@%@",Base_URL,[dic objectForKey:@"adUrl"]];
    int type = [[dic objectForKey:@"adType"] intValue];
    if (type == 1) {
        web.dic = dic;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"adTitle"] forKey:@"circleTitle"];
    UINavigationController *nas = [[UINavigationController alloc]initWithRootViewController:web];
    nas.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    [self presentViewController:nas animated:YES completion:nil];
    
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



#pragma mark - 重新计算表以及scrollView的高度
-(void)calculateTableAndScrollHeightWithArr:(NSArray *)tableArray{
   
    
    //新表的高度
    CGFloat newTableHeight = Table_Not_Change_Height + tableArray.count *__table_cell3_h;
    _myTableView.height = newTableHeight;
    [_myTableView reloadData];
    _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, CGRectGetMaxY(_myTableView.frame));
}



-(void)_freswNesCellForbidden{
    
    NSMutableArray *cellArr = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<dataArr.count; i++) {
        NSIndexPath *indextPath = [NSIndexPath indexPathForItem:i inSection:2];
        userTestTableViewCell*cell = (userTestTableViewCell *)[_myTableView cellForRowAtIndexPath:indextPath];
        [cellArr addObject:cell];
    }
    
    for (int i=0; i<cellArr.count; i++) {
        userTestTableViewCell *cell = (userTestTableViewCell *)cellArr[i];
        PositionAdvertBO *model = (PositionAdvertBO *)adArr[i];
        [cell._left_img sd_setImageWithURL:[NSURL URLWithString:model.adImgPath]    placeholderImage:nil];
        cell._name_lab.text = model.adTitle;
        cell._desc_lab.text = model.adText;
    }
    
    
}//强制拿cell进行刷新

#pragma mark --------------------- 初始化基类视图，数据信息  ---------------------
-(void)_initBaseVCInfo {
    
    [self initBaseVCInfo];
//    //基类最大的滑动视图
//    [self initMyScrollView];
//    
//    //头部滑动视图
//    [self initHeadScrollView];
    
    [self _setCirlcleData];
    
}


#pragma mark ----------------------- 八大分类 -----------------------
#pragma mark - 配置八大分类数据源
-(void)_setCirlcleData {
      NSArray *selfTestCircleItems = @[@{@"gcName":@"体检",@"mobileIcon":@"test_1"},
                                    @{@"gcName":@"皮肤",@"mobileIcon":@"test_2"},
                                    @{@"gcName":@"面部",@"mobileIcon":@"test_3"},
                                    @{@"gcName":@"形体",@"mobileIcon":@"test_4"},
                                    @{@"gcName":@"专家咨询",@"mobileIcon":@"test_5"},
                                    @{@"gcName":@"症状",@"mobileIcon":@"test_6"},
                                    @{@"gcName":@"综合征",@"mobileIcon":@"test_7"},
                                    @{@"gcName":@"疾病",@"mobileIcon":@"test_8"}];
    
    self.middleDataArr = selfTestCircleItems;
    
}


#pragma mark - 点击八大分类点击事件
-(void)clickCircleAtIndex:(NSInteger)circleIndex {
    
    //圈子号
    switch (circleIndex) {
        case 0://体检
        {
            UNLOGIN_HANDLE
            DefuController *defuVC = [[DefuController alloc] init];
            [self.navigationController pushViewController:defuVC animated:YES];
        }
            break;
        case 1://皮肤
        case 6://综合征
        case 7://疾病
            //进入zonghezheng
            [self _cominToZongHeZhengVCWithNumber:circleIndex];
            break;
        case 2://面部
        case 3://形体
        case 5://症状
            [self _cominToZhengZhuangVCWithNumber:circleIndex];
            break;
        case 4://专家咨询
        {
            UNLOGIN_HANDLE
            consultationViewController * consultationVc = [[consultationViewController alloc]init];
            [self.navigationController pushViewController:consultationVc animated:YES];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - 进入皮肤、形体、症状
-(void)_cominToZhengZhuangVCWithNumber:(NSInteger)number{
    ZhengZhuangVC *zhengZhuangVC = [[ZhengZhuangVC alloc] init];
    switch (number) {
        case 2://面部
            zhengZhuangVC.zz_ModelType = Face_Model_type;
            break;
        case 3://形体
            zhengZhuangVC.listType = FigureType;
            zhengZhuangVC.zz_ModelType = Figure_Model_type;
            break;
        case 5://症状
            zhengZhuangVC.listType = ZhengZhuangType;
            zhengZhuangVC.zz_ModelType = Body_Model_Type;
            break;
        default:
            break;
    }
//    zhengZhuangVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zhengZhuangVC animated:YES];
}


#pragma mark - 进入皮肤、综合征、疾病
-(void)_cominToZongHeZhengVCWithNumber:(NSInteger)number{
    ZongHeZhengVC *zongheZhenVC =  [[ZongHeZhengVC alloc] init];
    switch (number) {
        case 1://皮肤
            zongheZhenVC.selfTestTiID = @4000;
            zongheZhenVC.comminType = Commin_From_Skin;
            break;
        case 6://综合征
            zongheZhenVC.selfTestTiID = @51;
            zongheZhenVC.comminType = commin_From_Zong_He_Zheng;
            break;
        case 7://疾病
            zongheZhenVC.selfTestTiID = @52;
            zongheZhenVC.comminType = Commin_From_JiBing;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:zongheZhenVC animated:YES];
}

#pragma mark - getter 

- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _tableView_height = _midleView.frame.origin.y+_midleView.frame.size.height+10;
        _myTableView = [[UITableView alloc]init];
        
        _myTableView.frame = CGRectMake(0, _tableView_height, __MainScreen_Width, __text_table_cell1_h*1+__text_table_cell2_h*2+__table_cell3_h*2+__table_section_h*3+20);
        _myTableView.scrollEnabled = NO;
        [_myTableView registerNib:[UINib nibWithNibName:@"mainPublicTableViewCell" bundle:nil] forCellReuseIdentifier:userTableViewCell];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


@end

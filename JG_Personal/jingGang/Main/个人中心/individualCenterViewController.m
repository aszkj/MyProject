//
//  individualCenterViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "individualCenterViewController.h"
#import "Header.h"
#import "individualTableViewCell.h"
#import "NewCenterVC.h" //wy
#import "BaseInfoVC.h"  //wy
#import "PersonalInfoViewController.h"
#import "myDecieseViewController.h"
#import "userDefaultManager.h"
#import "SettingVC.h"
#import "MyStore.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "OrderViewController.h"
#import "WSJMeEvaluateViewController.h"
#import "SalesReturnListVC.h"
#import "GlobeObject.h"
#import "WSJManagerAddressViewController.h"
#import "UnderLineOrderManagerViewController.h"
#import "OffLineOrderController.h"
#import "MyErWeiMaController.h"
#import "individualSignView.h"
#import "MJExtension.h"
#import "WIntegralListViewController.h"
#import "TakePhotoUpdateImg.h"
#import "JGIntegralValueController.h"
#import "PushNofiticationController.h"
#import "JGNearbyServiceController.h"
#import "JGHealthStoreController.h"
#import "AppDelegate+JGActivity.h"

@interface individualCenterViewController ()<JGIntegralValueControllerDelegate>{
    //个人界面上部分元素
    UILabel                /**_name_lab,*/*_icoin_lab,*_integral_lab;//姓名,云币，积分
    NSData                  *dataImage;
    NSMutableData           * mutWebData;
    
    //cell
    NSArray                *_cell_name_array;
    NSArray                *_left_img_array;
    VApiManager            *_VApManager;
    
}

@property (nonatomic, strong) individualSignView *signPrompt;//签到提示

@property (nonatomic) UIScrollView *myScrollview;
@property (nonatomic) UIView *topView;
@property (nonatomic) UIButton *signBtn;
@property (nonatomic) UIImageView *head_bg;
@property (nonatomic) UILabel *name_lab;
@property (nonatomic) UITableView *myTableView;
@property (nonatomic) TakePhotoUpdateImg *takePhotoUpdateImg;
/**
 *  用户积分
 */
@property (nonatomic,copy) NSString *strUsersIntegral;
/**
 *  用户云币
 */
@property (nonatomic,copy) NSString *strUsersYunMoney;

@end

@implementation individualCenterViewController

//#define view_bounds_height  __MainScreen_Height == 480 ?__MainScreen_Height/3+20 : __MainScreen_Height/3
//#define space_height  view_bounds_height/3

static individualCenterViewController *shopview = nil;

+ (individualCenterViewController *) instance {
    if (shopview == nil){
        NSLog(@"单利");
        shopview = [[individualCenterViewController alloc] init];
    }
    return shopview;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self getUserInfo];
    // 友盟统计
    [MobClick beginLogPageView:kPersonalCenterViewController];
    
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app queryUserDidCheck];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 友盟统计
    [MobClick endLogPageView:kPersonalCenterViewController];
    self.signPrompt.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.myScrollview];
    
    [self.myScrollview addSubview:self.topView];
    [self.topView addSubview:self.head_bg];
//    [self.topView addSubview:self.signBtn];
    [self.topView addSubview:self.name_lab];
    [self addUsrInfoView];
    [self.myScrollview addSubview:self.myTableView];
    
    
    
    [self getUserInfo];
}

#pragma mark - 签到事件
- (void)signAction:(UIButton *)btn
{
    if (!btn.selected)   //签到
    {
        // 友盟统计
        [MobClick event:kSignInEventMobClickKey];
        
        UsersSignLoginRequest *request = [[UsersSignLoginRequest alloc ] init: GetToken];
        request.api_type = @(1);
        WEAK_SELF
        [_VApManager usersSignLogin:request success:^(AFHTTPRequestOperation *operation, UsersSignLoginResponse *response) {
            UserSign *userSign = [UserSign objectWithKeyValues:response.userSign];
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
            
            weak_self.signPrompt.integral = [userSign.integral integerValue];
            weak_self.signPrompt.day = [userSign.day integerValue];
            weak_self.signPrompt.hidden = NO;
            weak_self.signPrompt.frame = weak_self.view.frame;
            _integral_lab.text = [NSString stringWithFormat:@"%ld",[_integral_lab.text integerValue] + weak_self.signPrompt.integral];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"sign  error---- %@",error);
        }];
        
    }
    else                //已签到
    {
//        self.signPrompt.signJifenLabel.text = @"今日已经签到过了";
    }
}




#pragma mark - 查询用户云币，
-(void)_requestUserYunBiIntergral{
    
    WEAK_SELF
    UsersIntegralRequest *request = [[UsersIntegralRequest alloc] init:GetToken];
    
    [_VApManager usersIntegral:request success:^(AFHTTPRequestOperation *operation, UsersIntegralResponse *response) {
        
        //云币
        if (response.availableBalance.doubleValue >= 0) {
          UILabel *yunBiLabel = (UILabel *)[_topView viewWithTag:10];
            yunBiLabel.text = [NSString stringWithFormat:@"%.2f",response.availableBalance.doubleValue];
            weak_self.strUsersYunMoney = yunBiLabel.text;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

#pragma mark - 用户积分请求
-(void)_requestUserIntergral{
    
    WEAK_SELF
    UsersIntegralGetRequest *request = [[UsersIntegralGetRequest alloc] init:GetToken];
    [_VApManager usersIntegralGet:request success:^(AFHTTPRequestOperation *operation, UsersIntegralGetResponse *response) {
        NSDictionary *integralDic = (NSDictionary *)response.integral;
        if (integralDic) {
            UILabel *interGraLabel = (UILabel *)[_topView viewWithTag:11];
            long long integral = [integralDic[@"integral"] longLongValue];
            interGraLabel.text = [NSString stringWithFormat:@"%lld",integral];
            weak_self.strUsersIntegral = interGraLabel.text;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    
}

#pragma mark - tabviewDelagete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cell_name_array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellStr = @"cellStr";
    individualTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    if (!cell) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"individualTableViewCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
    }
    
    if (indexPath.row == 0) {
//        cell.labelAwokeCount.hidden = NO;
    }
    
    tableView.rowHeight = 46;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.leftImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_left_img_array objectAtIndex:indexPath.row]]];
    cell.midelLab.text = [_cell_name_array objectAtIndex:indexPath.row];
    UILabel*l_bg =[[UILabel alloc]initWithFrame:CGRectMake(50.0f, 45.0f, 280.0f, 0.5f)];
    l_bg.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:0.6];
    [cell.contentView addSubview:l_bg];

    return cell;
}


#pragma mark ----JGIntegralValueControllerDelegate
- (void)nofiticationCloudMoneyValueChange:(NSString *)cloudMoneyChangeStr
{
    UILabel *yunBiLabel = (UILabel *)[_topView viewWithTag:10];
    yunBiLabel.text = cloudMoneyChangeStr;

}

//获取用户信息
-(void)getUserInfo
{
    
    if (IsEmpty(GetToken)) {
        return;
    }
    _VApManager = [[VApiManager alloc]init];
    if (IsEmpty(GetToken)) {
        return;
    }
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    UsersCustomerSearchRequest * usersCustomerSearchRequest = [[UsersCustomerSearchRequest alloc]init:accessToken];
    
    [_VApManager usersCustomerSearch:usersCustomerSearchRequest success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
//        JGLog(@"查询用户信息成功sssss");
        
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        
//        JGLog(@"查询用户信息成功%@",dict);
        
      NSDictionary   *arr_list = [dict objectForKey:@"customer"];
        _name_lab.text = [arr_list objectForKey:@"nickName"];
        
        [_head_bg sd_setImageWithURL:[arr_list objectForKey:@"headImgPath"] placeholderImage:[UIImage imageNamed:@"头像"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserHeadImgChangedNotification" object:[arr_list objectForKey:@"headImgPath"]];
        
        [[NSUserDefaults standardUserDefaults]setObject:arr_list forKey:@"arr_list"];
        [[NSUserDefaults standardUserDefaults] synchronize];
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        JGLog(@"查询用户信息sssss%@",error);
    }];
    
    //查询用户云币，
    [self _requestUserYunBiIntergral];
    
    //查询用户积分
    [self _requestUserIntergral];
    
    //签到数据请求
    [self _requestUserSign];
}

#pragma mark - 签到数据请求
- (void)_requestUserSign
{
    UsersSignLoginRequest *request = [[UsersSignLoginRequest alloc ] init: GetToken];
    request.api_type = @(2);
    [_VApManager usersSignLogin:request success:^(AFHTTPRequestOperation *operation, UsersSignLoginResponse *response) {
//        NSLog(@"sign success ---- %@",response);
        UserSign *userSign = [UserSign objectWithKeyValues:response.userSign];
        _signBtn.selected = [userSign.isSign boolValue];
        _signBtn.userInteractionEnabled = ![userSign.isSign boolValue];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"sign  error---- %@",error);
    }];
}

//头像点击操作
- (void)imageAction
{
    //访问摄像头，添加照片
    [self.takePhotoUpdateImg showInVC:self getPhoto:^(UIImagePickerController *picker, UIImage *image, NSDictionary *editingDic) {
        _head_bg.image = image;

    } upDateImg:^(NSString *updateImgUrl, NSError *updateImgError) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kUserHeadImgChangedNotification" object:updateImgUrl];
        
        [self _uploadUserHeaderImgUrl:updateImgUrl];
    }];
}

#pragma mark - 上传头像给服务器
-(void)_uploadUserHeaderImgUrl:(NSString *)userHeaderUrl {
    
    UsersCustomerUpdateImgRequest *request = [[UsersCustomerUpdateImgRequest alloc] init:GetToken];
    request.api_headImgPath = userHeaderUrl;
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    hub.labelText = @"正在上传用户头像。。";
    
    [_VApManager usersCustomerUpdateImg:request success:^(AFHTTPRequestOperation *operation, UsersCustomerUpdateImgResponse *response) {
        
        hub.labelText = @"上传头像成功";
        [hub hide:YES afterDelay:1.0f];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        hub.labelText = @"上传头像失败";
        [hub hide:YES afterDelay:1.0f];
        
    }];
}


#pragma mark - 用户信息查询
-(void)_userInfoQuery{

    UsersCustomerSearchRequest *request = [[UsersCustomerSearchRequest alloc] init:GetToken];
    
    [_VApManager usersCustomerSearch:request success:^(AFHTTPRequestOperation *operation, UsersCustomerSearchResponse *response) {
        
        NSLog(@"usr info ------  %@",response);
        
        [kUserDefaults setObject:response.customer forKey:userInfoKey];
        [kUserDefaults synchronize];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUsrInfoView
{
    _icoin_lab = [[UILabel alloc]init];
    _integral_lab = [[UILabel alloc]init];
    
    
    
    NSArray * lab_array = [NSArray arrayWithObjects:_icoin_lab,_integral_lab, nil] ;
    
    CGFloat infoHeight = 65;
    NSArray * top_down_lab2Name = [NSArray arrayWithObjects:@"我的云币",@"我的积分", nil] ;
    NSArray *top_down_labName = [NSArray arrayWithObjects:@"0.00",@"0", nil] ;
    NSArray * top_down_imgName = [NSArray arrayWithObjects:@"per_money",@"per_integral", nil] ;
    
    //    UIImageView * bg_img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"per_back_fillet"]];
    UIImageView * bg_img = [[UIImageView alloc]init];
    bg_img.backgroundColor = kGetColor(90, 196, 241);
    bg_img.frame = CGRectMake(0, CGRectGetMaxY(_name_lab.frame), (__MainScreen_Width) / 2, infoHeight);
    [_topView addSubview:bg_img];
    
    //    UIImageView * bg_img2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"per_back_fillet"]];
    UIImageView * bg_img2 = [[UIImageView alloc]init];
    bg_img2.backgroundColor = kGetColor(90, 196, 241);
    bg_img2.frame = CGRectMake(CGRectGetMaxX(bg_img.frame), CGRectGetMaxY(_name_lab.frame), (__MainScreen_Width) / 2, infoHeight);
    [_topView addSubview:bg_img2];
    
    for (int i = 0; i < 2; i++) {
        
        //所有控件放在此视图中
        UIButton *v = [[UIButton alloc] init];
        v.frame = CGRectMake(15 + (__MainScreen_Width - 70) / 2 *i, CGRectGetMaxY(_name_lab.frame), (__MainScreen_Width - 110) / 2, infoHeight);
        v.backgroundColor = [UIColor clearColor];
        v.tag = 10190 + i;
        [v addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:v];
        
        UILabel * top_down_lab = [lab_array objectAtIndex:i];
        top_down_lab.frame = CGRectMake(20, 10, CGRectGetWidth(v.frame)-20, CGRectGetHeight(v.frame)/3);
        top_down_lab.text = [top_down_labName objectAtIndex:i];
        if (i == 0) {
            top_down_lab.tag = 10 + i;
        }
        top_down_lab.textColor = [UIColor whiteColor];
        top_down_lab.font = [UIFont systemFontOfSize:16];
        top_down_lab.textAlignment = NSTextAlignmentCenter;
        [v addSubview:top_down_lab];
        
        UILabel * top_down_lab2 = [[UILabel alloc]init];
        if (i == 1) {
            top_down_lab.tag = 10 + i;
        }
        top_down_lab2.frame = CGRectMake(30, CGRectGetMaxY(top_down_lab.frame)+5, CGRectGetWidth(v.frame)-20, CGRectGetHeight(v.frame)/3);;
        top_down_lab2.text = [top_down_lab2Name objectAtIndex:i];
        top_down_lab2.textColor = [UIColor whiteColor];
        top_down_lab2.font = [UIFont systemFontOfSize:15];
        top_down_lab2.textAlignment = NSTextAlignmentCenter;
        [v addSubview:top_down_lab2];
        
        CGFloat imgViewX;
        if (iPhone5 || iPhone4) {
            imgViewX = CGRectGetMaxX(top_down_lab2.frame) - top_down_lab2.frame.size.width - 13;
        }else if (iPhone6){
            imgViewX = CGRectGetMaxX(top_down_lab2.frame) - top_down_lab2.frame.size.width - 7;
        }else if (iPhone6p){
            imgViewX = CGRectGetMaxX(top_down_lab2.frame) - top_down_lab2.frame.size.width + 5;
        }
        
        
        UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, CGRectGetMaxY(top_down_lab.frame), 30, 30)];

        imgView.image = [UIImage imageNamed:[top_down_imgName objectAtIndex:i]];
        [v addSubview:imgView];
    }
    

}

#pragma mark   进入我的积分、云币 ------
/**
 *  进入我的积分、云币
 *
 */
- (void)topButtonClick:(UIButton *)btn {
    AppDelegate *appDelegate = kAppDelegate;
    //标志从个人中心进入的
    appDelegate.isPersonCenterTtravel = YES;

    JGIntegralValueController *valueController;
    if (btn.tag == 10190) {
        valueController = [[JGIntegralValueController alloc] initWithControllerType:CloudValueControllerType];
        valueController.strCloudVelues = self.strUsersYunMoney;
        valueController.delegate = self;
    }else {
        valueController = [[JGIntegralValueController alloc] initWithControllerType:IntegralControllerType];
        valueController.strCloudVelues = self.strUsersIntegral;
    }
    
    UINavigationController *nav;
    if (self.parentViewController.navigationController == nil) {
        nav = [[UINavigationController alloc] initWithRootViewController:valueController];
        nav.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
        [self.parentViewController presentViewController:nav animated:YES completion:^{
        }];
    } else {
        nav = self.parentViewController.navigationController;
        [nav pushViewController:valueController animated:YES];
    }
}

#pragma mark - getter

- (TakePhotoUpdateImg *)takePhotoUpdateImg {
    if (_takePhotoUpdateImg == nil) {
        _takePhotoUpdateImg = [[TakePhotoUpdateImg alloc] init];
    }
    return _takePhotoUpdateImg;
}

- (individualSignView *)signPrompt
{
    if (_signPrompt == nil) {
        _signPrompt = [[NSBundle mainBundle] loadNibNamed:@"individualSignView" owner:self options:nil][0];
        _signPrompt.frame = self.view.frame;
        [self.view addSubview:_signPrompt];
    }
    return  _signPrompt;
}

- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc]init];
        _myTableView.rowHeight = 44;
        CGFloat tableViewY = CGRectGetMaxY(_name_lab.frame) + 65 + 3;
        _myTableView.frame = CGRectMake(0, tableViewY, __MainScreen_Width-50, __MainScreen_Height - tableViewY-3);
        _myTableView.backgroundColor = [UIColor clearColor];
//        _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _myTableView.separatorColor = kGetColor(215, 215, 215);
        _myTableView.scrollEnabled = YES;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
//        _cell_name_array = [NSArray arrayWithObjects:@"消息中心",@"我的问答",@"邀请好友",@"基本资料",@"我的健康档案",@"我的健康设备",@"我的收藏",@"我的发帖",@"我的地址",@"商品订单",@"线上服务订单",@"线下服务订单",@"我的积分兑换",@"我的退货",@"我的评价",@"设置",nil];
//        _left_img_array = [NSArray arrayWithObjects:@"per_news",@"per_ask",@"addfriend-2",@"per_data",@"per_archive",@"per_bracelet",@"per_love",@"per_post",@"per_adress",@"per_document",@"per_order",@"per_document",@"per_document",@"my_return_list",@"my_order_list",@"per_set", nil] ;
        _cell_name_array = [NSArray arrayWithObjects:@"消息中心",@"邀请好友",@"健康档案",@"健康设备",@"健康咨询",@"健康商城",@"周边服务",@"健康圈",@"我的收藏",@"设置",nil];
//        _left_img_array = [NSArray arrayWithObjects:@"per_news",@"addfriend-2",@"per_archive",@"per_bracelet",@"per_ask",@"per_document",@"per_order",@"per_post",@"per_love",@"per_set", nil] ;
        _left_img_array = [NSArray arrayWithObjects:@"消息",@"邀请好友",@"健康档案",@"健康设备",@"健康咨询",@"健康商城",@"周边服务",@"健康圈",@"我的收藏",@"设置", nil];
    }
    return _myTableView;
}
#pragma mark -----didselect ---wy
//tableView  didSelectEvent
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = kAppDelegate;
    //标志从个人中心进入的
    appDelegate.isPersonCenterTtravel = YES;
    UIViewController *VC;
    if (indexPath.row == 0) {//消息中心
        NewCenterVC *newVc = [[NewCenterVC alloc]init];
        newVc.index = 0;
        VC = newVc;
    }else if (indexPath.row == 1){//邀请好友
        MyErWeiMaController *invitationVC = [[MyErWeiMaController alloc] init];
        VC = invitationVC;
    }else if (indexPath.row == 2){//健康档案
        NewCenterVC *newVc = [[NewCenterVC alloc]init];
        newVc.index = 4;
        VC = newVc;
    }else if (indexPath.row == 3){//健康设备
        myDecieseViewController *myde = [[myDecieseViewController alloc]init];
        myde.keyStr = @"individualVC";
        VC = myde;
    }else if (indexPath.row == 4){//健康咨询
        NewCenterVC *newVc = [[NewCenterVC alloc]init];
        newVc.index = 1;
        VC = newVc;
    }else if (indexPath.row == 5){//健康商城
        JGHealthStoreController *healthStoreVC = [[JGHealthStoreController alloc]init];
        VC = healthStoreVC;
    }else if (indexPath.row == 6){//周边服务
        JGNearbyServiceController *nearServiceVC = [[JGNearbyServiceController alloc]init];
        VC = nearServiceVC;
    }else if (indexPath.row == 7){//健康圈
        MyStore *my = [[MyStore alloc]init];
        my.cent = 9;
        VC = my;
    }else if (indexPath.row == 8){//我的收藏
        NewCenterVC *newVc = [[NewCenterVC alloc]init];
        newVc.index = 6;
        VC = newVc;
    }else if (indexPath.row == _cell_name_array.count - 1){//设置
        SettingVC *settingVc = [[SettingVC alloc]init];
        VC = settingVc;
    }
//    if (indexPath.row == 0 ||indexPath.row == 1 || indexPath.row == 6 ||indexPath.row == 4) { //newCenter
//        NewCenterVC *new = [[NewCenterVC alloc]init];
//        new.index = indexPath.row;
//        VC = new;
//        
//    }else if (indexPath.row == 2){
//        MyErWeiMaController *invitationVC = [[MyErWeiMaController alloc] init];
//        VC = invitationVC;
//    }else if (indexPath.row == 3) {
//        VC = [[BaseInfoVC alloc]init];
//        VC = [[PersonalInfoViewController alloc] init];
//        
//    } else if (indexPath.row == 5) {
//        myDecieseViewController *myde = [[myDecieseViewController alloc]init];
//        myde.keyStr = @"individualVC";
//        VC = myde;
//        
//    } else if (indexPath.row == _cell_name_array.count-1) {
//        VC = [[SettingVC alloc]initWithNibName:@"SettingVC" bundle:nil];
//        
//    } else if (indexPath.row == 7) {
//        MyStore *my = [[MyStore alloc]init];
//        my.cent = 9;
//        VC = my;
//    } else if ([_cell_name_array[indexPath.row] isEqualToString:@"商品订单"]) {
//        VC = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
//    } else if ([_cell_name_array[indexPath.row] isEqualToString:@"线上服务订单"]) {
//        VC = [[UnderLineOrderManagerViewController alloc] init];
//    } else if ([_cell_name_array[indexPath.row] isEqualToString:@"线下服务订单"]) {
//        OffLineOrderController *offLineOrderController = [[OffLineOrderController alloc] init];
//        offLineOrderController.orderType = PersonalOrderOffLineType;
//        VC = offLineOrderController;
//    }
//    else if ([_cell_name_array[indexPath.row] isEqualToString:@"我的退货"]) {
//        VC = [[SalesReturnListVC alloc] init];
//    } else if ([_cell_name_array[indexPath.row] isEqualToString:@"我的评价"]) {
//        VC = [[WSJMeEvaluateViewController alloc] initWithNibName:@"WSJMeEvaluateViewController" bundle:nil];
//    }else if ([_cell_name_array[indexPath.row] isEqualToString:@"我的地址"]) {
//        WSJManagerAddressViewController *address = [[WSJManagerAddressViewController alloc] init];
//        address.type = personalCenter;
//        VC = address;
//    }
//    else if ([_cell_name_array[indexPath.row] isEqualToString:@"我的积分兑换"])
//    {
//        VC = [[WIntegralListViewController alloc] initWithNibName:@"WIntegralListViewController" bundle:nil];
//    }
    UINavigationController *nav;
    if (self.parentViewController.navigationController == nil) {
        nav = [[UINavigationController alloc] initWithRootViewController:VC];
        nav.navigationBar.barTintColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
        [self.parentViewController presentViewController:nav animated:YES completion:^{
            
        }];
    } else {
        nav = self.parentViewController.navigationController;
        [nav pushViewController:VC animated:YES];
    }
    
}


- (UILabel *)name_lab {
    if (_name_lab == nil) {
        _name_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_head_bg.frame) + 5, __MainScreen_Width-50, 35)];
        _name_lab.backgroundColor = [UIColor clearColor];
        _name_lab.textColor = kGetColor(51, 51, 51);
        _name_lab.font = [UIFont systemFontOfSize:17];
        _name_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _name_lab;
}

- (UIImageView *)head_bg {
    if (_head_bg == nil) {
        float btnBounds = 65;

        _head_bg = [[UIImageView alloc] init];
        _head_bg.userInteractionEnabled = YES;
        NSDictionary *dic = [kUserDefaults objectForKey:userInfoKey];
        
        [_head_bg sd_setImageWithURL:[NSURL URLWithString:dic[@"headImgPath"]] placeholderImage:[UIImage imageNamed:@"头像"]];
        _head_bg.contentMode = UIViewContentModeScaleAspectFill;
        _head_bg.frame = CGRectMake(0, 0, btnBounds, btnBounds);
        _head_bg.center = CGPointMake(self.view.center.x-25, btnBounds);
        _head_bg.layer.cornerRadius = (btnBounds) / 2.0;
        _head_bg.clipsToBounds = YES;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction)];
        [_head_bg addGestureRecognizer:tap1];
    }
    return _head_bg;
}

- (UIButton *)signBtn {
    if (_signBtn == nil) {
        _signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _signBtn.frame = CGRectMake(0, 0, 70, 50);
        _signBtn.center = CGPointMake(30, _head_bg.center.y);
        [_signBtn setTitle:@"签到  " forState:UIControlStateNormal];
        _signBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_signBtn setTitle:@"已签到 " forState:UIControlStateSelected];
        [_signBtn addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];
        [_signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"Sign-box-0"] forState:UIControlStateNormal];
    }
    return _signBtn;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc]init];
        _topView.frame = CGRectMake(0, 0, __MainScreen_Width-50, __MainScreen_Height);
        _topView.backgroundColor = [UIColor whiteColor];
        UIImageView * bgImg = [[UIImageView alloc]initWithFrame:self.view.frame];
//        bgImg.image = [UIImage imageNamed:@"per_bg_daflut_640960"];

        [_topView addSubview:bgImg];
    }
    return _topView;
}

- (UIScrollView *)myScrollview {
    if (_myScrollview == nil) {
        _myScrollview = [[UIScrollView alloc]init];
        _myScrollview.frame = self.view.frame;
        
        _myScrollview.scrollEnabled = NO;
    }
    return _myScrollview;
}

@end

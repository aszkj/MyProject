//
//  BaseInfoVC.m
//  jingGang
//
//  Created by wangying on 15/5/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "BaseInfoVC.h"
#import "SetCount.h"
#import "UsersInfo.h"
#import "Header.h"
#import "WIntegralView.h"
#import "userDefaultManager.h"
#import "NSObject+ApiResponseErrFliter.h"
#import "Util.h"

@interface BaseInfoVC ()
{

    UILabel *li ;
    UIView *views;
    UIButton *btn ;
    NSInteger indexs;
    VApiManager *_VApManager;
    SetCount *set;
    UsersInfo *sets ;
    WIntegralView *setIntegral;
    NSInteger text;
    NSMutableArray *arr;
    NSString *newPassward;
    NSString *oldPassward;
    NSString *surePassward;
    NSInteger indes;
    
    BOOL _isSelectBirth;
    NSInteger indess;
 
}
@property (nonatomic, retain) NSMutableDictionary *arr_trf;
@property (nonatomic, retain) UINavigationController *navi;
@end

@implementation BaseInfoVC

#pragma mark ------viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.arr_trf = [NSMutableDictionary dictionary];
      self.view.backgroundColor = [UIColor whiteColor];

    self.arr_trf = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"arr_list"]];
    
    [[NSUserDefaults standardUserDefaults] setObject:[self.arr_trf objectForKey:@"birthdate"] forKey:@"birthdate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self creatUIBtn];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
 
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [button_na addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:button_na];

        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(0, __StatusScreen_Height, __MainScreen_Width, __NavScreen_Height)];
        l.text = @"个人资料";
        l.textColor = [UIColor whiteColor];
        l.font = [UIFont boldSystemFontOfSize:18];
    l.textAlignment = NSTextAlignmentCenter;
        [self.navigationController.view addSubview:l];

    UIButton *btn_tt = [[UIButton alloc]initWithFrame:CGRectMake(__MainScreen_Width - 60, __StatusScreen_Height, 40, 40)];
    [btn_tt setTitle:@"确认" forState:UIControlStateNormal];
    btn_tt.backgroundColor = [UIColor clearColor];
    [btn_tt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_tt addTarget:self action:@selector(btnclickBg) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:btn_tt];
    //创建好点背景返回btn
    [Util makeWellClickBGBtnAtNavBar:self.slideSegmentController.navigationController.navigationBar withBtnSize:80 onResponseMethodStr:@"leftClick" isLeftItem:YES inResponseObject:self];
    
    //创建好点背景确认btn
    [Util makeWellClickBGBtnAtNavBar:self.slideSegmentController.navigationController.navigationBar withBtnSize:50 onResponseMethodStr:@"btnclickBg" isLeftItem:NO inResponseObject:self];
    
    
}

-(void)dealloc
{
}



//修改请求
-(void)btnclickBg
{
    NSLog(@"cheshi ---- %ld",self.slideSegmentController.selectedIndex);
    if (self.slideSegmentController.selectedIndex == 1) {//user count
    [set endEditing:YES];
    oldPassward = [[NSUserDefaults standardUserDefaults]objectForKey:@"oldText"];
    newPassward = [[NSUserDefaults standardUserDefaults]objectForKey:@"newText"];
    surePassward = [[NSUserDefaults standardUserDefaults]objectForKey:@"sureText"];
    NSLog(@"old ------------%@",oldPassward);
    NSLog(@"login -----------%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"passWord"]);
   
    if (![surePassward isEqualToString:newPassward] || ![oldPassward isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"passWord"]]) {
        
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不正确，请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
       }
    
      else
       {
    
       
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersPasswordUpdateRequest *usersPasswordUpdate = [[UsersPasswordUpdateRequest alloc] init:accessToken];
    
    usersPasswordUpdate.api_newPassword = newPassward;
    usersPasswordUpdate.api_odlPassword = oldPassward;
        
    [_VApManager usersPasswordUpdate:usersPasswordUpdate success:^(AFHTTPRequestOperation *operation, UsersPasswordUpdateResponse *response) {
        NSLog(@"修改密码成功");
        
        
        [NSObject fliterResponse:response withBlock:^(int event, id responseObject) {
            if (event == 1) {
                UIAlertView *altr = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [altr show];
                
            }
        }];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    }
    
    }
    else if (self.slideSegmentController.selectedIndex == 0){
     [sets endEditing:YES];
    
//     [self valueatUserInfo];
        if ([self valueatUserInfo]) {
            
            [self _userInfoUpdate];
        }
        
        
    }
    else
    {
        [setIntegral certainAlter];
    }
}
#pragma mark - 验证用户信息输入合法性
-(BOOL)valueatUserInfo{
    
    
    
//    NSLog(@"email -- %@",sets.emailStr);
    if ([Util varifyValidOfStr:sets.emailStr]) {
        //验证邮箱合法性
        if (![Util isValidateEmail:sets.emailStr]) {
            [Util ShowAlertWithOnlyMessage:@"邮箱格式不正确，请重新输入"];
            return NO;
        }

    }else{
        [Util ShowAlertWithOnlyMessage:@"邮箱不能为空"];
        return NO;
    }
    
    if (![Util varifyValidOfStr:sets.nickName]) {
        [Util ShowAlertWithOnlyMessage:@"昵称不能为空"];
        return NO;
    }
    if (![Util varifyValidOfStr:sets.name]) {
        [Util ShowAlertWithOnlyMessage:@"名字不能为空"];
        return NO;
    }
    
    if ([Util varifyValidOfStr:sets.weightStr]) {//输入了体重
        //验证体重合法性
        float weight = [sets.weightStr floatValue];
        if (weight < 10 || weight > 500 ) {
            [Util ShowAlertWithOnlyMessage:@"体重填写不合理，确认并重新填写"];
            return NO;
        }
        
    }else{
        [Util ShowAlertWithOnlyMessage:@"请填写体重信息"];
        return NO;
    }
    
    
    if ([Util varifyValidOfStr:sets.heightStr]) {
        int height = [sets.heightStr floatValue];
        if (height < 100 || height > 999 ) {
            [Util ShowAlertWithOnlyMessage:@"身高填写不合理，确认并重新填写"];
            return NO;
        }

       
    }else{
        [Util ShowAlertWithOnlyMessage:@"请填写身高信息"];
        return NO;
    }
    
    if (![Util varifyValidOfStr:sets.birthDayStr]) {
        [Util ShowAlertWithOnlyMessage:@"请选择出生日期"];
        return NO;
    }
    

    return YES;

}




#pragma mark - 用户信息更新
-(void)_userInfoUpdate{

    //user info
    _VApManager = [[VApiManager alloc]init];
    NSString *accessToken = [userDefaultManager GetLocalDataString:@"Token"];
    
    UsersCustomerUpdateRequest *usersCustomerUpdateRequest = [[UsersCustomerUpdateRequest alloc] init:accessToken];
    
    usersCustomerUpdateRequest.api_email = [[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    
    usersCustomerUpdateRequest.api_allergHistory = [[NSUserDefaults standardUserDefaults]objectForKey:@"allergHistory"];
    
    usersCustomerUpdateRequest.api_birthDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"birthdate"];
    // usersCustomerUpdateRequest.api_headImgPath = @"44";
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"height"]) {
        usersCustomerUpdateRequest.api_height = [[NSUserDefaults standardUserDefaults]objectForKey:@"height"];
    }else
    {
        usersCustomerUpdateRequest.api_height = @(180);
    }
    
    
    usersCustomerUpdateRequest.api_mobile = [[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"name"]) {
        usersCustomerUpdateRequest.api_name = [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
    }else
    {
        usersCustomerUpdateRequest.api_name = @"匿名";
    }
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"nickname"]) {
        usersCustomerUpdateRequest.api_nickname = [[NSUserDefaults standardUserDefaults]objectForKey:@"nickname"];
    }else{
        
        usersCustomerUpdateRequest.api_nickname = @"匿名";
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"sex"]) {
        usersCustomerUpdateRequest.api_sex = [[NSUserDefaults standardUserDefaults]objectForKey:@"sex"];
    }
    else
    {
        usersCustomerUpdateRequest.api_sex = @(1);
    }
    
    usersCustomerUpdateRequest.api_blood = [[NSUserDefaults standardUserDefaults]objectForKey:@"blood"];
    
    usersCustomerUpdateRequest.api_transGenetic = [[NSUserDefaults standardUserDefaults]objectForKey:@"transGenetic"];
    
    usersCustomerUpdateRequest.api_transHistory = [[NSUserDefaults standardUserDefaults]objectForKey:@"transHistory"];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"weight"]) {
        usersCustomerUpdateRequest.api_weight = [[NSUserDefaults standardUserDefaults]objectForKey:@"weight"];
    }else
    {
        usersCustomerUpdateRequest.api_weight = @(90);
    }
    
    
    [_VApManager usersCustomerUpdate:usersCustomerUpdateRequest success:^(AFHTTPRequestOperation *operation, UsersCustomerUpdateResponse *response) {
        [NSObject fliterResponse:response withBlock:^(int event, id responseObject) {
            if (event == 1) {
                NSLog(@"修改用户信息成功");
                UIAlertView *altr = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户信息修改成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [altr show];
                
                NSLog(@"%@",response);
            }
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"修改用户信息失败%@",error);
    }];
}



-(void)creatUIBtn
{
    NSArray * top_btn_name = [NSArray arrayWithObjects:@"用户资料",@"修改密码", @"修改云币密码",nil];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        
            vc.title = [top_btn_name objectAtIndex:i];
        switch (i) {
            case 0:
            {
                indess = 0;
                sets = [[UsersInfo alloc]initWithFrame:CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- 10)];
                
                [sets creatUI];
                [vc.view addSubview:sets];
            }
                break;
            case 1:
            {
                indess = 1;
                set = [[SetCount alloc]initWithFrame:CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- 10)];
                
                [set creatUI];
                
                [vc.view addSubview:set];
            }
                break;
            case 2:
            {
                indess = 2;
                setIntegral = [[WIntegralView alloc] initWithFrame:CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- 10)];
                [vc.view addSubview:setIntegral];
            }
                break;
            default:
                break;
        }
        [vcs addObject:vc];

    }
    
    id jscv = [[JYSlideSegmentController alloc] initWithViewControllers:vcs];
    self.slideSegmentController = jscv;

    
    indes =  self.slideSegmentController.selectedIndex;
    
    self.slideSegmentController.indicatorInsets = UIEdgeInsetsMake(0, 80, 0, 80);
    
    self.slideSegmentController.indicator.backgroundColor = status_color;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.slideSegmentController];
    self.navi = nav;
    self.navi.view.frame = CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height);
    //navigation
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, -__StatusScreen_Height, __MainScreen_Width, __Other_Height)];
    topView.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    
    [self.slideSegmentController.navigationController.navigationBar addSubview:topView];
    
    [self.navigationController.view addSubview:self.navi.view];
}

-(void)leftClick
{
    [self.slideSegmentController.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

@end

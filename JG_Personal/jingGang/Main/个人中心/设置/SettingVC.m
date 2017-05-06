//
//  SettingVC.m
//  jingGang
//
//  Created by wangying on 15/6/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SettingVC.h"
#import "AboutYunEs.h"
#import "PublicInfo.h"
#import <PgySDK/PgyManager.h>
#import "WebDayVC.h"
#import "userDefaultManager.h"
#import "loginViewController.h"
#import "GlobeObject.h"
#import "AppDelegate.h"
#import "H5page_URL.h"
#import "MBProgressHUD.h"
#import "WWSideslipViewController.h"
#import "HelpController.h"
#import "FeelBackQuestionController.h"
#import "JGSettingCell.h"
#import "UserInfoViewController.h"
#import "ChangeLoginViewController.h"
#import "ChangYunbiPasswordViewController.h"
#import "JGClientServerController.h"
#import "JGBindOnAccountViewController.h"
@interface SettingVC ()<UIApplicationDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UserInfoViewControllerDelegate,ChangeLoginViewControllerDelegate,ChangYunbiPasswordViewControllerDelegate>{

    MBProgressHUD *_logOuthub;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewLogoTopHeight;
@property (nonatomic,strong) NSArray *arrayData;
@end

@implementation SettingVC


- (NSArray *)arrayData
{
    if (!_arrayData) {
        NSArray *arrayUserInfo = [NSArray arrayWithObjects:@"个人信息",@"登陆密码",@"云币密码" ,nil];
        NSArray *arrayAboutUs = [NSArray arrayWithObjects:@"关于云e生",@"客服中心",@"给我们打分", nil];
        NSArray *arrayChsh = [NSArray arrayWithObjects:@"清除缓存",@"账号绑定",nil];
        _arrayData = [NSArray arrayWithObjects:arrayUserInfo,arrayAboutUs,arrayChsh, nil];
    }
    return _arrayData;
}


- (void)viewWillAppear:(BOOL)animated
{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initUI];
    
    
}


- (void)initUI
{
    UIButton *button_na = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 35, __NavScreen_Height-15)];
    [button_na setImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    //增加好点的返回键
    [Util makeWellClickBGBtnAtNavBar:self.navigationController.navigationBar withBtnSize:60 onResponseMethodStr:@"btnClick" isLeftItem:YES inResponseObject:self];
    [button_na addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:button_na];
    self.navigationItem.leftBarButtonItem = bar;
    RELEASE(button_na);
    RELEASE(bar);
    //设置标题
    UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(__MainScreen_Width/2 - 30, __StatusScreen_Height, 60, 40)];
    l.text = @"设置";
    l.font = [UIFont systemFontOfSize:18];
    l.textColor = [UIColor whiteColor];
    l.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = l;
    RELEASE(l);
    //设置tableview
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [self loadFootView];
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    

}


#pragma mark ---UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.arrayData[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifile = @"JGSettingCell";
    
    JGSettingCell *cell = (JGSettingCell *)[tableView dequeueReusableCellWithIdentifier:identifile];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"JGSettingCell" owner:self options:nil];
        cell = [nib lastObject];
    }
    
    NSArray *array = self.arrayData[indexPath.section];
    
    cell.labelTitle.text = array[indexPath.row];
    return cell;
}


#pragma mark --- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *controller;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {//个人资料
            UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
            userInfoVC.delegate = self;
            controller = userInfoVC;
        }else if (indexPath.row == 1){//登陆密码/修改密码
            ChangeLoginViewController *changeLoginVC = [[ChangeLoginViewController alloc]init];
            changeLoginVC.delegate = self;
            controller = changeLoginVC;
        }else if (indexPath.row == 2){//修改云币密码
            ChangYunbiPasswordViewController *changYunbiPasswordVC = [[ChangYunbiPasswordViewController alloc]init];
            changYunbiPasswordVC.delegate = self;
            controller = changYunbiPasswordVC;
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0){//关于云e生
            AboutYunEs *about = [[AboutYunEs alloc]init];
            about.strUrl = AboutYunESheng;
            controller = about;
            RELEASE(about);
        }else if (indexPath.row == 1){//帮助中心
            JGClientServerController *clientServerVC = [[JGClientServerController alloc]init];
            controller = clientServerVC;
        }else if (indexPath.row ==2){//请给我们打分
            
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {//清除缓存
            
        }
        else if (indexPath.row == 1){
//            跳账号绑定页面
            JGBindOnAccountViewController *bindOnAccountVC = [[JGBindOnAccountViewController alloc] init];
            controller = bindOnAccountVC;
        }
    }
    
        [self.navigationController pushViewController:controller animated:YES];
    
    
}




- (UIView *)loadFootView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 12, kScreenWidth - 40, 50);
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0;
    button.backgroundColor = kGetColor(241, 169, 84);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    return view;

}
    



- (void)buttonClick
{
    UIAlertView *logOutAlert = [[UIAlertView alloc] initWithTitle:@"退出登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [logOutAlert show];
}

/**
 *  因为以下三个代理的页面返回的时候不知道为什么设置页面整体会下降需要代理通知设置回来
 */
#pragma mark ---UserInfoViewControllerDelegate
- (void)nofiticationPopUserInfoView
{
    self.imageViewLogoTopHeight.constant = 18;
}
#pragma mark ---ChangeLoginViewControllerDelegate
- (void)nofiticationPopChangeLoginView
{
    self.imageViewLogoTopHeight.constant = 18;
}
#pragma mark ---ChangYunbiPasswordViewControllerDelegate
- (void)nofiticationPopChangYunbiPasswordView
{
    self.imageViewLogoTopHeight.constant = 18;
}

-(void)btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)updataApp:(UIButton *)sender {
    
    [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
    
}

-(void)updateMethod:(NSDictionary *)banBenDic{

    if (banBenDic) {//有版本
      //版本处理
        
      //
      [[PgyManager sharedPgyManager] updateLocalBuildNumber];
    }else{
    
        UIAlertView *alter =[[UIAlertView alloc]initWithTitle:@"提示" message:@"你已经是最新版本了" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alter show];
    }
}



#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

//    NSLog(@"index %ld",buttonIndex);
    if (buttonIndex == 1) {//确定
        [self logOut];
        _logOuthub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self performSelector:@selector(beGinLogin) withObject:nil afterDelay:1.0f];
    }
}



-(void)logOut{
    // 友盟统计  停止sign-in PUID的统计
    [MobClick profileSignOff];
    
    [userDefaultManager removeLocalDataForKey:@"Token"];
    [kUserDefaults removeObjectForKey:@"Token"];
    [kUserDefaults synchronize];
}//退出

- (IBAction)gotoFeedback:(id)sender {
    FeelBackQuestionController *VC = [[FeelBackQuestionController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)beGinLogin{
    [_logOuthub hide:YES];
   
    AppDelegate *appDelegate = kAppDelegate;
    [appDelegate beGinLogin];
    [appDelegate.drawerController closeDrawerAnimated:YES completion:nil];
    //进入首页不开启drawer
    appDelegate.isPersonCenterTtravel = NO;
    

}



- (void)dealloc {

}
@end

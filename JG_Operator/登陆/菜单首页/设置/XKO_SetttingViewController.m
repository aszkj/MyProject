//
//  XKO_SetttingViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "XKO_SetttingViewController.h"
#import "AboutInfoViewController.h"
//#import "LoginViewController.h"
#import "KJLoginController.h"
#import "SetttingCell.h"
//#import "ChangePasswordViewController.h"
#import "NSString+BlankString.h"
#import "XKUpdatePasswdController.h"
#import "XKO_OperatorInvitationCodeResponseInfo.h"
#import "JGShareView.h"
#import "HelpController.h"
#import "FeelBackQuestionController.h"
#import "MyErWeiMaController.h"
#define AboutYunESheng @"http://static.jgyes.com/static/app/about.jsp"
#define      KOperatorInvitationCodeMethordName      @"OperatorInvitationCodeMethordName"

@interface XKO_SetttingViewController (){

    NSNumber    *_giveIntegral;
    VApiManager  *_vapManager;

}
@property (nonatomic, strong) JGShareView *shareV;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *pageData;
@property (strong, nonatomic) NSString *invitCode;

@end

@implementation XKO_SetttingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _vapManager = [[VApiManager alloc] init];
    
    //注册请求加加积分
    [self _registerMakeIntegralRequest];
    
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self.view addSubview:self.tableView];
    
    
    self.pageData = [[NSMutableArray alloc] initWithObjects:@"邀请好友",@"修改登录密码",@"修改提现密码",@"关于云e生",@"联系客服",@"帮助",@"问题反馈",@"版本号", nil];
    
    self.title = @"设置";
    
    _invitCode = @"";
    //获取邀请码
    [self requestOperatorInvitationCodeFromModel];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - kNavBarAndStatusBarHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.delaysContentTouches = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        _tableView.contentOffset = CGPointMake(0, 0);
        
        UIView *viewFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 84)];
        viewFootView.backgroundColor = [UIColor clearColor];
        [viewFootView addSubview:[self addLoginOutView]];
        _tableView.tableFooterView = viewFootView;
        _tableView.backgroundColor = background_Color;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - private methord

- (UIButton *)addLoginOutView
{
    UIButton *buttonSignOut = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSignOut.frame = CGRectMake(15, 20, kScreenWidth - 30, 44) ;
    buttonSignOut.backgroundColor = [UIColor redColor];
    buttonSignOut.layer.cornerRadius = kRadius;
    buttonSignOut.layer.masksToBounds = YES;
    [buttonSignOut setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [buttonSignOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSignOut addTarget:self action:@selector(noLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSignOut];
    
    return buttonSignOut;
}

- (void)noLogin:(UIButton *)sender {
    
    UIAlertView *logOutAlert = [[UIAlertView alloc] initWithTitle:@"退出登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [logOutAlert show];
    [self.view addSubview:logOutAlert];
}

-(void)logOut{
//    [userDefaultManager removeLocalDataForKey:@"Token"];
    [kUserDefaults removeObjectForKey:Token];
    [kUserDefaults synchronize];
}//退出

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {//确定
        [self logOut];
        
        [self performSelector:@selector(beGinLogin) withObject:nil afterDelay:1.0f];
    }
}

-(void)beGinLogin{
    KJLoginController * loginVc = [[KJLoginController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
    
    self.view.window.rootViewController = nav;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.pageData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 1;
    if (section == 0 || section == 3) {
        height = 10;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SettingCellIdentifier = @"SettingCellIdentifier";
    
//    if (indexPath.section == 0) {
//        SetttingCell *setttingCell = [[SetttingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//        setttingCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        setttingCell.title.text = @"邀请好友";
//        [setttingCell resetDataAndFrame:[NSString stringWithFormat:@"%@",_invitCode]];
//        [setttingCell.content setHidden:YES];
//
//        
//        
//        return setttingCell;
//    } else
    if (indexPath.section == 4) {
        SetttingCell *setttingCell = [[SetttingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        setttingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [setttingCell resetDataAndFrame:@"4008355788"];
        setttingCell.title.text = @"联系客服";
        [setttingCell.content setHidden:NO];
        [setttingCell.sharImg setImage:IMAGE(@"call")];
        
        return setttingCell;
    } else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        cell.textLabel.text = [self.pageData objectAtIndex:indexPath.section];
        
        
        
        if (indexPath.section == 0 ) {
            if (indexPath.row == 0) {
                
            }
        }
        if (indexPath.section == 7) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            // app版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

            cell.detailTextLabel.text = app_Version;
        } else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"";
        }
        if (indexPath.section == 5) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[[SetttingCell alloc] init] getHeightOfCell];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 分享
//        [self.shareV show];
        
        MyErWeiMaController *invitationVC = [[MyErWeiMaController alloc] init];
        [self.navigationController pushViewController:invitationVC animated:YES];
    }else if (indexPath.section == 1) {
        XKUpdatePasswdController *changePassword = [[XKUpdatePasswdController alloc] init];
        changePassword.updatePasswdType = UpdatePasswd;
        [self.navigationController pushViewController:changePassword animated:YES];
    } else if (indexPath.section == 2) {
        XKUpdatePasswdController *changePassword = [[XKUpdatePasswdController alloc] init];
        changePassword.updatePasswdType = UpdateRefundPasswd;
        [self.navigationController pushViewController:changePassword animated:YES];
    } else if (indexPath.section == 3) {
        AboutInfoViewController *aboutYunEs = [[AboutInfoViewController alloc] init];
        aboutYunEs.strUrl = AboutYunESheng;
        [self.navigationController pushViewController:aboutYunEs animated:YES];
    } else if (indexPath.section == 4) {
        // 联系客服
        //        if (![NSString isBlankString:@"4008355788"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", @"4008355788"]]];
        //        }
    }else if (indexPath.section == 5) {
        HelpController *helpController = [[HelpController alloc] init];
        helpController.loadUrl = AboutYunESheng;
        [self.navigationController pushViewController:helpController animated:YES];
    }else if (indexPath.section == 6){
        FeelBackQuestionController *feelBackQuestionController = [[FeelBackQuestionController alloc]init];
        [self.navigationController pushViewController:feelBackQuestionController animated:YES];
    }
}

/**
 *  营运商邀请码(从服务器读取数据)
 *
 *  @param requestModel 请求信息
 */
- (void)requestOperatorInvitationCodeFromModel {
    
    XKO_OperatorInvitationCodeRequestInfo *requestModel = [[XKO_OperatorInvitationCodeRequestInfo alloc] initWithMethordName:KOperatorInvitationCodeMethordName];
    
    [self.dataCenter requestOperatorInvitationCodeFromModel:requestModel];
}


#pragma mark - DataCenterDelegate

// 读取数据成功
- (void)loadingFinishedWithDataArray:(NSArray *)dataArray methordName:(NSString *)methordName {
    
    if ([methordName isEqualToString:KOperatorInvitationCodeMethordName]) {
        
        XKO_OperatorInvitationCodeResponseInfo * responseInfo = (XKO_OperatorInvitationCodeResponseInfo *)dataArray[0];
        
        _invitCode = responseInfo.invitationCode;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


#pragma mark - 注册加积分请求
- (void)_registerMakeIntegralRequest {
    
    SnsIntegralGetRequest *request = [[SnsIntegralGetRequest alloc] init:GetToken];
    request.api_type = @1;
    [_vapManager snsIntegralGet:request success:^(AFHTTPRequestOperation *operation, SnsIntegralGetResponse *response) {
        
        if ([response isMemberOfClass:[SnsIntegralGetResponse class]]) {
            
            _giveIntegral = response.integral;
            
        }else if ([response isMemberOfClass:[NSDictionary class]]){
            
            SnsIntegralGetResponse *integralResponse = [SnsIntegralGetResponse objectWithKeyValues:response];
            _giveIntegral = integralResponse.integral;
            
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}


#pragma mark - 分享内容
- (JGShareView *)shareV
{
    if (_shareV == nil)
    {
#pragma mark - 修改的
        _shareV = [JGShareView shareViewWithTitle:kInvitationShareTitle1(_giveIntegral) content:kInvitationShareDescription1(_giveIntegral) imgUrlStr:kLogShareUrl ulrStr:kInvitationCodeShareUrlCode(_invitCode) contentView:self.view shareImagePath:nil];
        _shareV.wxShareModel.shareContent = kInvitationShareDescription2(_giveIntegral);
        _shareV.wxFriendShareModle.shareTitle = kInvitationShareDescription1(_giveIntegral);
         _shareV.weiBoShareModel.shareContent = kWeiboShareContent(_invitCode, _giveIntegral);
    }
    return _shareV;
}

@end

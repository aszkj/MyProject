//
//  XKJHSettingController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHSettingController.h"
#import "AboutYunEs.h"
#import "KJLoginController.h"
#import "HelpController.h"
#import "FeelBackQuestionController.h"
#define AboutYunESheng @"http://static.jgyes.com/static/app/about.jsp"

@interface XKJHSettingController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *pageData;

@end

@implementation XKJHSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - kNavBarAndStatusBarHeight - 54);
    
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.delaysContentTouches = NO;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView setSeparatorInset:UIEdgeInsetsZero];
    _tableView.contentOffset = CGPointMake(0, 0);
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.backgroundColor = background_Color;
    [self.view addSubview:_tableView];
    
    [self addLoginOutView];
    self.pageData = [[NSMutableArray alloc] initWithObjects:@"关于云e生",@"联系客服",@"帮助",@"问题反馈",@"版本号", nil];
    self.title = @"设置";
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

- (void)addLoginOutView
{
    UIButton *signOut = [UIButton buttonWithType:UIButtonTypeCustom];
    signOut.backgroundColor = kGetColor(1, 84, 118);
    signOut.layer.cornerRadius = kRadius;
    signOut.layer.masksToBounds = YES;
    [signOut setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [signOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signOut addTarget:self action:@selector(noLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signOut];
    
    [signOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, 43));
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-54);
    }];
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

-(void)beGinLogin{
    
    KJLoginController * loginVc = [[KJLoginController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
    
    self.view.window.rootViewController = nav;
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {//确定
        [self logOut];

        [self performSelector:@selector(beGinLogin) withObject:nil afterDelay:1.0f];
    }
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
    CGFloat height = 4.9;
    if (section == 0) {
        height = 10;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SettingCellIdentifier = @"SettingCellIdentifier";
    if (indexPath.section < self.pageData.count) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        cell.textLabel.text = [self.pageData objectAtIndex:indexPath.section];
        
        if (indexPath.section == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        if (indexPath.section == 1) {
            
            cell.detailTextLabel.text = @"400-835-5788";
            
        } else if (indexPath.section == self.pageData.count-1) {
            
            // app版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            
            cell.detailTextLabel.text = app_Version;

        } else {
            cell.detailTextLabel.text = @"";
        }
        if (indexPath.section == 3 || indexPath.section == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.pageData.count) {
        return 44;
    } else {
        return 63;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AboutYunEs *aboutYunEs = [[AboutYunEs alloc] init];
        aboutYunEs.strUrl = AboutYunESheng;
        [self.navigationController pushViewController:aboutYunEs animated:YES];
    } else if (indexPath.section == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", @"4008355788"]]];

    }else if (indexPath.section == 2) {
        HelpController *helpController = [[HelpController alloc] init];
        helpController.loadUrl = AboutYunESheng;
        [self.navigationController pushViewController:helpController animated:YES];
        
    }else if (indexPath.section == 3){
        FeelBackQuestionController *feelBackQuestionVc = [[FeelBackQuestionController alloc]init];
        [self.navigationController pushViewController:feelBackQuestionVc animated:YES];

    }
}

@end

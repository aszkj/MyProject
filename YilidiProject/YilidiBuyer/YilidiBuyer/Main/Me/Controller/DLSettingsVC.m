//
//  DLSettingsVC.m
//  YilidiSeller
//
//  Created by User on 16/3/30.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLSettingsVC.h"
#import "DLSettingCell.h"
#import "DLAboutUsVC.h"
#import "NSString+Teshuzifu.h"
#import "DLLoginVC.h"
#import <Masonry/Masonry.h>
#import "DLEvaluationDetailsView.h"
#import "DLSetFooterView.h"
#import "DLPersonalrDataVC.h"
#import "DLAdressListVC.h"
#import "CordovaH5UrlManager.h"
#import "DLCordovaH5VC.h"
#import "GlobleConst.h"
#import "DLMainTabBarController.h"
#import "ProjectRelativeDefineNotification.h"
#import "AFNHttpRequestOPManager+setCookes.h"
#import "DLFeedbackVC.h"
#import "DLAccountSecurityVC.h"
@interface DLSettingsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextView *aboutUs;
@property (nonatomic,strong)DLEvaluationDetailsView *detailsView;
@property (nonatomic,strong)DLSetFooterView *footerView;
@end

@implementation DLSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"设置";
    
    [self _initLoadSetTableView];
   
}

#pragma mark ------------------------Init---------------------------------
- (void)_initLoadSetTableView{
    
    //设置表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =KViewBgColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DLSettingCell" bundle:nil] forCellReuseIdentifier:@"DLSettingCell"];
    
    [self.view addSubview:_tableView];
    
}

#pragma mark ------------------------Private-------------------------




#pragma mark ------------------------Api----------------------------------
- (void)_requestLogout {
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_Logout block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        [kNotification postNotificationName:KNofiticationLogout object:nil];
        [AFNHttpRequestOPManager clearSessionIdCookie];
        [[UserDataManager sharedManager] clearUserInfo];
        [self _enterLoginPage];
    }];
}
#pragma mark ------------------------Page Navigate---------------------------
- (void)_enterCordovaH5PageWithH5Code:(NSString *)h5Code {
    [[CordovaH5UrlManager sharedManager] getH5Url:^(NSString *h5Url) {
        DLCordovaH5VC *h5Page = [[DLCordovaH5VC alloc] init];
        h5Page.h5Url = h5Url;
        [self navigatePushViewController:h5Page animate:YES];
    } forh5Code:h5Code];
}


- (void)_enterLoginPage {
    
    DLMainTabBarController *main = [[DLMainTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = main;
}

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma -- mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 3;
    }else if (section == 1) {
        return 2;
    }else {
        return 3;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 49;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5.0f;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if(section == 2){
        return 109;
    }else {
         return 0.0000001f;
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if(section == 2){
        return self.footerView;
    }else {
        return nil;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DLSettingCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                 cell.leftTitle.text = @"个人资料";
                
                break;
                
            case 1:
                cell.leftTitle.text = @"账户安全";
 
                
                break;
            case 2:
                cell.leftTitle.text = @"收货地址管理";
                
                
            default:
                break;
        }

       
        
    }else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.leftTitle.text = @"意见反馈";
                
                
                break;
                
            case 1:
                cell.leftTitle.text = @"评价我们";
                
                
                break;

            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                cell.leftTitle.text = @"常见问题";
                
                
                break;
                
            case 1:
                cell.leftTitle.text = @"关于我们";
                
                
                break;
            case 2:
                cell.leftTitle.text = @"客服电话";
                cell.accessoryImage.hidden = YES;
                cell.accessoryLabel.text = @"4001-333-866";
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}


#pragma -- mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WEAK_SELF
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                DLPersonalrDataVC *personalrVC = [[DLPersonalrDataVC alloc]init];
                [self navigatePushViewController:personalrVC animate:YES];

            }
                break;
            case 1:
            {
                DLAccountSecurityVC *accountVC = [[DLAccountSecurityVC alloc]init];
                [self navigatePushViewController:accountVC animate:YES];
               
            }
                break;
            case 2:
            {
                DLAdressListVC *adressVC = [[DLAdressListVC alloc]init];
                adressVC.comeToAdresModuleType = ComeToAdresModule_FromManageAdress;
                [weak_self navigatePushViewController:adressVC animate:YES];
                
            }
                break;
                
            default:
                break;
        }

        
        
      
    }else if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            {
                DLFeedbackVC *feedbackVC =[[DLFeedbackVC alloc]init];
                [self navigatePushViewController:feedbackVC animate:YES];
            }
                break;
            case 1:
            {
                
                NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1136196562&pageNumber=0&sortOrdering=2&mt=8"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
               
                break;
                
            default:
                break;
        }
    }else {
        
        
        switch (indexPath.row) {
            case 0:
            {
                 [weak_self _enterCordovaH5PageWithH5Code:H5PAGETYPE_COMMON_QUESTION];
            }
                break;
            case 1:
            {
                 [weak_self _enterCordovaH5PageWithH5Code:H5PAGETYPE_ABOUT_US];
                
            }
                break;
            case 2:
            {
                 [Util dialServerNumber:@"4001333866"];
                
            }
                break;
                
            default:
                break;
        }

        
        
        
    }
    
    
}
#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (DLSetFooterView *)footerView{
    WEAK_SELF
    if (!_footerView) {
        _footerView = BoundNibView(@"DLSetFooterView", DLSetFooterView);
        _footerView.block = ^{
        
            
            [weak_self showSimplyAlertWithTitle:@"提示" message:@"是否退出当前账号?" sureAction:^(UIAlertAction *action) {
                [weak_self _requestLogout];
            } cancelAction:^(UIAlertAction *action) {
                
            }];
        };
    }
    
    
    return _footerView;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

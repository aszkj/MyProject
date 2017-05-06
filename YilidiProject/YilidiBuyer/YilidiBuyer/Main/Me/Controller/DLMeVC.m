//
//  DLMeVC.m
//  YilidiBuyer
//
//  Created by yld on 16/4/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMeVC.h"
#import "DLMineCell.h"
#import "DLHomeSpecialItemCollectionViewCell.h"
#import "DLHomeSpecialItemModel.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeKey.h"
#import "DLMembershipDetailsVC.h"
#import "DLMyNewsVC.h"
#import "DLAboutUsVC.h"
#import "DLMeHeaderView.h"
#import "DLAdressListVC.h"
#import "DLMefooterView.h"
#import "DLChangePasswordVC.h"
#import "GlobleConst.h"
#import "DLBaseNavController.h"
#import "ProjectRelativeDefineNotification.h"
#import "UIViewController+showShopCartPage.h"
#import "UserDataManager.h"
#import "DLVipAndPennyGoodsVC.h"
#import "DLMainTabBarController.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLMyWalletVC.h"
#import "DLAccountBalanceVC.h"
#import "DLFeedbackVC.h"
#import "CordovaH5UrlManager.h"
#import "UIView+BlockGesture.h"
#import "DLCordovaH5VC.h"
#import "DLMyfavoriteListVC.h"
#import "AFNHttpRequestOPManager+setCookes.h"
#import "DLSettingsVC.h"
#import "DLOrderListVC.h"
#import "DLRefundOrderVC.h"
#import "UploadPhotoManager.h"
#import "NSString+Teshuzifu.h"
#import "DLMessageVC.h"
const CGFloat headerDefaultHeight = 226.0f;
const CGFloat sectionHeaderHight = 5.0f;
static NSString *meCellIdentifier = @"meCellIdentifier";

@interface DLMeVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

{
    MBProgressHUD *HUD;
    CGFloat progressValue;
    
    
}

@property (nonatomic,strong)UploadPhotoManager *uploadPhotoManager;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIImageView *isMembersImage;
@property (strong, nonatomic) IBOutlet UIImageView *joinImage;
@property (strong, nonatomic) IBOutlet UILabel *isMembersLabel;
@property (strong, nonatomic) IBOutlet UIImageView *isVIPImage;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *meTableView;
@property (nonatomic,strong)DLMefooterView *footerView;
@property (nonatomic,strong)DLMeHeaderView *meheaderView;
@property (nonatomic, assign)CGFloat scrollMaxScrollHeight;

@property (nonatomic, copy)NSDictionary *meDataDic;

@property (strong, nonatomic) IBOutlet UIButton *userPhone;

@property (strong, nonatomic) IBOutlet UILabel *membersTimer;

@property (strong, nonatomic) IBOutlet UILabel *isVipLabel;



@end

@implementation DLMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
   
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self _requestUserInfo];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
}


-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [kNotification removeObserver:self];

    [self.navigationController setNavigationBarHidden:NO animated:animated];
 
    
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    WEAK_SELF
    [self.headerImage  addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
    
        [weak_self _loadPhoto];
        
    }];
    
    [self _initMeTableView];
    
}




-(void)_initMeTableView {
    self.meTableView.delegate = self;
    self.meTableView.dataSource = self;
    self.meTableView.rowHeight = 46.0f;
    [self.meTableView registerNib:[UINib nibWithNibName:@"DLMineCell" bundle:nil] forCellReuseIdentifier:meCellIdentifier];
    
    JLog(@"rect2%@",NSStringFromCGRect(self.meTableView.frame));
}




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

- (void)_loadUserInfo {

   DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
   
    [_userPhone setTitle:userModel.userName forState:UIControlStateNormal];
    [_membersTimer setText:[NSString stringWithFormat:@"有效期至%@",userModel.vipExpireDate]];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:userModel.userImageUrl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
    switch ([userModel.memberType intValue]) {
        case 0:
            [_isVIPImage setImage:[UIImage imageNamed:@"普通"]];
            _membersTimer.hidden=YES;
            _isVipLabel.text =@"升级为铂金会员";
            _isMembersLabel.text = @"普通用户";
            break;
            
        case 1:
            _isVipLabel.text =@"已成为铂金会员";
            _isMembersLabel.text = @"VIP用户";
            _membersTimer.hidden=NO;
            
            break;
            
        default:
            break;
    }
    
    
    
}


- (void)_requestUserInfo {
    
    [AFNHttpRequestOPManager postWithParameters:self.requestParam subUrl:kUrl_GetUserInfo block:^(NSDictionary *resultDic, NSError *error) {
        
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        
        NSString *vipExpireDate;
        if (isEmpty(resultDic[EntityKey][@"vipExpireDate"])) {
            
            vipExpireDate = @"";
        }else{
            vipExpireDate = resultDic[EntityKey][@"vipExpireDate"];
            
        }
        
        NSString *nickName;
        if (isEmpty(resultDic[EntityKey][@"nickName"])) {
            JLog(@".....");
            nickName = @"";
        }else{
            nickName = resultDic[EntityKey][@"nickName"];
            
        }
        NSString *birthday;
        if (isEmpty(resultDic[EntityKey][@"birthday"])) {
            JLog(@".....");
            birthday = @"";
        }else{
            birthday = resultDic[EntityKey][@"birthday"];
            
        }
        
        
        NSDictionary *bindQQInfo;
        if (isEmpty(resultDic[EntityKey][@"bindQQInfo"])) {
            JLog(@".....");
            bindQQInfo = @{};
        }else{
            bindQQInfo = resultDic[EntityKey][@"bindQQInfo"];
        }
        
        NSDictionary *bindWXInfo;
        if (isEmpty(resultDic[EntityKey][@"bindWXInfo"])) {
            JLog(@".....");
            bindWXInfo = @{};
        }else{
            bindWXInfo = resultDic[EntityKey][@"bindWXInfo"];
        }
        
        
        NSDictionary*dic = @{@"bindWXInfo":bindWXInfo,@"bindQQInfo":bindQQInfo,@"userSex":resultDic[EntityKey][@"userSex"],@"birthday":birthday,@"nickName":nickName,@"userImageUrl":(NSString *)[resultDic[EntityKey][@"userImageUrl"]getOriginalImgUrl],@"userName":resultDic[EntityKey][@"userName"],@"vipExpireDate":vipExpireDate,@"memberType":resultDic[EntityKey][@"memberType"],@"userId":resultDic[EntityKey][@"userId"]};
        
        [kUserDefaults setObject:dic forKey:KUserInfoKey];
        [kUserDefaults synchronize];

        [[UserDataManager sharedManager] saveUserInfo:dic];
        
        [self _loadUserInfo];
        
        
    }];
    
}

- (void)_updataUserImage:(NSString *)imageUrl {
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:@{@"userImageUrl":imageUrl} subUrl:kUrl_modifyuserinfo block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code==1) {
            [weak_self _requestUserInfo];
        }else{
            
            [Util ShowAlertWithOnlyMessage:@"头像更新失败"];
        }
        
    }];
    
}


#pragma mark ------------------------View Event---------------------------

- (IBAction)exitButtonClick:(id)sender {
    DLSettingsVC  *updateVipPage = [[DLSettingsVC alloc]init];
    [self navigatePushViewController:updateVipPage animate:YES];
    
}


- (IBAction)messageBtnClick:(id)sender {
    
    DLMessageVC *messageVC = [[DLMessageVC alloc]init];
    [self navigatePushViewController:messageVC animate:YES];
}


- (IBAction)upgradeMembersClick:(id)sender {
    
    //    DLVipAndPennyGoodsVC  *updateVipPage = [[DLVipAndPennyGoodsVC alloc]init];
    ////    updateVipPage.pageTitle = @"升级VIP";
    //    updateVipPage.h5typeCode = H5PAGETYPE_UPGRADE_VIP;
    //    [self navigatePushViewController:updateVipPage animate:YES];
    [self _enterCordovaH5PageWithH5Code:H5PAGETYPE_UPGRADE_VIP];
    
}

- (IBAction)joinDealersClick:(id)sender {
    
    //    DLAboutUsVC  *aboutVC = [[DLAboutUsVC alloc]init];
    //    aboutVC.titleLabel = @"全面招募";
    //    aboutVC.typeCode =H5PAGETYPE_PARTNER_JOIN;
    //    [self navigatePushViewController:aboutVC animate:YES];
    [self _enterCordovaH5PageWithH5Code:H5PAGETYPE_PARTNER_JOIN];
    
}




#pragma mark ------------------------Page Navigate---------------------------
- (void)_loadPhoto{
    WEAK_SELF
    self.uploadPhotoManager.uploadServerUlr = kUrl_PostUserHeaderUrl;
    self.uploadPhotoManager.allowPhotoEditing = YES;
    [self.uploadPhotoManager uploadPhoto:^UploadPhotoImgHandler *(UIImagePickerController *picker, UIImage *image, NSDictionary *editingDic) {
        UploadPhotoImgHandler *uploadPhotoImgHandler = [[UploadPhotoImgHandler alloc] init];
        if ([uploadPhotoImgHandler isToBigOfUserHeaderPhoto:image]) {
            [Util ShowAlertWithOnlyMessage:@"图片太大，请重新选择图片"];
            return uploadPhotoImgHandler;
        }else {
            [uploadPhotoImgHandler handleUserHeaderPhoto:image];
            return uploadPhotoImgHandler;
        }
    } upDateImg:^(NSString *updateImgUrl, NSError *updateImgError) {
        if (updateImgError.code == 1) {
            
            [weak_self _updataUserImage:updateImgUrl];

            
        }else {
            [Util ShowAlertWithOnlyMessage:updateImgError.localizedDescription];
        }
    }];

    
}



- (void)_enterLoginPage {
    
    DLMainTabBarController *main = [[DLMainTabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = main;
}

- (void)_enterCordovaH5PageWithH5Code:(NSString *)h5Code {
    [[CordovaH5UrlManager sharedManager] getH5Url:^(NSString *h5Url) {
        DLCordovaH5VC *h5Page = [[DLCordovaH5VC alloc] init];
        h5Page.h5Url = h5Url;
        [self navigatePushViewController:h5Page animate:YES];
    } forh5Code:h5Code];
}

- (void)_enterMyfavoritePage {
    DLMyfavoriteListVC *myfavoriteListVC = [[DLMyfavoriteListVC alloc] init];
    [self navigatePushViewController:myfavoriteListVC animate:YES];
}

- (void)_enterMyOrderPageWithOrderStatusNumber:(NSInteger)orderNumber {
    DLOrderListVC *orderListPage = [[DLOrderListVC alloc] init];
    orderListPage.defaultSelectOrderStatusNumber = orderNumber;
    [self navigatePushViewController:orderListPage animate:YES];
}

- (void)_enterMyfundOrderPage {
    DLRefundOrderVC *refundOrderVC = [[DLRefundOrderVC alloc] init];
    [self navigatePushViewController:refundOrderVC animate:YES];
}

#pragma mark ------------------------Delegate-----------------------------


#pragma mark - tableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DLMineCell *cell = [self.meTableView dequeueReusableCellWithIdentifier:meCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"商品收藏";
            cell.leftImage.image = [UIImage imageNamed:@"商品收藏"];
            break;
            
        case 1:
            cell.titleLabel.text = @"分享有礼";
            cell.leftImage.image = [UIImage imageNamed:@"分享有礼"];
            break;
        case 2:
            cell.titleLabel.text = @"里米商城";
            cell.leftImage.image = [UIImage imageNamed:@"里米商城"];
            break;
            
        case 3:
            cell.titleLabel.text = @"粉丝专区";
            cell.leftImage.image = [UIImage imageNamed:@"粉丝专区"];
            break;
            
        default:
            break;
    }
    
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.meTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:
            [self _enterMyfavoritePage];
            break;
            
        case 1:
            [self _enterCordovaH5PageWithH5Code:H5PAGETYPE_SHARE_PAGE];
            break;
        case 2:
            [self showSimplyAlertWithTitle:@"提示" message:FunctionTemporarilyNotOpenAlert sureAction:^(UIAlertAction *action) {
                
            }];
            break;
            
        case 3:
            [self showSimplyAlertWithTitle:@"提示" message:FunctionTemporarilyNotOpenAlert sureAction:^(UIAlertAction *action) {
                
            }];
            break;
            
        default:
            break;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 190.0f;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//
//
//    return 69.0f;
//
//
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.meheaderView;
}



#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (UploadPhotoManager *)uploadPhotoManager {
    if (!_uploadPhotoManager) {
        _uploadPhotoManager = [[UploadPhotoManager alloc] init];
    }
    return _uploadPhotoManager;
}


- (DLMeHeaderView*)meheaderView{
    
    if (!_meheaderView) {
        _meheaderView = BoundNibView(@"DLMeHeaderView", DLMeHeaderView);
        
    }
    
    
    WEAK_SELF
    
    _meheaderView.myorderBlock = ^{
        [weak_self _enterMyOrderPageWithOrderStatusNumber:0];
    };
    _meheaderView.paymentBlock = ^{
        [weak_self _enterMyOrderPageWithOrderStatusNumber:1];

    };
    _meheaderView.shouhuoBlock = ^{
        [weak_self _enterMyOrderPageWithOrderStatusNumber:2];
    };
    
    _meheaderView.completeBlock = ^{
        [weak_self _enterMyOrderPageWithOrderStatusNumber:3];
    };
    
    _meheaderView.arefundBlock = ^{
        [weak_self _enterMyfundOrderPage];
    };
    
    
    _meheaderView.myWalletBlock = ^{
        
        DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc]init];
        myWalletVC.index = 0;
        [weak_self navigatePushViewController:myWalletVC animate:YES];
        
        
    };
    _meheaderView.balanceBlock = ^{
        DLAccountBalanceVC *balanceVC = [[DLAccountBalanceVC alloc]init];
        balanceVC.pageTitle = @"账户余额";
        balanceVC.balanceStr = @"余额(元)";
        balanceVC.balanceDetailStr = @"余额明细";
        [weak_self navigatePushViewController:balanceVC animate:YES];
        
        
    };
    
    _meheaderView.limiBlock = ^{
        DLAccountBalanceVC *balanceVC = [[DLAccountBalanceVC alloc]init];
        balanceVC.pageTitle = @"里米明细";
        balanceVC.balanceStr = @"里米(积分)";
        balanceVC.balanceDetailStr = @"里米明细";
        [weak_self navigatePushViewController:balanceVC animate:YES];
        
    };
    
    _meheaderView.couponsBlock = ^{
        
        DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc]init];
        myWalletVC.index = 0;
        [weak_self navigatePushViewController:myWalletVC animate:YES];
        
    };
    
    _meheaderView.vouchersBlock = ^{
        DLMyWalletVC *myWalletVC = [[DLMyWalletVC alloc]init];
        myWalletVC.index = 1;
        [weak_self navigatePushViewController:myWalletVC animate:YES];
    };
    
    return _meheaderView;
    
}





@end

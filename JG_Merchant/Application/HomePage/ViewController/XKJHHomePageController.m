//
//  XKJHHomePageController.m
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHHomePageController.h"
#import "DebugSet.h"
#import "NimbusAttributedLabel.h"
#import "XKJHOrderCouponListViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CustomBasicTableViewCell.h"
#import "UIImage+SizeAndTintColor.h"
#import "UIViewController+Extension.h"
#import "XKJHConsumeViewController.h"
#import "XKJHCommentManageMentController.h"
#import "XKJHOfflineSwipeCardController.h"
#import "XKJHSettingController.h"
#import "QueryProgressViewController.h"
#import "RepyController.h"
#import "EnvironmentPhotoController.h"
#import "HomePageViewModel.h"
#import "UIView+Loading.h"
#import "NSString+BlankString.h"
#import "JGShareView.h"
#import "VApiManager.h"
#import "UIButton+Design.h"
#import "NoticeManagerController.h"
#import "MerchantPosterViewController.h"
#import "JGScanQCodeViewController.h"
#import "JGCheckConsumeController.h"
#import "XKJHCouponDetailsViewController.h"
#import "UIAlertView+Extension.h"
#import "MyErWeiMaController.h"
#import "ScanQRCodeController.h"
@interface XKJHHomePageController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *shopImage;
@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UILabel *invitcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnSalesLable;
@property (weak, nonatomic) IBOutlet UILabel *totalSalesLabel;
@property (weak, nonatomic) IBOutlet UILabel *juanSalesLable;
@property (weak, nonatomic) IBOutlet UILabel *cardSalesLabel;
@property (weak, nonatomic) IBOutlet UILabel *backSalesLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *totalPhoto;

@property (strong, nonatomic) HomePageViewModel *viewModel;
@property (nonatomic) JGShareView *sharView;
@property (nonatomic) NSArray *dataSource;

@property (strong, nonatomic)NSNumber    *giveIntegral;
@property (strong, nonatomic)VApiManager *vManager;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (strong,nonatomic) NSArray *groupSn;

@end


@implementation XKJHHomePageController

static NSString *cellIdentifier = @"CustomBasicTableViewCell";

-(id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vManager = [[VApiManager alloc] init];
    
    [self _registerMakeIntegralRequest];
    
    [self setUIContent];
    [self setViewsMASConstraint];
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.viewModel.merchantInfoCommand execute:nil];
    }];
    [self.viewModel.merchantInfoCommand.executing subscribeNext:^(NSNumber *executing) {
        if (![executing boolValue]) {
            [scrollView.header endRefreshing];
        }
    }];
    [self.viewModel.merchantInfoCommand execute:nil];
    
    [RACObserve(self.viewModel, merchant) subscribeNext:^(id x) {
        RAC(self.totalPhoto,text) = [RACObserve(self.viewModel.merchant, totalPhoto) map:^id(NSNumber *number) {
            return [[number stringValue] stringByAppendingString:@"张"];
        }];
        RAC(self.storeName,text) = RACObserve(self.viewModel.merchant, storeName);
//        RAC(self.invitcodeLabel,text) = [RACObserve(self.viewModel.merchant, invitationCode) map:^(NSString *code) {
//            if (!code.length > 0)   code = @"";
//            return [@" 邀请码：" stringByAppendingString:code];
//        }];
        [[RACObserve(self.viewModel.merchant, totalPayAmount) distinctUntilChanged] subscribeNext:^(NSNumber *totalNumber) {
            @strongify(self)
            [self setTotalSalesNumber:totalNumber];
        }];
        [[RACObserve(self.viewModel.merchant, profitAmount) distinctUntilChanged]
         subscribeNext:^(NSNumber *totalNumber) {
             @strongify(self)
             [self setEarnSalesNumber:totalNumber];
         }];
        [[RACObserve(self.viewModel.merchant, couponPayAmount) distinctUntilChanged] subscribeNext:^(NSNumber *totalNumber) {
            @strongify(self)
            [self setJuanSales:totalNumber];
        }];
        [[RACObserve(self.viewModel.merchant, chargePayAmount) distinctUntilChanged] subscribeNext:^(NSNumber *totalNumber) {
            @strongify(self)
            [self setCardSales:totalNumber];
        }];
        [[RACObserve(self.viewModel.merchant, rebateAmount) distinctUntilChanged] subscribeNext:^(NSNumber *totalNumber) {
            @strongify(self)
            [self setBackSales:totalNumber];
        }];
        [[RACObserve(self.viewModel.merchant, coverPath) distinctUntilChanged] subscribeNext:^(NSString *coverPath) {
            @strongify(self)
            [self.shopImage sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(coverPath,CGRectGetWidth(self.shopImage.frame),CGRectGetHeight(self.shopImage.frame))]];
        }];
        [[RACObserve(self.viewModel.merchant, storeLogoPath) distinctUntilChanged] subscribeNext:^(NSString *storeLogoPath) {
            @strongify(self)
            [self.shopLogo sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(storeLogoPath,CGRectGetWidth(self.shopLogo.frame),CGRectGetHeight(self.shopLogo.frame))]];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewModel.active = YES;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    self.viewModel.active = NO;
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightTableView:tableView atIndexPath:indexPath];
}

- (CGFloat)getHeightTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    return 49.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headerView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self showJuanSalesAction];
    } else if (indexPath.section == 1) {
        [self showCardSalesAction];
    } else if (indexPath.section == 2) {
        [self showCommentManager];
    }else if (indexPath.section == 3) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strNumIsO2O = [userDefaults objectForKey:kUserDefaultsIsO2OKey];
        //判断是否是O2O商户是的话显示扫码收钱选项 1是O2O 0不是
        if ([strNumIsO2O isEqualToString:@"1"]) {
            //扫码
            ScanQRCodeController *scanQRCodeVC = [[ScanQRCodeController alloc]init];
            [self.navigationController pushViewController:scanQRCodeVC animated:YES];
        }else{
            [self showNoticeController];
        }

    }else if (indexPath.section == 4){
        [self showNoticeController];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    CustomBasicTableViewCell *basicCell = (CustomBasicTableViewCell *)cell;
    NSArray *contentArray = self.dataSource[indexPath.section];
    basicCell.leftImageView.image = [UIImage imageNamed:contentArray[0]];
    basicCell.basicTitle.text = contentArray[1];
}

#pragma mark - CustomDelegate



#pragma mark - event response

- (void)showPhotoViewController:(id)sender {
    EnvironmentPhotoController *VC = [[EnvironmentPhotoController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)showCardSalesAction {
    XKJHOfflineSwipeCardController *offLineSwipeCardVC = [[XKJHOfflineSwipeCardController alloc] init];
    offLineSwipeCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:offLineSwipeCardVC animated:YES];
    
}

- (void)showJuanSalesAction {
    XKJHConsumeViewController *consumeViewController = [[XKJHConsumeViewController alloc] init];
    [self.navigationController pushViewController:consumeViewController animated:YES];
}


- (void)showCommentManager {
    XKJHCommentManageMentController *commentManageMentVC = [[XKJHCommentManageMentController alloc] init];
    commentManageMentVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentManageMentVC animated:YES];
}
- (void)showNoticeController {
    MerchantPosterViewController *noticeManagerController = [[MerchantPosterViewController alloc] init];
    [self.navigationController pushViewController:noticeManagerController animated:YES];
}


- (IBAction)sharection
{
    MyErWeiMaController *invitationVC = [[MyErWeiMaController alloc] init];
    [self.navigationController pushViewController:invitationVC animated:YES];
}
/**
 *  最新邀请好友按钮
 */
- (void)newInvite
{
    
}
/**
 *  原来的分享按钮事件
 */
- (void)agoShareClick
{
    DDLogWarn(@"分享商户信息");
    _sharView = [JGShareView shareViewWithTitle:kInvitationShareTitle1(_giveIntegral) content:kInvitationShareDescription1(_giveIntegral) imgUrlStr:kLogShareUrl ulrStr:kInvitationCodeShareUrlCode(self.viewModel.merchant.invitationCode) contentView:self.tabBarController.view shareImagePath:nil];
    _sharView.wxShareModel.shareContent = kInvitationShareDescription2(_giveIntegral);
    _sharView.wxFriendShareModle.shareTitle = kInvitationShareDescription1(_giveIntegral);
    _sharView.weiBoShareModel.shareContent = kWeiboShareContent(self.viewModel.merchant.invitationCode, _giveIntegral);
    [self.sharView show];
}

#pragma mark - 注册加积分请求
- (void)_registerMakeIntegralRequest {
    
    SnsIntegralGetRequest *request = [[SnsIntegralGetRequest alloc] init:GetToken];
    request.api_type = @1;
    [_vManager snsIntegralGet:request success:^(AFHTTPRequestOperation *operation, SnsIntegralGetResponse *response) {
        if ([response isKindOfClass:[SnsIntegralGetResponse class]]) {
            _giveIntegral = response.integral;
        } else if ([response isKindOfClass:[NSDictionary class]]){
            SnsIntegralGetResponse *integralResponse = [SnsIntegralGetResponse objectWithKeyValues:response];
            NSLog(@"注册送 %@积分",integralResponse.integral);
            _giveIntegral = integralResponse.integral;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}



#pragma mark - private methods

- (void)setting {
    XKJHSettingController *settingController = [[XKJHSettingController alloc] init];
    [self.navigationController pushViewController:settingController animated:YES];
}

- (void)initTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 45.5;
    self.tableView.rowHeight = 45.5;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier];
    
    [self.tableView setTableFooterView:[self lineView]];
}

- (void)setBarButtonItem {
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo1"]];
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"云e店"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithNormalImage:@"setting" target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"scan_mer" target:self action:@selector(scan)];
}


- (void)scan {
    WEAK_SELF;
    JGScanQCodeViewController * sqVC = [[JGScanQCodeViewController alloc] initWithCodeSuccess:^(NSString *codeInfo) {
        
        [weak_self consumeCodeInfo:codeInfo nothing:^{
            // 没有未消费码
        [UIAlertView xf_showWithTitle:@"无效消费码" message:@"" delay:1.2 onDismiss:^{
        }];
            
        } one:^(NSArray *groupSn) {
            /**
             *
             {
             groupAccPath = "http://f1.jgyes.cn/2,15798077ed8f";
             groupId = 110;
             groupName = mm12121;
             groupSn = 0998481204;
             status = 0;
             totalPrice = 1;
             },
             */
            // 只有一个消费码 提示是否消费  点确定直接调用确认消费接口
            if (!groupSn.count) {
                return ;
            }
            weak_self.groupSn = groupSn;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否确认消费?" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.tag = 9088;
            [alertView show];
            
        } more:^(NSDictionary *ParamsDic,NSString *orderId) {
            JGCheckConsumeController *check = [[JGCheckConsumeController alloc] initWithCodeParams:ParamsDic orderId:orderId];
            [weak_self.navigationController pushViewController:check animated:YES];
            
        }];
    } fail:^{
        
    }];
    UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
    [self presentViewController:nVC animated:YES completion:nil];
}

- (void)consumeCodeInfo:(NSString *)info nothing:(void(^)())nothing one:(void(^)(NSArray *oneArray))oneBlock more:(void(^)(NSDictionary *moreArray,NSString *order))moreBlock{
    if (!info) {
        return;
    }
    NSArray *infoArray = [info componentsSeparatedByString:@"="];
    if (infoArray.count) {
        // 订单号 例如:1178
        NSString *orderId  = infoArray[1];
        VApiManager *manager = [[VApiManager alloc] init];
        PersonalUnUsedorderDetailsRequest *request = [[PersonalUnUsedorderDetailsRequest alloc] init:GetToken];
        request.api_orderId = [NSNumber numberWithInteger:[orderId integerValue]];
        [manager personalUnUsedorderDetails:request success:^(AFHTTPRequestOperation *operation, PersonalUnUsedorderDetailsResponse *response) {
            NSDictionary *orderDetails = [NSDictionary dictionaryWithDictionary:(NSDictionary *)response.orderDetails];
            NSArray *serviceList =  [NSArray arrayWithArray:orderDetails[@"serviceList"]];
            if (serviceList.count) {
                if (serviceList.count == 1 ) {
                    if (oneBlock) {
                        oneBlock(serviceList);
                    }
                }else {
                    if (moreBlock) {
                        moreBlock(orderDetails,orderId);
                    }
                }
                
            }else {
                if (nothing) {
                    nothing();
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            JGLog(@"err:%@",error.domain);
            
        }];
        
    }
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    //navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBar.barTintColor = status_color;
    navBar.translucent = NO;
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    [self initTableView];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.tableViewHeightConstraint.constant = 270;
    self.view.backgroundColor = background_Color;
//    UIImage *shareImage = [[UIImage imageNamed:@"share_icon"] imageWithTintColor:UIColorFromRGB(0x525354)];
//    [self.shareButton setImage:shareImage forState:UIControlStateNormal];
    [self.shareButton setTintColor:UIColorFromRGB(0x525354)];
    [self.shareButton setEnlargeEdgeWithTop:10 right:20 bottom:10 left:20];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhotoViewController:)];
    self.shopImage.userInteractionEnabled = YES;
    [self.shopImage addGestureRecognizer:tap];
}

- (void)setViewsMASConstraint {
    [self.shopImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
    }];
}

#pragma mark - getters and settters

- (HomePageViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[HomePageViewModel alloc] init];
    }
    return _viewModel;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strNumIsO2O = [userDefaults objectForKey:kUserDefaultsIsO2OKey];
        //判断是否是O2O商户是的话显示扫码收钱选项 1是O2O 0不是
        if ([strNumIsO2O isEqualToString:@"1"]) {
            _dataSource = @[@[@"Coupons consumption",@"券消费"],@[@"The line card",@"线下刷卡"],@[@"comment_icon",@"评价管理"],@[@"comment_icon",@"扫码收钱"],@[@"comment_icon",@"公告"]];
        }else{
            _dataSource = @[@[@"Coupons consumption",@"券消费"],@[@"The line card",@"线下刷卡"],@[@"comment_icon",@"评价管理"],@[@"comment_icon",@"公告"]];
        }

    }
    return _dataSource;
}

- (void)setJuanSales:(NSNumber *)totalSales {
    NSString *decoratedString = [NSString decoratedString:kNumberToStr(totalSales) insertString:@"," everyRange:3];
    self.juanSalesLable.text = [NSString stringWithFormat:@"%@ \n 券收益额",decoratedString];
}

- (void)setCardSales:(NSNumber *)totalSales {
    NSString *decoratedString = [NSString decoratedString:kNumberToStr(totalSales) insertString:@"," everyRange:3];
    self.cardSalesLabel.text = [NSString stringWithFormat:@"%@ \n 刷卡收益额",decoratedString];
}

- (void)setBackSales:(NSNumber *)totalSales {
    NSString *decoratedString = [NSString decoratedString:kNumberToStr(totalSales) insertString:@"," everyRange:3];
    self.backSalesLabel.text = [NSString stringWithFormat:@"%@ \n 消费返润总额",decoratedString];
}

- (void)setTotalSalesNumber:(NSNumber *)totalSales {
    NSString *decoratedString = [NSString decoratedString:kNumberToStr(totalSales) insertString:@"," everyRange:3];
    self.totalSalesLabel.text = [NSString stringWithFormat:@"%@ \n 销售总额",decoratedString];
}

- (void)setEarnSalesNumber:(NSNumber *)totalSales {
    NSString *decoratedString = [NSString decoratedString:kNumberToStr(totalSales) insertString:@"," everyRange:3];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ \n 收益总额",decoratedString]];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:12.0],NSFontAttributeName,
                                   [UIColor darkGrayColor],NSForegroundColorAttributeName,
                                   nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"收益总额"];
    [attributedString addAttributes:attributeDict range:range];
    attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:14.0],NSFontAttributeName,
                                   [UIColor blackColor],NSForegroundColorAttributeName,
                                   nil
                                   ];
    range = [attributedString.string rangeOfString:decoratedString];
    [attributedString addAttributes:attributeDict range:range];
    self.earnSalesLable.attributedText = attributedString.copy;
}

- (UIView *)headerView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    lineView.backgroundColor = [UIColor clearColor];
    return lineView;
}

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
    lineView.backgroundColor = self.view.backgroundColor;
    return lineView;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [DebugSet showExplor];
    [self.tableView reloadData];
    [self setTotalSalesNumber:@(123456)];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 9088) {
        // 扫码单个消费
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在验证消费劵...";
        [hud show:YES];
        GroupVoucherDetailsRequest *detailRequest = [[GroupVoucherDetailsRequest alloc] init:GetToken];
        NSDictionary *groupSnDic = [NSDictionary dictionaryWithDictionary:[self.groupSn firstObject]];
        detailRequest.api_groupSn = [NSString stringWithFormat:@"%@",groupSnDic[@"groupSn"]];
        VApiManager *manage = [[VApiManager alloc] init];
        [manage groupVoucherDetails:detailRequest success:^(AFHTTPRequestOperation *operation, GroupVoucherDetailsResponse *response) {
            [MBProgressHUD hideHUDForView:self.view animated: YES];
            GroupGoods *groupGoods = [GroupGoods objectWithKeyValues:response.groupGoodsDetails];
            if (groupGoods)
            {
                XKJHCouponDetailsViewController *detailsVC = [[XKJHCouponDetailsViewController alloc] initWithNibName:@"XKJHCouponDetailsViewController" bundle:nil];
                detailsVC.groupDoods= groupGoods;
                [self.navigationController pushViewController:detailsVC animated:YES];
            }
            else
            {
                [UIAlertView xf_showWithTitle:@"使用消费码失败!" message:@"" delay:1.2 onDismiss:^{
                }];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [UIAlertView xf_showWithTitle:@"网络异常..." message:@"" delay:1.2 onDismiss:^{
            }];
        }];

    }
}

@end

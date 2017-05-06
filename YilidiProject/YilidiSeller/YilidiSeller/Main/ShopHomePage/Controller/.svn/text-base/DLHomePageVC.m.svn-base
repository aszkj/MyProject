//
//  DLHomePageVC.m
//  YilidiSeller
//
//  Created by yld on 16/5/31.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomePageVC.h"
#import "MyCommonCollectionView.h"
#import "DLHomeCollectionCell.h"
#import "ProjectRelativeMaco.h"
#import "DLHomeSpecialItemModel.h"
#import "DLDataStatisticsVC.h"
#import "DLInvitationVC.h"
#import "RatingView.h"
#import "DLShopManagementVC.h"
#import "GlobeMaco.h"
#import "DLHomeHeaderView.h"
#import "DLOrderListVC.h"
#import "GlobleConst.h"
#import "UIImageView+sd_SetImg.h"
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "MycommonTableView.h"
#import "DLRequestUrl.h"
#import "DLHomeCell.h"
#import "DLGoodsManageMentVC.h"
#import "DLDispatchGoodsManageVC.h"
#import "DLVipNumberVC.h"
#import <Masonry/Masonry.h>
#import "DLAccountSettlementCell.h"
#import "DLSettlementModel.h"
#import "DLSettlementFooterView.h"
#import "NSObject+setModelIndexPath.h"
#import "DLClassificationVC.h"
#import "DLServiceHotlineVC.h"
#define KTitleOrderManage @"订单管理"
#define KTitleStorePromotion @"店铺推广"
#define KTitleGoodsManage @"商品管理"
#define KTitleStoreManage @"店铺管理"
#define KTitleCustomerService @"联系客服"
#define KTitleWantToDispactchGoods @"我要调货"


@interface DLHomePageVC ()
{

    CGFloat headViewHeight;
}
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *homeCollectionView;
//@property (nonatomic,strong)DLHomeHeaderView *headerView;
@property (nonatomic,strong) NSArray *navigationDataArr;
@property (nonatomic,strong) NSArray *settlementDataArr;
@property (nonatomic,strong) RatingView *stars;
@property (strong, nonatomic) IBOutlet UIView *starView;

@property (strong, nonatomic) IBOutlet UIImageView *storeImage;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *storePhone;
@property (strong, nonatomic) IBOutlet UILabel *storeTimer;
@property (strong, nonatomic) IBOutlet UIButton *navigationButton;
@property (strong, nonatomic) IBOutlet UIButton *accountButton;
@property (strong, nonatomic) IBOutlet MycommonTableView *homeTableView;
@property (nonatomic,strong)MycommonTableView *accountTableView;
@property (nonatomic,strong)NSDictionary *timerData;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic,strong)UIImageView *arrowImgView;


@end

@implementation DLHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _initHomeTableView];
    [self _initAccountTableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self _requestData];
    [self _notification];
   
}

- (void)viewWillDisappear:(BOOL)animated {
   
    [super viewWillDisappear:animated];
        self.navigationController.navigationBar.hidden = NO;
//     [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//获取控制器中View的frame
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.accountTableView.frame =CGRectMake(0, self.headerView.frame.size.height+5, kScreenWidth, kScreenHeight-self.headerView.frame.size.height-5);
    
    
}



#pragma mark ------------------------Init---------------------------------
- (void)_init{

    self.arrowImgView = [UIImageView new];
    self.arrowImgView.image = IMAGE(@"triangle");
    [self.view addSubview:self.arrowImgView];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationButton.mas_bottom);
        make.centerX.mas_equalTo(self.navigationButton);
        make.size.mas_equalTo(CGSizeMake(9, 7));
    }];
}
- (void)_initHomeTableView {
    DLHomeSpecialItemModel *model1 = [[DLHomeSpecialItemModel alloc] init];
    model1.iconName = @"home1";
    model1.title = KTitleOrderManage;
    model1.content = @"用户订单查看、配送、收货";
    DLHomeSpecialItemModel *model2 = [[DLHomeSpecialItemModel alloc] init];
    model2.iconName = @"home2";
    model2.title = KTitleStorePromotion;
    model2.content = @"邀请用户注册成VIP 即返现";
    DLHomeSpecialItemModel *model3 = [[DLHomeSpecialItemModel alloc] init];
    model3.iconName = @"home3";
    model3.title = KTitleGoodsManage;
    model3.content = @"店铺商品上架、下架、库存等";
    DLHomeSpecialItemModel *model4 = [[DLHomeSpecialItemModel alloc] init];
    model4.iconName = @"home4";
    model4.title = KTitleStoreManage;
    model4.content = @"店铺基本信息查看、修改等";
    DLHomeSpecialItemModel *model5 = [[DLHomeSpecialItemModel alloc] init];
    model5.iconName = @"home5";
    model5.title = KTitleCustomerService;
    model5.content = @"服务经理、客服等联系方式";
    DLHomeSpecialItemModel *model6 = [[DLHomeSpecialItemModel alloc] init];
    model6.iconName = @"home6";
    model6.title = KTitleWantToDispactchGoods;
    model6.content = @"采购商品、补充库存";
    
    _navigationDataArr = @[model1,model3,model4,model2,model5];
    self.homeTableView.cellHeight = 70.0f;
//    self.homeTableView.firstSectionHeaderHeight = 248.0f;
    [self.homeTableView configurecellNibName:@"DLHomeCell" cellDataSource:_navigationDataArr configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
      
        DLHomeSpecialItemModel *model = (DLHomeSpecialItemModel *)cellModel;
        DLHomeCell *homeCell = (DLHomeCell *)cell;
        homeCell.image.image = IMAGE(model.iconName);
        homeCell.title.text = model.title;
        homeCell.content.text = model.content;
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
        DLHomeSpecialItemModel *model = (DLHomeSpecialItemModel *)cellModel;
        NSString *title = model.title;
        if ([title isEqualToString:KTitleOrderManage]) {
            DLOrderListVC *orderlistVC = [[DLOrderListVC alloc] init];
            [self navigatePushViewController:orderlistVC animate:YES];
        }else if ([title isEqualToString:KTitleStorePromotion]){
            DLInvitationVC *invitationVC = [[DLInvitationVC alloc]init];
            [self navigatePushViewController:invitationVC animate:YES];
        }else if ([title isEqualToString:KTitleStoreManage]){
            DLShopManagementVC *managementVC = [[DLShopManagementVC alloc]init];
            [self navigatePushViewController:managementVC animate:YES];
        }else if ([title isEqualToString:KTitleGoodsManage]){
            DLClassificationVC *goodsManageVC = [[DLClassificationVC alloc] init];
            [self navigatePushViewController:goodsManageVC animate:YES];
        }else if ([title isEqualToString:KTitleCustomerService]){
            
            DLServiceHotlineVC *hotlineVC = [[DLServiceHotlineVC alloc] init];
            [self navigatePushViewController:hotlineVC animate:YES];
            
        }else if ([title isEqualToString:KTitleWantToDispactchGoods]){
            DLDispatchGoodsManageVC *dispatchGoodsVC = [[DLDispatchGoodsManageVC alloc] init];
            [self navigatePushViewController:dispatchGoodsVC animate:YES];
        }
    }];

        self.stars = [[RatingView alloc]initWithFrame:CGRectMake(0, 0, self.starView.frame.size.width, 9)];
        self.stars.rating = 10;
        [self.starView addSubview:self.stars];

}


- (void)_initAccountTableView{

   
    
    self.accountTableView = [[MycommonTableView alloc]initWithFrame:CGRectMake(0, self.headerView.frame.size.height+5, kScreenWidth, kScreenHeight-self.headerView.frame.size.height-5)style:UITableViewStyleGrouped];
    self.accountTableView.hidden = YES;
    self.accountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.accountTableView.showsVerticalScrollIndicator=NO;
    self.accountTableView.cellHeight = 51.0f;
    self.accountTableView.firstSectionFooterHeight = 70.0f;
    self.accountTableView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
   
    
    [self.accountTableView configurecellNibName:@"DLAccountSettlementCell"   configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLSettlementModel *model = (DLSettlementModel *)cellModel;
        DLAccountSettlementCell *settlementCell = (DLAccountSettlementCell *)cell;
        settlementCell.title.text=model.title;
        
        
        settlementCell.totalAmountLabel.text= [NSString stringWithFormat:@"%.2f元",[model.totalAmount floatValue]/1000];
        
        NSLog(@"index:%ld",(long)model.modelAtIndexPath.row);
        if (model.modelAtIndexPath.row==0||model.modelAtIndexPath.row==5) {
            settlementCell.totalAmountLabel.textColor = [UIColor redColor];
        }
        if (model.modelAtIndexPath.row==3||model.modelAtIndexPath.row==4||model.modelAtIndexPath.row==5) {
            settlementCell.totalLabel.text=[NSString stringWithFormat:@"%ld人",(long)model.total];
        }else{
            settlementCell.totalLabel.text=[NSString stringWithFormat:@"%ld单",(long)model.total];
        }

        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
   
    

    WEAK_SELF
     [self.accountTableView  configureFirstSectioFooterNibName:@"DLSettlementFooterView" ConfigureTablefirstSectionFooterBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionFooterView) {
         
         DLSettlementFooterView *footerView = (DLSettlementFooterView *)firstSectionFooterView;
         footerView.statisticalBlock= ^{
         
             DLDataStatisticsVC *dataVC = [[DLDataStatisticsVC alloc]init];
             [weak_self navigatePushViewController:dataVC animate:YES];
         };
         
     }];

    
    
    [self.view addSubview:self.accountTableView];
    
    
    
    
}

#pragma mark ------------------------Private-------------------------
#pragma mark ------------------------Api----------------------------------

- (void)_requestData {

//    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_Summerizetotal block:^(NSDictionary *resultDic, NSError *error) {
//        [self hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        NSLog(@"data:%@",resultDic[EntityKey]);
        DLSettlementModel *model1 = [[DLSettlementModel alloc] init];
        model1.title = @"当日订单";
        model1.total = [resultDic[EntityKey][@"orderTotalCountToday"]integerValue];
        model1.totalAmount = resultDic[EntityKey][@"orderTotalAmtToday"];
        
        DLSettlementModel *model2 = [[DLSettlementModel alloc] init];
        model2.title = @"应结算订单";
        model2.total = [resultDic[EntityKey][@"shouldSettleOrderCount"]integerValue];
        model2.totalAmount = resultDic[EntityKey][@"shouldSettleOrderAmt"];
        
        DLSettlementModel *model3 = [[DLSettlementModel alloc] init];
        model3.title = @"已结算订单";;
        model3.total = [resultDic[EntityKey][@"settledOrderCount"]integerValue];
        model3.totalAmount =  resultDic[EntityKey][@"settledOrderAmt"];
    
        DLSettlementModel *model4 = [[DLSettlementModel alloc] init];
        model4.title = @"当日推广VIP用户";;
        model4.total = [resultDic[EntityKey][@"inviteVIPCountToday"]integerValue];
        model4.totalAmount =  resultDic[EntityKey][@"inviteVIPAmtToday"];
        
        DLSettlementModel *model5 = [[DLSettlementModel alloc] init];
        model5.title = @"应结算推广费";;
        model5.total =  [resultDic[EntityKey][@"shouldSettleInviteCount"]integerValue];
        model5.totalAmount =  resultDic[EntityKey][@"shouldSettleInviteAmt"];
        
        DLSettlementModel *model6 = [[DLSettlementModel alloc] init];
        model6.title = @"已结算推广费";;
        model6.total = [resultDic[EntityKey][@"settledInviteCount"]integerValue];
        model6.totalAmount = resultDic[EntityKey][@"settledInviteAmt"];
        
        _settlementDataArr = @[model1,model2,model3,model4,model5,model6];
        
        [self.accountTableView configureTableAfterRequestTotalData:_settlementDataArr];
        [self.accountTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        [self.accountTableView reloadData];
        
    }];
    
    NSDictionary *homeData  = [kUserDefaults objectForKey:HomeResponeData];
    if (homeData!=nil) {
        NSString *begin = homeData[@"beginBusinessHours"];
        if (begin.length>7) {
            begin = [begin substringWithRange:NSMakeRange(begin.length-8, 5)];
            
        }
        NSString *end = homeData[@"endBusinessHours"];
        if (end.length>7) {
            end = [end substringWithRange:NSMakeRange(end.length-8, 5)];
        }
        self.storeTimer.text = [NSString stringWithFormat:@"营业时间：%@-%@",begin,end];
        self.storePhone.text = [NSString stringWithFormat:@"%@",homeData[@"userName"]];
        self.storeName.text =[NSString stringWithFormat:@"%@(%@)",homeData[@"storeName"],homeData[@"addressDetail"]];
        
        
    }
}

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)NavigationFunctionBtnClick:(id)sender {
    self.navigationButton.selected=NO;
    self.accountButton.selected=NO;
    self.accountTableView.hidden=YES;
    self.homeTableView.hidden=NO;
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.navigationButton.mas_bottom);
            make.centerX.mas_equalTo(self.navigationButton);
            make.size.mas_equalTo(CGSizeMake(9, 7));
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];

    
}

- (IBAction)accountSettlementBtnClick:(id)sender {
    self.navigationButton.selected=YES;
    self.accountButton.selected=YES;
    self.accountTableView.hidden=NO;
    self.homeTableView.hidden=YES;
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        
        [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountButton.mas_bottom);
            make.centerX.mas_equalTo(self.accountButton);
            make.size.mas_equalTo(CGSizeMake(9, 7));
            
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

- (void)_notification {

//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pageAction:) name:@"pageJump" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHomeData:) name:@"getHomeData" object:nil];
}
- (void)getHomeData:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"requestData"]) {
        if (SESSIONID) {
            [self _requestData];
        }
       
        
    }
}

/*页面跳转
- (void)pageAction:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"isAlertView"]) {
        [self showSimplyAlertWithTitle:@"提示" message:@"老板,您有新订单了,请尽快处理。" sureAction:^(UIAlertAction *action) {
           
            DLOrderListVC *orderlistVC = [[DLOrderListVC alloc] init];
            [self navigatePushViewController:orderlistVC animate:YES];
            
        }];
        
    }else{
        DLOrderListVC *orderlistVC = [[DLOrderListVC alloc] init];
        [self navigatePushViewController:orderlistVC animate:YES];
    }

    
}

 */
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ------------------------Getter / Setter----------------------



@end

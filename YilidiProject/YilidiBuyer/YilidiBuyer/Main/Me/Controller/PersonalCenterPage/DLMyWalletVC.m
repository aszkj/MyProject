//
//  DLMyWalletVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/17.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLMyWalletVC.h"
#import "GlobleConst.h"
#import "DLCouponsVC.h"
#import "DLAccountBalanceVC.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
@interface DLMyWalletVC ()< UIScrollViewDelegate>
{
    
    BOOL isPush;
    
}
@property (nonatomic, strong) NSMutableArray *topTitles;
@property (nonatomic, strong) NSMutableArray *effectivesName;
@property (nonatomic,strong)  NSMutableArray *types;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *accountName;
@property (strong, nonatomic) IBOutlet UILabel *accountMoney;
@property (strong, nonatomic) IBOutlet UILabel *limiName;
@property (strong, nonatomic) IBOutlet UILabel *accountLimi;

@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;

@end

@implementation DLMyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"我的钱包";

    [self _getWalletData];
    isPush =YES;
 
}

- (void)_createSegementControll {
    NSArray *classNames =  self.topTitles;
    self.topBarControl = [[HMSegmentedControl alloc] initWithSectionTitles:classNames];
    [self.view addSubview:self.topBarControl];
    self.topBarControl.frame = CGRectMake(0, 72, self.view.frame.size.width, 44);
    self.topBarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarControl.selectionIndicatorHeight = 2.0f;
    self.topBarControl.font = [UIFont fontWithName:@"Heiti SC" size:16.0f];
    self.topBarControl.textColor = KTextColor;
    self.topBarControl.selectedTextColor = KCOLOR_MAIN_TEXT;
    self.topBarControl.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    
    [self _creatHMSegementController];
}


- (void)_creatHMSegementController {
    WEAK_SELF
    self.topBarController = [[HMSegementController alloc] initWithSegementControl:self.topBarControl segementControllerFrame:CGRectMake(0, 116, kScreenWidth,kScreenHeight-116-64) childSegementControllClass:[DLCouponsVC class] childControllersCompletedAddedBlock:^(NSArray *childControllers) {
        [weak_self _assignClassCodeForChildVcs:childControllers];
        
    }];
    self.topBarController.indexChangeBlock = ^(NSInteger index, UIViewController *childVc){
        DLCouponsVC *childVCR = (DLCouponsVC *)childVc;
    };
    
}

- (void)_assignClassCodeForChildVcs:(NSArray *)chilVcs {
    for (NSInteger i=0; i<chilVcs.count; i++) {
        DLCouponsVC *couponsVC = (DLCouponsVC *)chilVcs[i];
        NSNumber *type = self.types[i];
        [couponsVC setTicketType:type];
        [couponsVC setTicketTitles:self.effectivesName];

    }
}




- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

    if (isPush==YES) {
        if (self.topBarControl) {
            [self.topBarController setSegementIndex:self.index animated:YES];
            isPush=NO;
        }
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_getWalletData{
    
    [self showLoadingHub];
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:nil subUrl:kUrl_AccountInfoUrl block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        
        weak_self.accountMoney.textColor = KCOLOR_PROJECT_RED;
        weak_self.accountLimi.textColor = KCOLOR_PROJECT_RED;
    
        NSArray *accountInfoListArr =resultDic[EntityKey][@"accountInfoList"];
        weak_self.accountName.text = [accountInfoListArr objectAtIndex:0][@"accountName"];
        weak_self.accountMoney.text = [NSString stringWithFormat:@"%.2f",[[accountInfoListArr objectAtIndex:0][@"accountNum"]floatValue]/1000];
        
        weak_self.limiName.text = [accountInfoListArr objectAtIndex:1][@"accountName"];
        weak_self.accountLimi.text = [NSString stringWithFormat:@"%d",[[accountInfoListArr objectAtIndex:1][@"accountNum"]intValue]];
        
        NSArray *ticketInfoListArr = resultDic[EntityKey][@"ticketInfoList"];
        self.types=[[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        self.topTitles=[[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        self.effectivesName = [[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        for (int count=0; count<ticketInfoListArr.count; count++) {
            NSNumber *num = [NSNumber numberWithInteger:[[ticketInfoListArr objectAtIndex:count][@"ticketType"]integerValue]];
            [weak_self.types addObject:num];
            NSString *topTitleName = [NSString stringWithFormat:@"%@(%ld)",[ticketInfoListArr objectAtIndex:count][@"ticketTypeName"],[[ticketInfoListArr objectAtIndex:count][@"ticketCount"]integerValue]];
            [weak_self.topTitles addObject:topTitleName];
            
            NSString *effectiveName = [NSString stringWithFormat:@"%@",[ticketInfoListArr objectAtIndex:count][@"ticketTypeName"]];
            [weak_self.effectivesName addObject:effectiveName];
        }
        
        
//        [weak_self _initTopTitleView];
        [self _createSegementControll];
        
        
    }];
    
}


#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)balanceButtonClick:(id)sender {
    DLAccountBalanceVC *balanceVC = [[DLAccountBalanceVC alloc]init];
    balanceVC.pageTitle = @"账户余额";
    balanceVC.balanceStr = @"余额(元)";
    balanceVC.balanceDetailStr = @"余额明细";
    [self navigatePushViewController:balanceVC animate:YES];
}
- (IBAction)myLimiButtonClick:(id)sender {
    DLAccountBalanceVC *balanceVC = [[DLAccountBalanceVC alloc]init];
    balanceVC.pageTitle = @"里米明细";
    balanceVC.balanceStr = @"里米(积分)";
    balanceVC.balanceDetailStr = @"里米明细";
    [self navigatePushViewController:balanceVC animate:YES];
}

@end

//
//  DLEvaluationDetailsVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/14.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLEvaluationDetailsVC.h"
#import "GlobleConst.h"
#import "DLAllEvaluationVC.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "AFNHttpRequestOPManager+checkNetworkStatus.h"
#import "HMSegmentedControl.h"
#import "HMSegementController.h"
@interface DLEvaluationDetailsVC ()
@property (nonatomic, strong) NSMutableArray *topTitles;
@property (nonatomic, strong) NSMutableArray *effectivesName;
@property (nonatomic,strong)  NSMutableArray *types;
@property (strong, nonatomic) HMSegmentedControl *topBarControl;
@property (strong, nonatomic) HMSegementController *topBarController;
@end

@implementation DLEvaluationDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"全部评价";
    
    [self _requestAllEvaluationData];
//    isPush =YES;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    if (self.topBarControl) {
        [self.topBarController setSegementIndex:0 animated:YES];
        
    }
    
}

- (void)_createSegementControll {
    NSArray *classNames =  self.topTitles;
    self.topBarControl = [[HMSegmentedControl alloc] initWithSectionTitles:classNames];
    [self.view addSubview:self.topBarControl];
    self.topBarControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 51);
    self.topBarControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    self.topBarControl.isSetHeight=YES;
//    self.topBarControl.selectionIndicatorHeight = 2.0f;
    self.topBarControl.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
    self.topBarControl.textColor = KTextColor;
    self.topBarControl.selectedTextColor = KCOLOR_PROJECT_RED;
//    self.topBarControl.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    
    [self _creatHMSegementController];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 51, kScreenWidth, 0.5)];
    subView.backgroundColor = KLineColor;
    [self.view addSubview:subView];
}


- (void)_creatHMSegementController {
    WEAK_SELF
    self.topBarController = [[HMSegementController alloc] initWithSegementControl:self.topBarControl segementControllerFrame:CGRectMake(0, 50, kScreenWidth,kScreenHeight-50-64) childSegementControllClass:[DLAllEvaluationVC class] childControllersCompletedAddedBlock:^(NSArray *childControllers) {
        [weak_self _assignClassCodeForChildVcs:childControllers];
        
    }];
    self.topBarController.indexChangeBlock = ^(NSInteger index, UIViewController *childVc){
        DLAllEvaluationVC *childVCR = (DLAllEvaluationVC *)childVc;
    };
    
}

- (void)_assignClassCodeForChildVcs:(NSArray *)chilVcs {
    for (NSInteger i=0; i<chilVcs.count; i++) {
        DLAllEvaluationVC *allEvaluationVC = (DLAllEvaluationVC *)chilVcs[i];
        NSString *summaryValue = self.types[i];
        [allEvaluationVC setSummaryValue:summaryValue];
        [allEvaluationVC setSaleProductId:self.saleProductId];
        
        
    }
}



#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_requestAllEvaluationData{
    
    [self showLoadingHub];
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:@{@"saleProductId":self.saleProductId} subUrl:KUrl_GetValuationsSummary block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }

        NSArray *ticketInfoListArr = resultDic[EntityKey];
        weak_self.types=[[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];
        weak_self.topTitles=[[NSMutableArray alloc]initWithCapacity:ticketInfoListArr.count];

        for (int count=0; count<ticketInfoListArr.count; count++) {
            NSNumber *num = [NSNumber numberWithInteger:[[ticketInfoListArr objectAtIndex:count][@"summaryValue"]integerValue]];
            [weak_self.types addObject:num];
            NSString *topTitleName = [NSString stringWithFormat:@"%@\n（%ld）",[ticketInfoListArr objectAtIndex:count][@"summaryName"],[[ticketInfoListArr objectAtIndex:count][@"summaryCount"]integerValue]];
            [weak_self.topTitles addObject:topTitleName];
            
//            NSString *effectiveName = [NSString stringWithFormat:@"%@",[ticketInfoListArr objectAtIndex:count][@"ticketTypeName"]];
//            [weak_self.effectivesName addObject:effectiveName];
        }
        
        
        //        [weak_self _initTopTitleView];
        [weak_self _createSegementControll];
        
        
    }];
    
}


#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
@end

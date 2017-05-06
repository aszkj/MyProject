//
//  DLAllEvaluationVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLAllEvaluationVC.h"
#import <Masonry/Masonry.h>
#import "MycommonTableView.h"
#import "DLEvaluationDetailsCell.h"
#import "DLEvaluationModel.h"
#import "DLEvaluationHeaderView.h"
#import "DLAllEvaluationVC.h"
#import "DLSettingsVC.h"
#import "NSArray+subArrToIndex.h"
#import "Util.h"
#import "GlobleConst.h"
@interface DLAllEvaluationVC ()


@property (strong, nonatomic) IBOutlet MycommonTableView *allEvaluationTableView;
@property (nonatomic,strong)NSArray *evaluationArray;
@end

@implementation DLAllEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    [self _requestAllValuations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------------------Init---------------------------------
- (void)_init{
    
    
    
    WEAK_SELF
    self.allEvaluationTableView.noDataLogicModule.nodataAlertTitle = @"暂无评价";
    self.allEvaluationTableView.noDataLogicModule.nodataAlertImage = @"无评论";
    [self.allEvaluationTableView configurecellNibName:@"DLEvaluationDetailsCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        
        DLEvaluationModel *model  = (DLEvaluationModel *)cellModel;
        DLEvaluationDetailsCell *evaluationCell = (DLEvaluationDetailsCell *)cell;
        
        [evaluationCell setModel:model];
        
        
    }];
 
    
    self.allEvaluationTableView.cellHeightBlock = ^CGFloat(UITableView *tableView,id model){
        DLEvaluationModel *evaluationModel = (DLEvaluationModel *)model;
        
        return evaluationModel.cellTotalHeight;
    };
    
    [self.allEvaluationTableView headerRreshRequestBlock:^{
        [weak_self _requestAllValuations];
    }];
    
    [self.allEvaluationTableView footerRreshRequestBlock:^{
        [weak_self _requestAllValuations];
    }];

    
    
    
}
#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------

- (void)_requestAllValuations{
    
    
    
    
     NSDictionary *requestParam = @{@"summaryValue":self.summaryValue,@"saleProductId":self.saleProductId,kRequestPageNumKey:@(self.allEvaluationTableView.dataLogicModule.requestFromPage), kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
    if (_isLoading==NO) {
        [self showLoadingHub];
    }
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:KUrl_GetValuationsDetails block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        weak_self.isLoading=YES;
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        
        
        
        weak_self.evaluationArray = [DLEvaluationModel ObjectEvaluationModelArr:resultDic[EntityKey][@"list"]];
        [weak_self.allEvaluationTableView configureTableAfterRequestPagingData:self.evaluationArray];

        
    }];
    
    
    
    
}


#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

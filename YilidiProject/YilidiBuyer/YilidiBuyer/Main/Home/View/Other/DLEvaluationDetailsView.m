
//  DLEvaluationDetailsView.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLEvaluationDetailsView.h"
#import "MycommonTableView.h"
#import "DLEvaluationDetailsCell.h"
#import "DLEvaluationModel.h"
#import "DLEvaluationHeaderView.h"
#import "DLEvaluationDetailsVC.h"
#import "DLSettingsVC.h"
#import "NSArray+subArrToIndex.h"
#import "Util.h"

@interface DLEvaluationDetailsView()

@property (strong, nonatomic) IBOutlet MycommonTableView *evaluationTableView;
@property (nonatomic,strong)NSArray *evaluationArray;
@property (nonatomic,weak) DLBuyerBaseController *showInVC;

@end

@implementation DLEvaluationDetailsView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self _init];
//    [self _requestAllValuations];
    
}
#pragma mark ------------------------Init---------------------------------
- (void)_init{


    [self.evaluationTableView configurecellNibName:@"DLEvaluationDetailsCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
       
        DLEvaluationModel *model  = (DLEvaluationModel *)cellModel;
        DLEvaluationDetailsCell *evaluationCell = (DLEvaluationDetailsCell *)cell;
        
        [evaluationCell setModel:model];
      
        
    }];
    
    WEAK_SELF
    self.evaluationTableView.firstSectionHeaderHeight =49;
    [self.evaluationTableView configureFirstSectioHeaderNibName:@"DLEvaluationHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionHeaderView) {
        
        DLEvaluationHeaderView *header = (DLEvaluationHeaderView *)firstSectionHeaderView;
//        header.totalRecordsLabel.text = weak_self.totalRecords;
        MycommonTableView *evaluationTableView = (MycommonTableView *)tableView;
        NSInteger totalCommentCount = evaluationTableView.dataLogicModule.currentDataModelArr.count;
        if (totalCommentCount >= 1) {
            header.totalRecordsLabel.text = weak_self.totalRecords;
        }else {
            header.totalRecordsLabel.text = @"暂无评价";
        }
        header.lookAllCommentLabel.hidden = header.lookAllCommentButton.hidden = totalCommentCount < 1;
        header.EvaluationBtnBlock = ^{
            DLEvaluationDetailsVC *allVC = [[DLEvaluationDetailsVC alloc]init];
            allVC.saleProductId = weak_self.goodsId;
            [weak_self.showInVC navigatePushViewController:allVC animate:YES];
        };
    }];
    
    self.evaluationTableView.cellHeightBlock = ^CGFloat(UITableView *tableView,id model){
        DLEvaluationModel *evaluationModel = (DLEvaluationModel *)model;
        
        return evaluationModel.cellTotalHeight;
    };
    
    
}
#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_requestAllValuations{


    //    [self.showInVC showLoadingHub];
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:@{@"saleProductId":self.goodsId,@"summaryValue":@""} subUrl:KUrl_GetValuationsDetails block:^(NSDictionary *resultDic, NSError *error) {
//        [weak_self.showInVC hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])){
            emptyBlock(self.goodsDetailCommentHeightBlock,48);
            return;
        }

        
        weak_self.totalRecords = [NSString stringWithFormat:@"商品评价（%@）",resultDic[EntityKey][@"totalRecords"]];
    
//    self.evaluationArray = [DLEvaluationModel ObjectEvaluationModelArr:array];
        self.evaluationArray = [DLEvaluationModel ObjectEvaluationModelArr:resultDic[EntityKey][@"list"]];
    
        [self.evaluationTableView configureTableAfterRequestTotalData:self.evaluationArray];
        [self.evaluationTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];

        int index = 0;
        if (self.evaluationArray.count>=1) {
            index=1;
        }
        
        if (self.evaluationArray.count>=2) {
            index=2;
        }
        
        if (index>=1) {
            self.evaluationArray = [self.evaluationArray subArrayToIndex:index];
            
            [weak_self getViewHeightArr:self.evaluationArray andIndex:index];
        }else {
            emptyBlock(self.goodsDetailCommentHeightBlock,48);
        }
        
        
       
    }];
 
    
}


#pragma mark ------------------------Page Navigate---------------------------
- (void)getViewHeightArr:(NSArray *)array andIndex:(int)index{

    
    if (index>=1) {
//        array = [array subArrayToIndex:index];
        NSMutableArray *arr = [NSMutableArray array];
        for (DLEvaluationModel *modelArr in array) {
            
            
            [arr addObject:[NSString stringWithFormat:@"%f",modelArr.cellTotalHeight]];
            
        }
        NSNumber *sum = [arr valueForKeyPath:@"@sum.floatValue"];
        NSLog(@"sumber%@",sum);
        emptyBlock(self.goodsDetailCommentHeightBlock,[sum floatValue]+48);

       
    }
    

}

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (DLBuyerBaseController *)showInVC {
    if (!_showInVC) {
        _showInVC = (DLBuyerBaseController *)[Util currentViewController];
    }
    return _showInVC;
}

- (void)setGoodsId:(NSString *)goodsId {
    _goodsId = goodsId;
    [self _requestAllValuations];
}

@end

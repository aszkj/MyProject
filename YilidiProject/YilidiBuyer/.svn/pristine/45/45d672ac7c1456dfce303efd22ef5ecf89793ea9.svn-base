//
//  DLGetCouponVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGetCouponVC.h"
#import "MycommonTableView.h"
#import "DLCouponsCell.h"
#import "DLGetCouponModel.h"
@interface DLGetCouponVC ()

@property (weak, nonatomic) IBOutlet MycommonTableView *getCouponTableView;
@property (nonatomic,strong) NSArray *sourceArr;
@end

@implementation DLGetCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self _initLoadGetCouponTableView];
    [self _requestGoodsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark ------------------------Init---------------------------------

- (void)_initLoadGetCouponTableView {

    self.pageTitle = @"领券";
    _getCouponTableView.cellHeight = 110.0f;
    [self.getCouponTableView configurecellNibName:@"DLCouponsCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        DLGetCouponModel *coupoModel = [[DLGetCouponModel alloc]initWithDefaultDataDic:cellModel];
        DLCouponsCell *couponsCell = (DLCouponsCell *)cell;
        [couponsCell setCellModel:coupoModel];
        
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        DLGetCouponModel *coupoModel = [[DLGetCouponModel alloc]initWithDefaultDataDic:cellModel];;
       
        [self _requestReceiveData:[NSNumber numberWithInt:coupoModel.couponId]];
    }];
    

}

#pragma mark ------------------------Private-------------------------

- (void)_requestGoodsData{
  
        [self.getCouponTableView configureTableAfterRequestData:_sourceArr];
}

- (void)_requestReceiveData:(NSNumber *)couponID{
    
}
#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end

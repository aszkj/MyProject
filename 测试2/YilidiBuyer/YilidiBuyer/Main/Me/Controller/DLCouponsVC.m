//
//  DLCouponsVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/10/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLCouponsVC.h"
#import "MycommonTableView.h"
#import "DLMyWalletCell.h"
#import "DLVouchersModel.h"
#import "GlobleConst.h"

@interface DLCouponsVC ()
@property (strong, nonatomic) IBOutlet MycommonTableView *couponsTableView;
@property (strong, nonatomic) IBOutlet UIButton *effectiveBtn;
@property (strong, nonatomic) IBOutlet UIButton *invalidBtn;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic,strong)NSString *isCoupons;
@property (nonatomic,strong)NSString *couponesName;

@end

@implementation DLCouponsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
    
}

#pragma mark ------------------------Init---------------------------------
-(void)_init{
    self.couponesName = [self.ticketTitles objectAtIndex:self.ticketType.integerValue-1];
    [self.effectiveBtn setTitle:[NSString stringWithFormat:@"有效%@",self.couponesName]forState:UIControlStateNormal];
    [self.invalidBtn setTitle:[NSString stringWithFormat:@"无效%@",self.couponesName] forState:UIControlStateNormal];
    

    [self _changeColor];
    [self _initLoadTableView];
    [self _getWalletData];
    

}
//按钮颜色切换
- (void)_changeColor{

    if (_effectiveBtn.selected==YES) {
        
        switch ([self.ticketType integerValue]) {
            case 1:
                self.isCoupons = @"couponsEffective";
                [_effectiveBtn setTitleColor:UIColorFromRGB(0xff3a30) forState:UIControlStateNormal];
                [_invalidBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                _lineView.backgroundColor=UIColorFromRGB(0xff3a30);
                break;
            case 2:
                self.isCoupons = @"vouchersEffective";
                [_effectiveBtn setTitleColor:UIColorFromRGB(0x299ef1) forState:UIControlStateNormal];
                [_invalidBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                _lineView.backgroundColor=UIColorFromRGB(0x299ef1);
                break;
            case 3:
                self.isCoupons = @"pikEffective";
                [_effectiveBtn setTitleColor:UIColorFromRGB(0x21B11E) forState:UIControlStateNormal];
                [_invalidBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                _lineView.backgroundColor=UIColorFromRGB(0x21B11E);
                break;
            default:
                self.isCoupons = @"couponsEffective";
                [_effectiveBtn setTitleColor:UIColorFromRGB(0xff3a30) forState:UIControlStateNormal];
                [_invalidBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                _lineView.backgroundColor=UIColorFromRGB(0xff3a30);
                break;
        }

        
    }else{
    
        switch ([self.ticketType integerValue]) {
            case 1:
                
                [_invalidBtn setTitleColor:UIColorFromRGB(0xff3a30) forState:UIControlStateNormal];
                [_effectiveBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                break;
            case 2:
                
                [_invalidBtn setTitleColor:UIColorFromRGB(0x299ef1) forState:UIControlStateNormal];
                [_effectiveBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                break;
            case 3:
                
                [_invalidBtn setTitleColor:UIColorFromRGB(0x21B11E) forState:UIControlStateNormal];
                [_effectiveBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                break;
            default:
                [_invalidBtn setTitleColor:UIColorFromRGB(0xff3a30) forState:UIControlStateNormal];
                [_effectiveBtn setTitleColor:UIColorFromRGB(0x8b8b8b) forState:UIControlStateNormal];
                break;
        }

    }
   
}
- (void)_initLoadTableView{
    
    self.couponsTableView.cellHeight = 105.0f;
    switch ([self.ticketType integerValue]) {
            case 1:
            self.couponsTableView.nodataAlertTitle =[NSString stringWithFormat:@"你还没有%@哦~",self.couponesName];
            self.couponsTableView.nodataAlertImage = [NSString stringWithFormat:@"没有%@",self.couponesName];
            break;
            case 2:
            self.couponsTableView.nodataAlertTitle =[NSString stringWithFormat:@"你还没有%@哦~",self.couponesName];
            self.couponsTableView.nodataAlertImage = [NSString stringWithFormat:@"没有%@",self.couponesName];
                break;
            case 3:
            self.couponsTableView.nodataAlertTitle =[NSString stringWithFormat:@"你还没有%@哦~",self.couponesName];
            self.couponsTableView.nodataAlertImage = [NSString stringWithFormat:@"没有%@",self.couponesName];
                break;
        default:
            self.couponsTableView.nodataAlertTitle = @"你还没有优惠券哦~";
            self.couponsTableView.nodataAlertImage = @"没有优惠券";
            break;
            
    }
    
    WEAK_SELF
    [self.couponsTableView configurecellNibName:@"DLMyWalletCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLVouchersModel *vouchers = (DLVouchersModel *)cellModel;
        DLMyWalletCell *walletCell = (DLMyWalletCell *)cell;
        
        
        
        [walletCell setModel:vouchers];
        
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
      
    }];
    [self.couponsTableView headerRreshRequestBlock:^{
        [weak_self _getWalletData];
    }];
    
    [self.couponsTableView footerRreshRequestBlock:^{
        [weak_self _getWalletData];
    }];

    
  
    
}
#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_getWalletData{
    
    [self showLoadingHub];
    
    NSNumber *ticketStatus;
    if ([self.isCoupons isEqualToString:@"couponsEffective"]||[self.isCoupons isEqualToString:@"vouchersEffective"]||[self.isCoupons isEqualToString:@"pikEffective"]) {
        ticketStatus = @1;
        
    }else{
        ticketStatus = @0;
        
    }


    
    NSDictionary *requestParam = @{@"ticketType":self.ticketType,@"ticketStatus":ticketStatus,kRequestPageNumKey:@(self.couponsTableView.dataLogicModule.requestFromPage), kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GetUserticktInfo block:^(NSDictionary *resultDic, NSError *error) {
            [weak_self hideLoadingHub];
        
            if (isEmpty(resultDic[EntityKey])) {
                return ;
            }
        NSArray *resultArr;
        if (isEmpty(resultDic[EntityKey][@"list"])) {
            resultArr = nil;
        }else{
            resultArr = resultDic[EntityKey][@"list"];
        }
        
            NSArray *transferedArr = [DLVouchersModel objectVouchersModelWithArr:resultArr isValidity:self.isCoupons];
            [weak_self.couponsTableView configureTableAfterRequestData:transferedArr];
            [weak_self.couponsTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];

        
    }];
    
    [self.couponsTableView reloadData];
    
}

#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------
- (IBAction)effectiveClick:(id)sender {
    _effectiveBtn.selected=YES;
    _invalidBtn.selected=NO;
   [self _changeColor];
    self.couponsTableView.dataLogicModule.requestFromPage = 1;
    [self _getWalletData];
    
}

- (IBAction)invalidClick:(id)sender {
    _effectiveBtn.selected=NO;
    _invalidBtn.selected=YES;
    [self _changeColor];
    self.isCoupons = @"invalid";
     self.couponsTableView.dataLogicModule.requestFromPage = 1;
    [self _getWalletData];
    
}

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------


@end

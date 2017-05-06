//
//  DLRefundDetailsVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/3/20.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLRefundDetailsVC.h"
#import "DLRefundDetailsCell.h"
#import "DLRefundDetailsHeader.h"
#import "DLStatusFooterView.h"
#import "DLRefundFailureCell.h"
#import "DLInvoiceStatusModel.h"
#import "NSObject+setModelIndexPath.h"
@interface DLRefundDetailsVC ()
@property(nonatomic,strong)DLRefundDetailsHeader *headerView;
@property(nonatomic,strong)DLStatusFooterView *footerView;
//@property (nonatomic,strong)DLRefundDetailsCell *statusCell;
@property (nonatomic,strong)NSNumber *statusCode;

@property (nonatomic,strong)NSArray *statusArr;
@end

@implementation DLRefundDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"退款详情";
    
    [self.refundDetailsTable registerNib:[UINib nibWithNibName:@"DLRefundDetailsCell" bundle:nil] forCellReuseIdentifier:@"DLRefundDetailsCell"];
    
    [self.refundDetailsTable registerNib:[UINib nibWithNibName:@"DLRefundFailureCell" bundle:nil] forCellReuseIdentifier:@"DLRefundFailureCell"];
    [self _requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ------------------------Init---------------------------------

#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    
    WEAK_SELF
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:@{@"saleOrderNo":self.saleOrderNo} subUrl:kUrl_GetRefundinfo block:^(NSDictionary *resultDic, NSError *error) {
        [weak_self hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        _headerView.refundMoney.text = [NSString stringWithFormat:@"￥%.2f",[resultDic[EntityKey][@"refundAmount"] floatValue]/1000];
        _headerView.refundState.text = resultDic[EntityKey][@"statusCodeName"];
        _headerView.refundReason.text = resultDic[EntityKey][@"reason"];
        _headerView.refundNum.text = resultDic[EntityKey][@"saleOrderNo"];
        _headerView.payType.text = resultDic[EntityKey][@"payTypeName"];
        _headerView.refundType.text = resultDic[EntityKey][@"refundTypeName"];
        self.statusCode = resultDic[EntityKey][@"statusCode"];
        NSArray *statusOrderArr = resultDic[EntityKey][@"refundStatusList"];
        _statusArr = [DLInvoiceStatusModel objectGoodsModelWithGoodsArr:statusOrderArr];
//        [_statusArr setIndexPathInselfContainer];
        
        NSLog(@"%ld",_statusArr.count);
        [self.refundDetailsTable reloadData];
    }];
    
    
}




#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 182;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return  self.headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 80.0f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [_statusArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    

    if ([self.statusCode integerValue]==10) {
        
        if (indexPath.row==[_statusArr count]-1) {
            return 96.0f;
        }else{
            
            return 63.0f;
        }
    }else{
    
       return  63.0f;
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return self.footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DLInvoiceStatusModel *model = _statusArr[indexPath.row];
    
        //当前状态--退款失败，替换最后一个cell
        if ([model.statusCode integerValue]==10) {
            if (indexPath.row==[_statusArr count]-1) {
                DLRefundFailureCell *failureCell = [self.refundDetailsTable dequeueReusableCellWithIdentifier:@"DLRefundFailureCell" forIndexPath:indexPath];
                
                [failureCell setModel:model];
                return failureCell;
                
            }else{
                
                DLRefundDetailsCell *statusCell = [self.refundDetailsTable dequeueReusableCellWithIdentifier:@"DLRefundDetailsCell" forIndexPath:indexPath];
                
                if(indexPath.row==0){
                    statusCell.lineView.hidden=YES;
                }
                [statusCell setModel:model];
                return statusCell;
                
            }

        }else{
            
            
            DLRefundDetailsCell *statusCell = [self.refundDetailsTable dequeueReusableCellWithIdentifier:@"DLRefundDetailsCell" forIndexPath:indexPath];
            
            if(indexPath.row==0){
                statusCell.lineView.hidden=YES;
            }else if (indexPath.row==[_statusArr count]-1) {
                statusCell.lineViewTwo.hidden=YES;
            }else{
                statusCell.lineViewTwo.hidden=NO;
            }
            
            if (indexPath.row==[_statusArr count]-1) {
                
//                statusCell.orderStatus.textColor = KCOLOR_PROJECT_BLUE;
//                statusCell.orderTime.textColor =KCOLOR_PROJECT_BLUE ;
                statusCell.circleButton.selected=YES;
                
                statusCell.statusBjView.layer.borderColor = KCOLOR_PROJECT_BLUE.CGColor;
            }else{
                
//                statusCell.orderStatus.textColor  = KWeakTextColor;
//                statusCell.orderTime.textColor  = KWeakTextColor;
                statusCell.circleButton.selected=NO;
                statusCell.statusBjView.layer.borderColor = KCOLOR_SEPERATE_LINE.CGColor;
                
            }
            
            [statusCell setModel:model];
            return statusCell;
    
            
        }
    
}

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (DLRefundDetailsHeader *)headerView{

    if (!_headerView) {
        _headerView = BoundNibView(@"DLRefundDetailsHeader", DLRefundDetailsHeader);
        
    }
    
    return _headerView;
}

- (DLStatusFooterView *)footerView {
    
    if (!_footerView) {
        _footerView = BoundNibView(@"DLStatusFooterView", DLStatusFooterView);
        
        
    }
    return _footerView;
}
@end

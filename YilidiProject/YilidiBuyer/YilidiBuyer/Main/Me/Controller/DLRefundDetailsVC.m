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
@interface DLRefundDetailsVC ()
@property(nonatomic,strong)DLRefundDetailsHeader *headerView;
@property(nonatomic,strong)DLStatusFooterView *footerView;
//@property (nonatomic,strong)DLRefundDetailsCell *statusCell;
@property (nonatomic,assign)BOOL bbbb;
@property (nonatomic,strong)NSArray *detailArr;
@end

@implementation DLRefundDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"退款详情";
             _bbbb=YES;
    [self.refundDetailsTable registerNib:[UINib nibWithNibName:@"DLRefundDetailsCell" bundle:nil] forCellReuseIdentifier:@"DLRefundDetailsCell"];
    
    [self.refundDetailsTable registerNib:[UINib nibWithNibName:@"DLRefundFailureCell" bundle:nil] forCellReuseIdentifier:@"DLRefundFailureCell"];
//    [self _requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark ------------------------Init---------------------------------

#pragma mark ------------------------Private-------------------------

#pragma mark ------------------------Api----------------------------------
- (void)_requestData{
    
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:@{@"msgId":self.msgId} subUrl:kUrl_GetMessageDetails block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return;
        }
        
//        detailArr
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
    
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_bbbb==YES) {
        
        if (indexPath.row==4) {
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
    

        //当前状态--退款失败，替换最后一个cell
        if (_bbbb==YES) {
            if (indexPath.row==4) {
                DLRefundFailureCell *failureCell = [self.refundDetailsTable dequeueReusableCellWithIdentifier:@"DLRefundFailureCell" forIndexPath:indexPath];
                
                return failureCell;
                
            }else{
                
                DLRefundDetailsCell *statusCell = [self.refundDetailsTable dequeueReusableCellWithIdentifier:@"DLRefundDetailsCell" forIndexPath:indexPath];
                
                if(indexPath.row==0){
                    statusCell.lineView.hidden=YES;
                }
                
                return statusCell;
                
            }

        }else{
            
            
            DLRefundDetailsCell *statusCell = [self.refundDetailsTable dequeueReusableCellWithIdentifier:@"DLRefundDetailsCell" forIndexPath:indexPath];
            
            if(indexPath.row==0){
                statusCell.lineView.hidden=YES;
            }else if (indexPath.row==4) {
                statusCell.lineViewTwo.hidden=YES;
            }else{
                statusCell.lineViewTwo.hidden=NO;
            }
            
            if (indexPath.row==4) {
                
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

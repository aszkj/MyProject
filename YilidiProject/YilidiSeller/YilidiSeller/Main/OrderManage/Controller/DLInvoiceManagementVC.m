//
//  DLInvoiceManagementVC.m
//  YilidiSeller
//
//  Created by yld on 16/5/31.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvoiceManagementVC.h"
#import "MycommonTableView.h"
#import "DLInvoiceCell.h"
#import "DLInvoiceDetailsVC.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLInvoiceListModel.h"
@interface DLInvoiceManagementVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *invoiceTableView;
@property (nonatomic,strong)NSArray *sourceArr;
@end

@implementation DLInvoiceManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initInvoiceTableView];
    self.pageTitle = @"调货单管理";
    [self _requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
- (void)_initInvoiceTableView {
    
    NSArray *listArr = @[@{@"allotOrderNo":@"202312120221",@"createTime":@"2015-05-05 08:45:44",@"consignee":@"张三",@"consMobile":@"18865848458",@"consAddress":@"深圳市南山区白石洲地铁站aaaaa",@"allotTotalCount":@15,@"allotTotalAmount":@15,@"statusCodeName":@"已发货"},@{@"allotOrderNo":@"202312120",@"createTime":@"2015-05-05 02:02:57",@"consignee":@"张三",@"consMobile":@"18865848458",@"consAddress":@"深圳市南山区白石洲地铁站bbbb",@"allotTotalCount":@14,@"allotTotalAmount":@145,@"statusCodeName":@"已发货"},@{@"allotOrderNo":@"202312120",@"createTime":@"2015-05-05 02:58:87",@"consignee":@"张三",@"consMobile":@"18865848458",@"consAddress":@"深圳市南山区白石洲地铁站",@"allotTotalCount":@18,@"allotTotalAmount":@145,@"statusCodeName":@"未发货"}];
    
    _sourceArr =  [[DLInvoiceListModel  objectInvoiceListModelArray:listArr]mutableCopy];
    
    self.invoiceTableView.cellHeight = 156.0f;
    [self.invoiceTableView configurecellNibName:@"DLInvoiceCell" cellDataSource:_sourceArr configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
         DLInvoiceListModel *model = (DLInvoiceListModel *)cellModel;
        DLInvoiceCell *invoiceCell = (DLInvoiceCell *)cell;
        [invoiceCell setModel:model];
        
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        DLInvoiceListModel *model = (DLInvoiceListModel *)cellModel;
        DLInvoiceDetailsVC *orderVC= [[DLInvoiceDetailsVC alloc]init];
        orderVC.orderNo = model.allotOrderNo;
        [self navigatePushViewController:orderVC animate:YES];
         [tableView deselectRowAtIndexPath:clickIndexPath animated:YES];
        
    }];
}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData {

    
    
//    NSDictionary * dic =@{@"whetherComplete":@1};
//    [AFNHttpRequestOPManager getInfoWithSubUrl:kUrl_InvoiceList parameters:dic block:^(id result, NSError *error) {
    
//         [self.invoiceTableView configureTableAfterRequestData:_sourceArr];
        
//    }];
    
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------



@end

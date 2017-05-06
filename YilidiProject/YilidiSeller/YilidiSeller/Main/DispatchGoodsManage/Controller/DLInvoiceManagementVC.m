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
#import "DLRequestUrl.h"
#import "GlobleConst.h"
#import "NSObject+setModelIndexPath.h"
#import "DLNoOrderDataView.h"
@interface DLInvoiceManagementVC ()
@property (weak, nonatomic) IBOutlet MycommonTableView *invoiceTableView;

@property (strong, nonatomic) IBOutlet UIButton *ongoingButton;


@property (strong, nonatomic) IBOutlet UIButton *completeButton;
@property (nonatomic,strong)DLNoOrderDataView *noOrderDataView;
@property (nonatomic,strong)NSNumber *whetherComplete;
@property (nonatomic,strong)NSArray *sourceArr;
@property (nonatomic, assign)NSInteger requestFromPage;
@end

@implementation DLInvoiceManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _initInvoiceTableView];
    [self _requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
//    [self _requestData];
}

#pragma mark ------------------------Init---------------------------------
- (void)_init {
    self.pageTitle = @"调货单管理";
    self.whetherComplete=@0;
    self.requestFromPage = 1;
}
- (void)_initInvoiceTableView {
    

//    NSArray *listArr = @[@{@"allotOrderNo":@"202312120221",@"createTime":@"2015-05-05 08:45:44",@"consignee":@"张三",@"consMobile":@"18865848458",@"consAddress":@"深圳市南山区白石洲地铁站aaaaa",@"allotTotalCount":@15,@"allotTotalAmount":@15,@"statusCodeName":@"已发货"},@{@"allotOrderNo":@"202312120",@"createTime":@"2015-05-05 02:02:57",@"consignee":@"张三",@"consMobile":@"18865848458",@"consAddress":@"深圳市南山区白石洲地铁站bbbb",@"allotTotalCount":@14,@"allotTotalAmount":@145,@"statusCodeName":@"已发货"},@{@"allotOrderNo":@"202312120",@"createTime":@"2015-05-05 02:58:87",@"consignee":@"张三",@"consMobile":@"18865848458",@"consAddress":@"深圳市南山区白石洲地铁站",@"allotTotalCount":@18,@"allotTotalAmount":@145,@"statusCodeName":@"未发货"}];


    
    self.invoiceTableView.cellHeight = 156.0f;
    [self.invoiceTableView configurecellNibName:@"DLInvoiceCell" cellDataSource:_sourceArr configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
         DLInvoiceListModel *model = (DLInvoiceListModel *)cellModel;
        DLInvoiceCell *invoiceCell = (DLInvoiceCell *)cell;
        [invoiceCell setModel:model invoiceStatus:[self.whetherComplete integerValue]];
        
     
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        DLInvoiceListModel *model = (DLInvoiceListModel *)cellModel;
        DLInvoiceDetailsVC *orderVC= [[DLInvoiceDetailsVC alloc]init];
        orderVC.orderNo = model.allotOrderNo;
        [self navigatePushViewController:orderVC animate:YES];
         [tableView deselectRowAtIndexPath:clickIndexPath animated:YES];
        
    }];
    
    WEAK_SELF
    [self.invoiceTableView headerRreshRequestBlock:^{
        self.requestFromPage = 1;
        [weak_self _requestData];
    }];
    
    [self.invoiceTableView footerRreshRequestBlock:^{
        [weak_self _requestData];
    }];
}
#pragma mark ------------------------Private-------------------------


#pragma mark ------------------------Api----------------------------------
- (void)_requestData {

    
    
    self.invoiceTableView.dataLogicModule.requestFromPage = self.requestFromPage;
    NSDictionary *paramDic = @{kRequestPageNumKey:@(self.requestFromPage),
                               kRequestPageSizeKey:@(kRequestDefaultPageSize),
                               @"whetherComplete":self.whetherComplete};
    NSLog(@"dic%@",paramDic);
    [AFNHttpRequestOPManager postWithParameters:paramDic subUrl:kUrl_InvoiceList block:^(NSDictionary *resultDic, NSError *error) {
        NSLog(@"%@",resultDic);
        
        if (isEmpty(resultDic[EntityKey])) {
            
            return;
        }
        
        
        _sourceArr =  [[DLInvoiceListModel  objectInvoiceListModelArray:resultDic[EntityKey][@"list"]]mutableCopy];
        
        [self.invoiceTableView configureTableAfterRequestPagingData:_sourceArr];
//        [self.invoiceTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
//        //没有数据
//        if (self.invoiceTableView.dataLogicModule.currentDataModelArr.count==0) {
//            
//            self.invoiceTableView.hidden=YES;
//            self.noOrderDataView.hidden=NO;
//            [self.view  addSubview:self.noOrderDataView];
//        }else{
//            self.invoiceTableView.hidden=NO;
//            self.noOrderDataView.hidden=YES;
//        }
        [self.invoiceTableView reloadData];
        self.requestFromPage  = self.invoiceTableView.dataLogicModule.requestFromPage;

    }];
    
  
    
}
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

- (IBAction)ongoingButtonClick:(UIButton *)sender {
    _ongoingButton.selected = !_ongoingButton.selected;
    if (_ongoingButton.selected) {
        _whetherComplete = @0;
        self.requestFromPage = 1;
        self.invoiceTableView.dataLogicModule.requestFromPage =self.requestFromPage;
        [self _requestData];
        _ongoingButton.backgroundColor = UIColorFromRGB(0xF7D809);
        _completeButton.backgroundColor = [UIColor whiteColor];
        _completeButton.selected = NO;
    }
    
}


- (IBAction)completeButtonClick:(id)sender {
    _completeButton.selected = !_completeButton.selected;
    if (_completeButton.selected) {
        _whetherComplete =@1;
        self.requestFromPage = 1;
        self.invoiceTableView.dataLogicModule.requestFromPage =self.requestFromPage;
        [self _requestData];
        _completeButton.backgroundColor = UIColorFromRGB(0xF7D809);
        _ongoingButton.backgroundColor = [UIColor whiteColor];
        _ongoingButton.selected = NO;
    }
    
}



#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (DLNoOrderDataView *)noOrderDataView {
    
    if (!_noOrderDataView) {
        _noOrderDataView = BoundNibView(@"DLNoOrderDataView", DLNoOrderDataView);
        _noOrderDataView.center=self.view.center;
    }
    
    return _noOrderDataView;
}


@end

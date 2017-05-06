//
//  DLOrderStatusVCViewController.m
//  YilidiBuyer
//
//  Created by yld on 16/5/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLInvoiceDetailsVC.h"
#import "HMSegmentedControl.h"
#import "MycommonTableView.h"
#import "DLInvoiceStatusCell.h"
#import "DLInvoiceDetaiCell.h"
#import "DLInvoiceHeaderView.h"
#import "DLInvoiceDetaiFooterView.h"
#import "DLInvitationOrdetailsModel.h"
#import "NSArray+SUIAdditions.h"
#import "ProjectRelativEmerator.h"
#import "DLInvoiceStatusModel.h"
#import "NSObject+setModelIndexPath.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLStatusFooterView.h"
#import "DLRequestUrl.h"
#import "DLOrderDetailsBottomView.h"
#import "GlobleConst.h"
#import "DLInspectionStatusHeader.h"

@interface DLInvoiceDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    DLInvoiceDetaiCell *invoiceCell;
    BOOL isHidden;
    BOOL isReceiveHidden;
    
}
@property (nonatomic,assign)ButtonStatus buttonStatus;
@property (nonatomic,strong)UIButton *btnOrder;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *topSegmentedView;
@property (weak, nonatomic) IBOutlet MycommonTableView *statusTableView;
@property (nonatomic,strong)DLInvoiceDetaiFooterView *detailsFooterView;
@property (nonatomic,strong)DLInvoiceHeaderView *detailsHeadView;
@property (nonatomic,strong)DLInspectionStatusHeader *inspectionHeadView;
@property (nonatomic,strong)DLStatusFooterView     *statusFooterView;
@property (nonatomic,strong)DLOrderDetailsBottomView *bottomView;
@property (nonatomic,strong)UITableView *orderDetaiTableView;
@property (nonatomic,strong)NSArray *statusArr;
@property (nonatomic,strong)NSMutableArray *invitationArr;
@property (nonatomic,strong)UIButton*rightButton;



@end

@implementation DLInvoiceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _requestData];
    [self _initItem];
    [self _statusTableView];
    [self _orderTableView];
    [self _initSegmented];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark ------------------------Init---------------------------------

-(void)_initSegmented {
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"调货单记录",@"调货单详情"];
    self.topSegmentedView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topSegmentedView.selectionIndicatorHeight = 2.0f;
    self.topSegmentedView.font = kSystemFontSize(14);
    self.topSegmentedView.sectionTitles = topBarTitles;
    self.topSegmentedView.textColor = kGetColor(136, 135, 136);
    self.topSegmentedView.selectedTextColor = UIColorFromRGB(0xff6600);
    self.topSegmentedView.selectionIndicatorColor = UIColorFromRGB(0xff6600);
    self.topSegmentedView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.topSegmentedView.selectedSegmentIndex = 1;
    
    WEAK_SELF
    self.topSegmentedView.indexChangeBlock = ^(NSInteger index){
        if (index ==0) {
            weak_self.orderDetaiTableView.hidden = YES;
            weak_self.statusTableView.hidden = NO;
            weak_self.bottomView.hidden=YES;
        }else{
            weak_self.orderDetaiTableView.hidden = NO;
            weak_self.statusTableView.hidden = YES;
            weak_self.bottomView.hidden=NO;
        }
        
    };
    
}



- (void)_initItem {
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(0, 0, 60, 20);
    _rightButton.hidden=YES;
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _rightButton.layer.cornerRadius = 2;
    [_rightButton setTitle:@"开始验货" forState:UIControlStateNormal];
    [_rightButton setBackgroundColor:UIColorFromRGB(0xf7d809)];
    [_rightButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    _buttonStatus = ButtonAvailableNotStatus;
    [_rightButton addTarget:self action:@selector(_rightItemClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
}
#pragma mark ------------------------Private-------------------------

- (void)_rightItemClick:(UIButton *)btn {
    
    btn.hidden=YES;
    
    [self _invoiceInspection];
    
    

//    if (_buttonStatus == ButtonAvailableNotStatus) {
//        _buttonStatus = ButtonAvailableStatus;
//        [btn setTitle:@"验货完毕" forState:UIControlStateNormal];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"InvitationNotification" object:@(YES)];
//        
//    }else{
//        _buttonStatus = ButtonAvailableNotStatus;
//        [btn setTitle:@"开始验货" forState:UIControlStateNormal];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"InvitationNotification" object:@(NO)];
//        
////
//    }
//        [_orderDetaiTableView reloadData];
}

- (void)_statusTableView{
    
    self.statusTableView.cellHeight = 75.0f;
    [_statusArr setIndexPathInselfContainer];
    [self.statusTableView configurecellNibName:@"DLInvoiceStatusCell" cellDataSource:_statusArr configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        DLInvoiceStatusModel *model = (DLInvoiceStatusModel *)cellModel;
        DLInvoiceStatusCell *statusCell = (DLInvoiceStatusCell *)cell;
        [statusCell setModel:model];
        
        
        if (model.modelAtIndexPath.row==0) {
            statusCell.orderStatus.textColor = UIColorFromRGB(0x299ef1);
            statusCell.lineView.hidden=YES;
            statusCell.circleButton.selected=YES;
        }else{
            statusCell.orderStatus.textColor  = UIColorFromRGB(0x8b8b8b);
            statusCell.lineView.hidden=NO;
            statusCell.circleButton.selected=NO;
        }
        
        if (model.modelAtIndexPath.row==[_statusArr count]-1) {
            statusCell.lineViewTwo.hidden=YES;
        }else{
            statusCell.lineViewTwo.hidden=NO;
            
        }

        
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    self.statusTableView.hidden=YES;
    self.statusTableView.tableFooterView = self.statusFooterView;
}

- (void)_orderTableView {
    
    self.orderDetaiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 42, kScreenWidth, kScreenHeight-64-42) style:UITableViewStyleGrouped];
    self.orderDetaiTableView.delegate = self;
    self.orderDetaiTableView.dataSource = self;
    self.pageTitle = @"调货单详情";
    [self.orderDetaiTableView registerNib:[UINib nibWithNibName:@"DLInvoiceDetaiCell" bundle:nil] forCellReuseIdentifier:@"DLInvoiceDetaiCell"];
    self.orderDetaiTableView.separatorStyle= NO;
    self.orderDetaiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderDetaiTableView.showsVerticalScrollIndicator =
    NO;
    
    [self.view addSubview:self.orderDetaiTableView];
    
}


#pragma mark ------------------------Api----------------------------------
- (void)_requestData {
    [self showLoadingHub];
    NSDictionary *dic = @{@"allotOrderNo":self.orderNo};
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_InvoiceOrdertails block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        NSLog(@"%@",resultDic);
        //调货单状态数据
        _statusArr = [DLInvoiceStatusModel objectGoodsModelWithGoodsArr:resultDic[@"entity"][@"allotStatusList"]];
        self.statusTableView.dataLogicModule.currentDataModelArr = [_statusArr mutableCopy];
        [self.statusTableView.dataLogicModule.currentDataModelArr setIndexPathInselfContainer];
        
        //调货单详情
        [self _parsingData:resultDic[@"entity"]];
        
        [self.statusTableView reloadData];
        [self.orderDetaiTableView reloadData];
    }];
   
}



//调货单详情数据
- (void)_parsingData:(NSDictionary*)dic {
    
    //验货状态才需要编辑数量
    if ([dic[@"statusCode"] integerValue]==SubmitStatus ||[dic[@"statusCode"] integerValue]==AuditStatus ||[dic[@"statusCode"]integerValue]==AuditNotThroughStatus){
        isReceiveHidden=YES;
        self.orderDetaiTableView.tableHeaderView = self.inspectionHeadView;
        self.orderDetaiTableView.tableFooterView = self.detailsFooterView;
    }else if ([dic[@"statusCode"] integerValue]==DeliveryStatus) {
    
        _rightButton.hidden=NO;
        isReceiveHidden=YES;
        self.orderDetaiTableView.tableFooterView = self.detailsFooterView;
        self.orderDetaiTableView.tableHeaderView = self.inspectionHeadView;

    }else if ([dic[@"statusCode"] integerValue]==InspectionStatus) {
        isHidden=YES;
        _rightButton.hidden=YES;
        self.orderDetaiTableView.tableHeaderView = self.inspectionHeadView;
        self.orderDetaiTableView.tableFooterView = self.detailsFooterView;
        [self.view  addSubview:self.bottomView];
        
        [self.orderDetaiTableView reloadData];
    }else{
        _rightButton.hidden=YES;
        isHidden=NO;
        isReceiveHidden =NO;
        self.orderDetaiTableView.tableHeaderView = self.detailsHeadView;
        self.orderDetaiTableView.tableFooterView.hidden=YES;
        self.bottomView.hidden=YES;
        [self.bottomView removeFromSuperview];
        [self.orderDetaiTableView reloadData];
        
    }
    
    //调拨数据
    _detailsHeadView.orderNumber.text = dic[@"allotOrderNo"];
    _detailsHeadView.outWarehouse.text = dic[@"allotToStoreName"];
    _detailsHeadView.entranceWarehouse.text = dic[@"allotFromStoreName"];
    _detailsHeadView.createTime.text = dic[@"createTime"];
    _detailsHeadView.invioceCount.text = [NSString stringWithFormat:@"%@",dic[@"allotTotalCount"]];
    _detailsHeadView.realAllotCount.text = [NSString stringWithFormat:@"%@",dic[@"realAllotTotalCount"]];
    
    _inspectionHeadView.orderNumber.text = dic[@"allotOrderNo"];
    _inspectionHeadView.outWarehouse.text = dic[@"allotToStoreName"];
    _inspectionHeadView.entranceWarehouse.text = dic[@"allotFromStoreName"];
    _inspectionHeadView.createTime.text = dic[@"createTime"];
    
    
    //商品信息数据
    _invitationArr = (NSMutableArray *) [DLInvitationOrdetailsModel objectWithInvitationModelArr:dic[@"allotOrderItemList"]isInspectionHidden:isHidden isReceiveHidden:isReceiveHidden];
    
    //计算申请调入商品数
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (DLInvitationOrdetailsModel *model in _invitationArr) {
        
        [array addObject:[NSString stringWithFormat:@"%d",(int)model.allotCount]];
    }
    NSNumber *sum = [array valueForKeyPath:@"@sum.floatValue"];
    _detailsFooterView.actualNumber.text = _detailsFooterView.applyNumber.text = [sum stringValue];
    [self.orderDetaiTableView reloadData];

}


- (void)_invoiceInspection{

    
    [self showLoadingHub];
    NSDictionary *dic = @{@"allotOrderNo":self.orderNo};
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_InvoiceInspection block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        NSLog(@"%@",resultDic);
        //点击开始验货在实时请求下数据
        self.orderNo = resultDic[EntityKey][@"allotOrderNo"];
        if ([resultDic[EntityKey][@"statusCode"]integerValue]==InspectionStatus) {

            [[NSNotificationCenter defaultCenter]postNotificationName:@"InvitationNotification" object:@(YES)];

            [self _requestData];

            
        }
        
    }];

    
}


- (void)_submitData {
    

    NSMutableArray *editorData = [[NSMutableArray alloc]init];
    for (DLInvitationOrdetailsModel *model in self.invitationArr) {
        [editorData addObject:@{@"saleProductId":[NSString stringWithFormat:@"%ld",(long)model.saleProductId],@"allotNum":[NSString stringWithFormat:@"%ld",(long)model.allotCount]}];
    }
    NSLog(@"editorData:%@",editorData);
    
    [self showLoadingHub];
    NSDictionary *dic = @{@"allotInfo":editorData,@"allotOrderNo":self.orderNo};
    [AFNHttpRequestOPManager postWithParameters:dic subUrl:kUrl_InvoiceSubmit block:^(NSDictionary *resultDic, NSError *error) {
        
        if (error.code==1) {
            NSLog(@"resultDic:%@",resultDic);
             [self hideHubForText:@"验货成功"];
            self.orderNo = resultDic[EntityKey][@"allotOrderNo"];
            [self _requestData];
           
        }else{
        
            [self hideLoadingHub];
        }
        
    }];
    
 
    
  
    
}
#pragma mark ------------------------Page Navigate---------------------------
- (void)goBack {
    if (_isManagementVC ==YES) {
    
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
   
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------




#pragma -- mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _invitationArr.count;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    invoiceCell = [self.orderDetaiTableView dequeueReusableCellWithIdentifier:@"DLInvoiceDetaiCell" forIndexPath:indexPath];
    if (!invoiceCell) {
        invoiceCell  = [[DLInvoiceDetaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DLInvoiceDetaiCell"];
    }
 
    [invoiceCell setModel:_invitationArr[indexPath.row]];
   
    
    WEAK_SELF
    invoiceCell.invitationBlock = ^(DLInvitationOrdetailsModel *model){
        
        [weak_self.invitationArr replaceObjectAtIndex:indexPath.row withObject:model];
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (DLInvitationOrdetailsModel *model in weak_self.invitationArr) {
            [array addObject:[NSString stringWithFormat:@"%ld",(long)model.allotCount]];
        }
        
        NSNumber *sum = [array valueForKeyPath:@"@sum.floatValue"];
        weak_self.detailsFooterView.actualNumber.text = [sum stringValue];
        
    };
    
    return invoiceCell;
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (DLInvoiceHeaderView *)detailsHeadView{
    
    if (!_detailsHeadView) {
        _detailsHeadView = BoundNibView(@"DLInvoiceHeaderView", DLInvoiceHeaderView);
        
    }
    
    return _detailsHeadView;
}
- (DLInspectionStatusHeader *)inspectionHeadView{
    
    if (!_inspectionHeadView) {
        _inspectionHeadView = BoundNibView(@"DLInspectionStatusHeader", DLInspectionStatusHeader);
        
    }
    
    return _inspectionHeadView;
}




- (DLInvoiceDetaiFooterView *)detailsFooterView {
    
    if (!_detailsFooterView) {
        _detailsFooterView = BoundNibView(@"DLInvoiceDetaiFooterView", DLInvoiceDetaiFooterView);
        
    }
    return _detailsFooterView;
}

- (NSMutableArray*)setInvitationArr {
    
    if (!_invitationArr) {
        _invitationArr = [NSMutableArray array];
    }
    return _invitationArr;
    
}

- (DLStatusFooterView *)statusFooterView {
    
    if (!_statusFooterView) {
        _statusFooterView = BoundNibView(@"DLStatusFooterView", DLStatusFooterView);
        
        
    }
    return _statusFooterView;
}






- (DLOrderDetailsBottomView *)bottomView {

    if (!_bottomView) {
        _bottomView = BoundNibView(@"DLOrderDetailsBottomView", DLOrderDetailsBottomView);
       
        WEAK_SELF
        _bottomView.cancelBolck = ^{

            [weak_self goBack];
        };
        
        
        _bottomView.saveBolck = ^{
        
            [weak_self _submitData];
        };
    }
    
    return _bottomView;
}
@end

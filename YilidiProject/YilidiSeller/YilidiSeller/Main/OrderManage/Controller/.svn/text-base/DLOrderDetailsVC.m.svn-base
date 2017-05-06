//
//  DLOrderStatusVCViewController.m
//  YilidiBuyer
//
//  Created by yld on 16/5/30.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderDetailsVC.h"
#import "HMSegmentedControl.h"
#import "MycommonTableView.h"
#import "DLOrderStatusCell.h"
#import "DLOrderProcessView.h"
#import "DLOrderDetailsVC.h"
#import "DLOrderDetaiCell.h"
#import "DLOrderDetaiHeaderView.h"
#import "DLOrderDetaiFooterView.h"
#import "DLOrderProcessView.h"
#import "DLOrderDetaiFooterView.h"
#import "DLOrderDetaiHeaderView.h"

@interface DLOrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIButton *btnOrder;
@property (weak, nonatomic) IBOutlet UIView *processView;
@property (nonatomic,strong)DLOrderProcessView *orderProcessView;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *topSegmentedView;
@property (weak, nonatomic) IBOutlet MycommonTableView *statusTableView;
@property (nonatomic,strong)DLOrderDetaiFooterView *detailsFooterView;
@property (nonatomic,strong)DLOrderDetaiHeaderView *detailsHeadView;
@property (nonatomic,strong)UITableView *orderDetaiTableView;
@property (nonatomic,strong)NSArray *statusArr;
@property (nonatomic,strong)UIButton*rightButton;
@end

@implementation DLOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    [self _initItem];
    [self _statusTableView];
    [self _orderTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
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
    
    WEAK_SELF
    self.topSegmentedView.indexChangeBlock = ^(NSInteger index){
    
        if (index ==0) {
            weak_self.orderDetaiTableView.hidden = YES;
            weak_self.statusTableView.hidden = NO;
            weak_self.processView.hidden =NO;
            weak_self.rightButton.hidden=YES;
        }else{
            weak_self.orderDetaiTableView.hidden = NO;
            weak_self.statusTableView.hidden = YES;
            weak_self.processView.hidden =YES;
            weak_self.rightButton.hidden=NO;
        }
        
    };
    
    _orderProcessView =  [[DLOrderProcessView alloc] initWithFrame:CGRectMake(10, 10, 20, kScreenHeight)];
    _orderProcessView.backgroundColor = [UIColor clearColor];
    // 设置个数
    [_orderProcessView setCount:4];
    // 设置线条的之间的宽度
    _orderProcessView.lineGap = 45.0;
    // 设置订单的状态
    _orderProcessView.orderStatus = PlaceAnOrderStatus;
    
    
    // 这里设置为中心位置
    [_processView addSubview:_orderProcessView];

}

- (void)_initItem {

    _rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightButton.frame = CGRectMake(0, 0, 60, 30);
    _rightButton.hidden=YES;
//    [_rightButton setImage:[UIImage imageNamed:@"search.png"]forState:UIControlStateNormal];
    [_rightButton setTitle:@"开始验货" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.tag=100;
    [_rightButton addTarget:self action:@selector(_rightItemClick:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
}
#pragma mark ------------------------Private-------------------------
- (void)_rightItemClick:(UIButton *)btn {
  
    if (btn.tag==100) {
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        btn.tag=101;
    }else{
        [btn setTitle:@"开始验货" forState:UIControlStateNormal];
        btn.tag=100;
    }
   
    
}
- (void)_statusTableView{
    _statusArr = @[@"1",@"ceshi",@"ceshi",@"ceshi"];
    self.statusTableView.cellHeight = 90.0f;
    [self.statusTableView configurecellNibName:@"DLOrderStatusCell" cellDataSource:_statusArr configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        NSLog(@"%@",cellModel);
        if ([cellModel isEqualToString:@"1"]) {
            DLOrderStatusCell *statusCell = (DLOrderStatusCell *)cell;
            statusCell.statusBjView.layer.borderColor = UIColorFromRGB(0xFE6600).CGColor;
            statusCell.statusBjView.layer.borderWidth =1.0f;
            
        }
        
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
}

- (void)_orderTableView {
    
    self.orderDetaiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-68-50) style:UITableViewStyleGrouped];
    self.orderDetaiTableView.hidden = YES;
    self.orderDetaiTableView.delegate = self;
    self.orderDetaiTableView.dataSource = self;
   
    self.pageTitle = @"调货单详情";
    [self.orderDetaiTableView registerNib:[UINib nibWithNibName:@"DLOrderDetaiCell" bundle:nil] forCellReuseIdentifier:@"DLOrderDetaiCell"];
    self.orderDetaiTableView.tableHeaderView = self.detailsHeadView;
    self.orderDetaiTableView.tableFooterView =self.detailsFooterView;
    self.orderDetaiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.orderDetaiTableView];
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
//    
//    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(view.frame), 100, 20)];
//    for ( int i = 1; i < 3; i++) {
//        
//        _btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
//        _btnOrder.frame = CGRectMake(50*i-50, 0, 50, 20);
//        _btnOrder.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_btnOrder setUserInteractionEnabled:NO];
//        
//        if (i == 1) {
//            [_btnOrder setTitle:@"收货码" forState:UIControlStateNormal];
//            [_btnOrder setTitleColor:kGetColor(45.0, 133.0, 202.0) forState:UIControlStateNormal];
//        }
//        if (i == 2) {
//            [_btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        }
//        [_btnOrder setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"收货码%d.png",i]]forState:UIControlStateNormal];
//        [containerView addSubview:_btnOrder];
//        
//    }
//    containerView.frame = CGRectMake(kScreenWidth/2-50, CGRectGetHeight(view.frame)-20, 100, 20);
//    [view addSubview:containerView];
//    [_btnOrder setTitle:@"545" forState:UIControlStateNormal];
    
}


#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------



#pragma mark ------------------------Api----------------------------------
#pragma mark ------------------------Page Navigate---------------------------


#pragma mark ------------------------View Event---------------------------

#pragma mark ------------------------Delegate-----------------------------


#pragma -- mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _statusArr.count;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DLOrderDetaiCell *cell = [self.orderDetaiTableView dequeueReusableCellWithIdentifier:@"DLOrderDetaiCell" forIndexPath:indexPath];
    if (!cell) {
        cell  = [[DLOrderDetaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DLOrderDetaiCell"];
    }
    
    return cell;
}


#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------

- (DLOrderDetaiHeaderView *)detailsHeadView{

    if (!_detailsHeadView) {
        _detailsHeadView = BoundNibView(@"DLOrderDetaiHeaderView", DLOrderDetaiHeaderView);
        
    }
    
    return _detailsHeadView;
}


- (DLOrderDetaiFooterView *)detailsFooterView {
    
    if (!_detailsFooterView) {
        _detailsFooterView = BoundNibView(@"DLOrderDetaiFooterView", DLOrderDetaiFooterView);
        
    }
    return _detailsFooterView;
}


@end

//
//  OrderDetailController.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderDetailController.h"
#import "KJOrderDetailGoodsTableView.h"
#import "GlobeObject.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "Util.h"
#import "VApiManager.h"
#import "OderDetailModel.h"
#import "GoodsInfoModel.h"
#import "ZkgLoadingHub.h"
#import "KJOrderDetailResultTableView.h"
#import "NodataShowView.h"
#import "KJGoodsDetailViewController.h"
#import "KJDarlingCommentVC.h"
#import "PayOrderViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
CGFloat const OrderDetailSectionHeaderHeight = 55.0f;
CGFloat const OrderDetailSectionFooterHeight = 91.0f;
CGFloat const OrderDetailCellHeight = 105.0f;
CGFloat const PayWayCellHeight = 57.0f;
CGFloat const OrtherPartHeight = 287.0f;
CGFloat const SecondTableCellHiehgt = 21.0f;

@interface OrderDetailController (){

    VApiManager *_vapManager;
    
    NodataShowView *_nodataView;

}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollToBottonGap;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *bottomStateOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomStateTwoBtn;
@property (weak, nonatomic) IBOutlet KJOrderDetailGoodsTableView *orderDetailGoodsTableView;

@property (nonatomic,strong)OderDetailModel *orderDetailModel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderDetailTableHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondTableHeightConstraint;


@property (weak, nonatomic) IBOutlet UILabel *detailAdressLabel;
#pragma mark - UI Property
//订单编号label
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
//订单状态label
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *recievePersonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recievePersonPhoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *recieveAreaLabel;
@property (weak, nonatomic) IBOutlet KJOrderDetailResultTableView *secondTableView;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _init];
    
//    [self _requestOrderDetailData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self _requestOrderDetailData];

}


#pragma mark - private Method
-(void)_init{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.barTintColor = NavBarColor;
    _vapManager = [[VApiManager alloc] init];
    [Util setNavTitleWithTitle:@"订单详情" ofVC:self];
//    //返回
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"关闭" titleColor:[UIColor whiteColor] target:self action:@selector(back)];
    
    WEAK_SELF;
    self.orderDetailGoodsTableView.clickOrderDetailBlock = ^(NSIndexPath *indexPath,NSNumber *goodsID){
        KJGoodsDetailViewController *goodsDetailVC = [[KJGoodsDetailViewController alloc] init];
        goodsDetailVC.goodsID = goodsID;
        [weak_self.navigationController pushViewController:goodsDetailVC animated:YES];
    };
    
}

- (void)_setBottomStateButtonTitle {

    [[self.bottomStateOneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        switch (self.orderDetailModel.orderStatus.integerValue) {
            case 40:
                //立即评价
                [self _comminToCommentPage];
                break;
            case 10:
                //代付款，去付款
                [self _comminToPayPage];
                break;
            case 30:
                //确认收货，调接口
                [self confirmRecieve:self.orderDetailModel.OderDetailModelID];
                break;

            default:
                break;
        }
        
    }];
    
    [[self.bottomStateTwoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        switch (self.orderDetailModel.orderStatus.integerValue) {
            case 10:
                //代付款，取消
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            default:
                break;
        }

    }];
    
    switch (self.orderDetailModel.orderStatus.integerValue) {
        case 40:
        {
            [self _oneBottomBtnDisplayConfigure];
            [self.bottomStateOneBtn setTitle:@"立即评价" forState:UIControlStateNormal];

        }
            break;
        case 10:
        {
            [self _twoBottomBtnDisplayConfigure];
            [self.bottomStateTwoBtn setTitle:@"取消" forState:UIControlStateNormal];
            [self.bottomStateOneBtn setTitle:@"去付款" forState:UIControlStateNormal];

            
        }
            break;
        case 30:
        {
            [self _oneBottomBtnDisplayConfigure];
            [self.bottomStateOneBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            
        }
            break;
            
        default:
        {
            self.bottomView.hidden = YES;
            self.scrollToBottonGap.constant = 0;
        }
            break;
    }
}

- (void)_oneBottomBtnDisplayConfigure {
    self.bottomView.hidden = NO;
    self.scrollToBottonGap.constant = 44;
    self.bottomStateOneBtn.hidden = NO;
    self.bottomStateTwoBtn.hidden = YES;
}

- (void)_twoBottomBtnDisplayConfigure {
    self.bottomView.hidden = NO;
    self.scrollToBottonGap.constant = 44;
    self.bottomStateOneBtn.hidden = NO;
    self.bottomStateTwoBtn.hidden = NO;
}

-(void)_comminToCommentPage {
    
    KJDarlingCommentVC *commentVC = [[KJDarlingCommentVC alloc] init];
    commentVC.goodsInfos = self.goodsInfo;
    commentVC.orderID = self.orderDetailModel.OderDetailModelID;
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

-(void)_comminToPayPage {

    PayOrderViewController *payOrderVC = [[PayOrderViewController alloc] init];
    payOrderVC.orderID = self.orderDetailModel.OderDetailModelID;
    payOrderVC.orderNumber = self.orderDetailModel.orderId;
    payOrderVC.jingGangPay = ShoppingPay;
    [self.navigationController pushViewController:payOrderVC animated:YES];
}


#pragma mark - 确认收货接口请求
- (void)confirmRecieve:(NSNumber *)orderID
{
    SelfGoodsConfirmRequest *request = [[SelfGoodsConfirmRequest alloc] init:GetToken];
    request.api_orderId = orderID;
    
    [_vapManager selfGoodsConfirm:request success:^(AFHTTPRequestOperation *operation, SelfGoodsConfirmResponse *response) {
        
        if (!response.errorCode) {
            //重新请求
            [self _requestOrderDetailData];
        }else {
            [Util ShowAlertWithOnlyMessage:response.subMsg];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
        
    }];
}



-(void)_requestOrderDetailData{
    ZkgLoadingHub *hub = [[ZkgLoadingHub alloc] initHubPartInView:self.view withTopgap:0 bottonGap:0 leftGap:0 rightGap:0 withLoadingType:LoadingSystemtype];
    
    SelfDetailRequest *request = [[SelfDetailRequest alloc] init:GetToken];
    request.api_id = self.orderID;
    if (_nodataView) {
        [_nodataView removeFromSuperview];
    }
    
    [_vapManager selfDetail:request success:^(AFHTTPRequestOperation *operation, SelfDetailResponse *response) {
        NSDictionary *responseDic = (NSDictionary *)response.selfOrder;
        NSArray *orderlist = responseDic[@"orderFormList"];
        NSLog(@"order detal %@",response);
        
        self.orderDetailModel = [[OderDetailModel alloc] initWithJSONDic:(NSDictionary *)response.selfOrder];
        NSMutableArray *orderArr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in orderlist) {
            OderDetailModel *ordermodel = [[OderDetailModel alloc] initWithJSONDic:dic];
            [orderArr addObject:ordermodel];
            //每个模型里面又有一个商品list,给每个list里的商品变成模型
            NSMutableArray *goodInfosArr = [NSMutableArray arrayWithCapacity:ordermodel.goodsInfos.count];
            for (NSDictionary *dicGoodsInfo in ordermodel.goodsInfos) {
                GoodsInfoModel *goodsInfoModel = [[GoodsInfoModel alloc] initWithJSONDic:dicGoodsInfo];
                [goodInfosArr addObject:goodsInfoModel];
            }
            //重新给订单模型的商品列表赋值,保证它里面装的是商品模型
            ordermodel.goodsInfos = (NSArray *)goodInfosArr;
        }
        //计算表的高度
      CGFloat tableHeight =  [self _calculateTableHeightWithOrderlistArr:orderlist];
      //计算表中section的总高度
        CGFloat tableSectionHeight = [self _calculateSectionHeightWithArr:orderArr];
      self.orderDetailTableHeightConstraint.constant = tableHeight + tableSectionHeight ;
      [self.view layoutIfNeeded];
        
      //刷新表
      self.orderDetailGoodsTableView.orderListArr = orderArr;
      if (orderArr.count >= 1) {
          OderDetailModel *model = orderArr[0];
          self.orderDetailGoodsTableView.orderDetailModel = self.orderDetailModel;
          self.orderDetailGoodsTableView.payWay = model.payWay;

      }
      [self.orderDetailGoodsTableView reloadData];
        
      //给UI赋值数据，除表
      [self _assignDataToUI];
        
        
      //处理第二张表的数据
      NSArray *resultData = [self _dealWithTheSecondTableData];
      self.secondTableView.resultData = resultData;
      [self.secondTableView reloadData];
      [hub endLoading];
        
      [self _setBottomStateButtonTitle];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       [hub endLoading];
      _nodataView = [NodataShowView showInContentView:self.view withReloadBlock:^{
            [self _requestOrderDetailData];
        } requestResultType:NetworkRequestFaildType];
    }];
}
#pragma mark - private Method 
#pragma mark - 给UI数据
-(void)_assignDataToUI{
    
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单编号:%@",self.orderDetailModel.orderId];
    self.orderStatusLabel.text = [NSString stringWithFormat:@"状态：%@",self.orderDetailModel.orderStatusStr];
    self.recievePersonNameLabel.text = [NSString stringWithFormat:@"收货人:%@",self.orderDetailModel.receiverName];
    self.recievePersonPhoneNumLabel.text = [NSString stringWithFormat:@"%@",self.orderDetailModel.receiverMobile];
    self.recieveAreaLabel.text = [NSString stringWithFormat:@"收货地址:%@",self.orderDetailModel.receiverArea];
    self.detailAdressLabel.text = [NSString stringWithFormat:@"详细地址:%@",self.orderDetailModel.receiverAreaInfo];
}

#pragma mark - 计算总组尾的高度，因为有的无法查看物流
-(CGFloat)_calculateSectionHeightWithArr:(NSArray *)orderArr{

    CGFloat totalFooterHeight = 0.0f;
    for (OderDetailModel *model in orderArr) {
        CGFloat footerHeiht = model.canLookGoodsDelivery ? 91 : 44;
        totalFooterHeight += footerHeiht;
    }
    CGFloat totalHeaterHeight = orderArr.count * OrderDetailSectionHeaderHeight;
    return totalFooterHeight + totalHeaterHeight;
}

#pragma mark - 计算表的高度
-(CGFloat)_calculateTableHeightWithOrderlistArr:(NSArray *)orderList{
    //计算tableview的高度,（组头+组尾）* 组数 + 支付方式高度 + 每组cell的总高度
//    CGFloat sectionHeaderHeight = OrderDetailSectionHeaderHeight * orderList.count;
    CGFloat cellTotalHeight = 0.0;
    for (NSDictionary *dic in orderList) {
        NSArray *goodsInfo = dic[@"goodsInfos"];
        cellTotalHeight += goodsInfo.count * OrderDetailCellHeight;
    }
    NSInteger orderStatus = self.orderDetailModel.orderStatus.integerValue;
    if (orderStatus == 10 || orderStatus == 0) {//不是待付款和取消状态
        return cellTotalHeight;
    }else {
        return cellTotalHeight + PayWayCellHeight;
    }
    
}

#pragma mark - 处理第二张表的数据
-(NSArray *)_dealWithTheSecondTableData{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    if (self.orderDetailModel.totalPrice.integerValue >= 0) {
        NSDictionary *dicTwo = @{@"商品金额":self.orderDetailModel.totalPrice};
        [arr addObject:dicTwo];
    }
   
    if (self.orderDetailModel.shipPrice.integerValue >= 0) {
       NSDictionary *dicOne = @{@"运费":self.orderDetailModel.shipPrice};
       [arr addObject:dicOne];
    }
    
    if (self.orderDetailModel.price.integerValue >= 0) {
        NSDictionary *dicTwo = @{@"实付金额":self.orderDetailModel.price};
        [arr addObject:dicTwo];
    }

    
//    if (self.orderDetailModel.couponAmount.integerValue > 0) {
//       NSDictionary *dicThree = @{@"优惠券金额":self.orderDetailModel.couponAmount};
//       [arr addObject:dicThree];
//    }
    //计算table的高度
    self.secondTableHeightConstraint.constant = arr.count * SecondTableCellHiehgt;
    return arr;
}

#pragma mark - action Method
-(void)back{


    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end

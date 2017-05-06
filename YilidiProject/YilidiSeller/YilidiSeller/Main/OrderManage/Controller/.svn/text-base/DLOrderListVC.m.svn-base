//
//  DLOrderListVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLOrderListVC.h"
#import "HMSegmentedControl.h"
#import "DLOrderlistVCTopHelper.h"
#import "DLUpDownTitleView.h"
#import "UIView+BlockGesture.h"
#import "DLInputRecieveGoodsCodeView.h"
#import <Masonry/Masonry.h>
#import "DLSearchVC.h"
#import "DLGoodsSearchTopView.h"
#import "Util.h"
#import "GlobleConst.h"
#import "MerchantOrderDetailModel.h"
#import "DLOrderDetailVC.h"
@interface DLOrderListVC ()

@property (strong, nonatomic) IBOutletCollection(DLUpDownTitleView) NSArray *orderTopStatusTitleButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *orderTypeButtons;
@property (nonatomic, strong)DLOrderlistVCTopHelper *orderListTopHelper;

@property (nonatomic, assign)NSInteger lastSelecteOrderStatusIndex;

@property (nonatomic, strong)DLInputRecieveGoodsCodeView *inputRecieveGoodsCodeView;

@property (nonatomic, strong)DLGoodsSearchTopView *goodsSearchTopView;

@end

@implementation DLOrderListVC

- (void)viewDidLoad {
    self.doNotNeedBaseBackItem = YES;
    [super viewDidLoad];
    self.showNavbarBottomLine = NO;
    
    [self _init];
    
    [self _initTopBarView];
    
    [self _initTopViewHelper];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self.orderListTopHelper clickTopbarAtIndex:self.lastSelecteOrderStatusIndex];
    [self _initGoodsSearchTopView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.goodsSearchTopView removeFromSuperview];

}

#pragma mark -------------------Api Method----------------------
- (void)_requestOrderDetailWithRecieCode:(NSString *)recieveCode {
    
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithCapacity:0];
    if (!isEmpty(recieveCode)) {
        [requestParam setObject:recieveCode forKey:@"receiveNo"];
    }

    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_OrderDetail block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        if (error.code != 1) {
            [Util ShowAlertWithOnlyMessage:error.localizedDescription];
            return;
        }
        
        MerchantOrderDetailModel *orderDetailModel = [[MerchantOrderDetailModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        [self _enterOrderDetailPageWithOrderDetailModel:orderDetailModel];
    }];
}


#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterOrderSearchPage {
    
    DLSearchVC *searchVC = [[DLSearchVC alloc] init];
    searchVC.searchType = SearchType_Order;
    [self navigatePushViewController:searchVC animate:YES];
}

- (void)_enterOrderDetailPageWithOrderDetailModel:(MerchantOrderDetailModel *)orderDetailModel {
    DLOrderDetailVC *orderDetailVC = [[DLOrderDetailVC alloc] init];
    orderDetailVC.orderDetailModel = orderDetailModel;
    [self navigatePushViewController:orderDetailVC animate:YES];
}

#pragma mark -------------------Private Method----------------------
-(void)_init {
//    self.pageTitle = @"订单管理";
    self.lastSelecteOrderStatusIndex = 0;
    self.navigationController.view.backgroundColor  = [UIColor whiteColor];
}

-(void)_initGoodsSearchTopView {
    self.goodsSearchTopView = BoundNibView(@"DLGoodsSearchTopView", DLGoodsSearchTopView);
    self.goodsSearchTopView.searchType = SearchType_Order;
    [self.navigationController.view addSubview:self.goodsSearchTopView];
    
    WEAK_SELF
    [self.goodsSearchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.navigationController.view.mas_top).with.offset(20);
        make.left.right.mas_equalTo(weak_self.navigationController.view);
        make.height.mas_equalTo(44);
    }];
    
    self.goodsSearchTopView.searchBackBlock = ^{
        [weak_self goBack];
    };
    
    self.goodsSearchTopView.displayRecipeCodeBlock = ^{
        [weak_self.inputRecieveGoodsCodeView show];
    };
    
    self.goodsSearchTopView.clickToBeginSearchBlock = ^(){
        [weak_self _enterOrderSearchPage];
    };
}


- (void)_initTopBarView {
    NSArray *orderStatusTitles = @[@"待接单",@"待发货",@"待确认",@"已完成",@"已取消"];
//    NSArray *orderStatusCountTitles = @[@"0",@"0",@"0",@"0",@"0"];
    for (NSInteger i=0; i<self.orderTopStatusTitleButtons.count; i++) {
        DLUpDownTitleView *titleView = (DLUpDownTitleView *)self.orderTopStatusTitleButtons[i];
//        titleView.upTitle = orderStatusCountTitles[i];
        titleView.downTitle = orderStatusTitles[i];
        titleView.canTouched = NO;
        titleView.upButton.hidden = YES;
        titleView.needVerticalSeperatedLine = YES;
        WEAK_SELF
        [titleView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self clickOrderStatusButtonAtIndex:i];
        }];
        if (i == self.lastSelecteOrderStatusIndex) {
            titleView.selected = YES;
        }
    }
}

- (void)_initTopViewHelper {
    
    self.orderListTopHelper = [[DLOrderlistVCTopHelper alloc] initWithTableCount:self.orderTopStatusTitleButtons.count vcRootView:self.view];
    self.orderListTopHelper.orderListVC = self;
}


- (void)_notifyHelperToRreshOrderDataAtClickButtonIndex:(NSInteger)buttonIndex {
    NSInteger selectedOrderTypeNumber;
    if (buttonIndex == 0) {
        selectedOrderTypeNumber = kOrderTypeNumberNomal;
    }else if (buttonIndex == 1){
        selectedOrderTypeNumber = kOrderTypeNumberOther;
    }
    self.orderListTopHelper.orderTypeNumber = @(selectedOrderTypeNumber);
}

- (void)clickOrderStatusButtonAtIndex:(NSInteger)orderStatusIndex {
    
    NSInteger currentSelectedOrderIndex = orderStatusIndex;
    if (currentSelectedOrderIndex != self.lastSelecteOrderStatusIndex) {
        DLUpDownTitleView *currentTopOrderItemView = self.orderTopStatusTitleButtons[currentSelectedOrderIndex];
        DLUpDownTitleView *lastTopOrderItemView = self.orderTopStatusTitleButtons[self.lastSelecteOrderStatusIndex];
        lastTopOrderItemView.selected = NO;
        currentTopOrderItemView.selected = YES;
        self.lastSelecteOrderStatusIndex = currentSelectedOrderIndex;
    }
    
    [self.orderListTopHelper clickTopbarAtIndex:orderStatusIndex];
}

- (IBAction)clickOrderTypeAction:(id)sender {
    UIButton *clickOrderTypeButton = (UIButton *)sender;
    if (clickOrderTypeButton.selected) {
        return;
    }
    
    UIButton *lastClickButton = (UIButton *)[Util getSeletedButtonAtBtnArr:self.orderTypeButtons];
    lastClickButton.selected = NO;
    lastClickButton.backgroundColor = [UIColor whiteColor];
    
    clickOrderTypeButton.selected = YES;
    clickOrderTypeButton.backgroundColor = KSelectedBgColor;
    
    [self _notifyHelperToRreshOrderDataAtClickButtonIndex:clickOrderTypeButton.tag];
}

#pragma mark -------------------Setter/Getter Method----------------------
- (DLInputRecieveGoodsCodeView *)inputRecieveGoodsCodeView {
    
    if (!_inputRecieveGoodsCodeView) {
        _inputRecieveGoodsCodeView = BoundNibView(@"DLInputRecieveGoodsCodeView", DLInputRecieveGoodsCodeView);
        [self.view addSubview:_inputRecieveGoodsCodeView];
        [_inputRecieveGoodsCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        WEAK_SELF
        _inputRecieveGoodsCodeView.sureInputCodeBlock = ^(NSString *inputCode){
            [weak_self _requestOrderDetailWithRecieCode:inputCode];
        };
    }
    return _inputRecieveGoodsCodeView;
}

@end

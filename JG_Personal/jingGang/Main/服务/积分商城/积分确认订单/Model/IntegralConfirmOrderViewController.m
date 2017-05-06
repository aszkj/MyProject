//
//  IntegralPayViewController.m
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralConfirmOrderViewController.h"
#import "IntegralConfirmOrderViewModel.h"
#import "UIButton+Design.h"
#import "KeyboardManager.h"
#import "DefaultAddressTableViewCell.h"
#import "IntegralConfirmCellTableViewCell.h"
#import "PayOrderViewController.h"
#import "WSJManagerAddressViewController.h"
#import "IntegralResultViewController.h"
#import "TMCache.h"
#import "NSObject+MJExtension.h"

@interface IntegralConfirmOrderViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) IntegralConfirmOrderViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *feeLabel;
@property (weak, nonatomic) IBOutlet UITextView *feedTF;

@end

@implementation IntegralConfirmOrderViewController

static NSString *cellIdentifierHead = @"DefaultAddressTableViewCell";
static NSString *cellIdentifier = @"IntegralConfirmCellTableViewCell";

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)bindViewModel {
    [super bindViewModel];
    if (self.IntegralGoods == nil) {
        [self setDebugData];
    }
    @weakify(self)
    [self.viewModel.getAddressCommand execute:nil];
    [self.viewModel.getTransPriceCommand execute:nil];
    
    [[RACObserve(self.viewModel, defaultAddress) skip:1] subscribeNext:^(ShopUserAddress *address) {
        @strongify(self)
        if (address == nil) {
            [self showAddressAlert];
        } else {
            [self freshTableView];
        }
    }];
    RAC(self.feeLabel, attributedText) = RACObserve(self.viewModel, feeString);
    RAC(self.viewModel, feedMessage) = self.feedTF.rac_textSignal;
    self.commitButton.rac_command = self.viewModel.createOrderCommand;
    [[[self.viewModel.createOrderCommand executionSignals] switchToLatest] subscribeNext:^(id x)
    {
        @strongify(self)
        if (self.viewModel.defaultAddress == nil) {
            [self showAddressAlert];
        } else {
            [[TMCache sharedCache] removeObjectForKey:kIntegralGoodsCacheKey];
            [self commitAction];
        }
    }];
}

#pragma mark - event response

#pragma mark - 显示收货管理界面
- (void)showAddressAlert {
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:@"您还没有设置收货地址,请点击进行设置"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    [[alertV rac_buttonClickedSignal] subscribeNext:^(NSNumber *index) {
        NSInteger buttonIndex = index.integerValue;
        if (buttonIndex == 1) {
            [self showManagerAddressVC];
        } else if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertV show];
}

- (void)showManagerAddressVC {
    WSJManagerAddressViewController *addressVC = [[WSJManagerAddressViewController alloc] init];
    [self.navigationController pushViewController:addressVC animated:YES];
    addressVC.selectAddress = ^ (NSDictionary *dic) {
        self.viewModel.defaultAddress = [ShopUserAddress JGObjectvalueWithKeyValue:dic];
    };
}

#pragma mark - 提交订单
- (void)commitAction {
    if (self.viewModel.computeOrderBO.totalTransportFee.doubleValue == 0) {
        IntegralResultViewController *VC = [[IntegralResultViewController alloc] init];
        VC.orderNumber = self.viewModel.orderBO.igoOrderSn;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        PayOrderViewController *VC = [[PayOrderViewController alloc] init];
        VC.orderID = self.viewModel.orderBO.apiId;
        VC.jingGangPay = IntegralPay;
        VC.orderNumber = self.viewModel.orderBO.igoOrderSn;
        VC.totalPrice = self.viewModel.orderBO.igoTransFee.doubleValue;
        [self.navigationController pushViewController:VC animated:YES];
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showManagerAddressVC];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifierHead cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifierHead cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    } else {
        return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
            [self loadCellContent:cell indexPath:indexPath];
            
        }];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 1) {
        cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    } else if (indexPath.row == 0) {
        cell= [tableView dequeueReusableCellWithIdentifier:cellIdentifierHead];
    }
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    if (indexPath.row == 1) {
        IntegralConfirmCellTableViewCell *confirmCell = (IntegralConfirmCellTableViewCell *)cell;
        [confirmCell setEntity:self.viewModel.IntegralGoods];
    } else if (indexPath.row == 0) {
        DefaultAddressTableViewCell *addresCell = (DefaultAddressTableViewCell *)cell;
        [addresCell changeShopUserAddress:self.viewModel.defaultAddress];
    }
}

- (void)setTableViewAppearance {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 95.5;
    self.tableView.rowHeight = 95.5;
    
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier.copy];
    nibCell = [UINib nibWithNibName:cellIdentifierHead bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifierHead.copy];

    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - private methods

- (void)freshTableView {
    [self.tableView reloadData];
    CGFloat addressHeight = ({
        [self.tableView fd_heightForCellWithIdentifier:cellIdentifierHead cacheByIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] configuration:^(id cell) {}];
    });
    CGFloat goodsHeight = ({
        [self.tableView fd_heightForCellWithIdentifier:cellIdentifierHead cacheByIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] configuration:^(id cell) {}];
    });
    self.tableViewHeight.constant = addressHeight + goodsHeight;
    [self.view layoutSubviews];
}

- (void)setUIAppearance {
    [super setUIAppearance];
    [self.commitButton setEnlargeEdgeWithTop:20 right:0 bottom:20 left:0];
    [self setTableViewAppearance];
}

- (void)setViewsMASConstraint {
    
}

#pragma mark - getters and settters

- (IntegralConfirmOrderViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[IntegralConfirmOrderViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setIntegralGoods:(NSArray *)IntegralGoods {
    _IntegralGoods = IntegralGoods;
    self.viewModel.IntegralGoods = IntegralGoods;
}


#pragma mark - debug operation
- (void)setDebugData {
    NSDictionary *dataDic1 = @{
                               @"apiId":@1,
                              @"igExchangeCount":@3,
                               @"igGoodsName":@"手套",
                               @"igGoodsIntegral":@200
                              };
    NSDictionary *dataDic2 = @{
                               @"apiId":@3,
                               @"igExchangeCount":@2,
                               @"igGoodsName":@"手套oo",
                               @"igGoodsIntegral":@200
                               };
    
    self.IntegralGoods = [IntegralGoodsDetails objectArrayWithKeyValuesArray:@[dataDic1,dataDic2]];
}

- (void)updateOnClassInjection {
    [self setDebugData];
    [self freshTableView];


}

@end

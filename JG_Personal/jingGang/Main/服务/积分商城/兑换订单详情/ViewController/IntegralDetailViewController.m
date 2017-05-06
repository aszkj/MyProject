//
//  IntegralDetailViewController.m
//  jingGang
//
//  Created by ray on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "IntegralDetailViewController.h"
#import "IntegralDetailViewModel.h"
#import "UIButton+Design.h"
#import "UIView+Design.h"
#import "IntegralDetailTableViewCell.h"
#import "IntegralOrderDetails+Model.h"
#import "PayOrderViewController.h"
#import "QueryLogisticsViewController.h"
#import "IntegralResultViewController.h"
#import "IntegralGoodsDetailController.h"

@interface IntegralDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) IntegralDetailViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *ChecklogisticsButton;
@property (weak, nonatomic) IBOutlet UIView *orderStatusView;
@property (weak, nonatomic) IBOutlet UIView *integralMessageView;
@property (weak, nonatomic) IBOutlet UIView *payMessageView;
@property (weak, nonatomic) IBOutlet UIView *recieverMessageView;
@property (weak, nonatomic) IBOutlet UIView *transMessageView;
@property (weak, nonatomic) IBOutlet UIView *presentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *presentCellTotalHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *statusLabelRight;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumerLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (weak, nonatomic) IBOutlet UILabel *integralTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transPayLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *recieverLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *postCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *telNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *transCompany;
@property (weak, nonatomic) IBOutlet UILabel *transOrderLabel;
@property (weak, nonatomic) IBOutlet UILabel *transStartTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *transMessageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *markImage;

@end

@implementation IntegralDetailViewController

static NSString *cellIdentifier = @"IntegralDetailTableViewCell";

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)bindViewModel {
    [super bindViewModel];
    @weakify(self)

    [self.viewModel.getDetailCommand execute:nil];
    [[RACObserve(self.viewModel, detail) skip:1] subscribeNext:^(IntegralOrderDetails *detail) {
        @strongify(self)
        self.orderNumerLabel.text = detail.orderSNString;
        self.statusLabel.text = detail.status;
        if (detail.orderStatus.intValue != 0) {
            self.payButton.hidden = YES;
            self.statusLabelRight.constant = 15;
            [self.orderStatusView layoutSubviews];
        }
        self.integralNumberLabel.text = detail.totalIntegralString;
        self.transPayLabel.text = detail.transPayString;
        self.integralTimeLabel.text = detail.addTimeString;
        self.payWayLabel.text = detail.payWayString;
        self.payTimeLabel.text = detail.payTimeString;
        self.payMessageLabel.text = detail.payMessageString;
        self.recieverLabel.text = detail.recieverString;
        self.areaLabel.text = detail.areaString;
        self.postCodeLabel.text = detail.postCodeString;
        self.addressLabel.text = detail.addressString;
        self.telNumberLabel.text = detail.telString;
        self.phoneNumberLabel.text = detail.phoneNumberString;
        self.transCompany.text = detail.transCompanyString;
        self.transOrderLabel.text = detail.transNumberString;
        if (detail.igoShipCode == nil) {
            self.ChecklogisticsButton.enabled = NO;
        } else {
            self.ChecklogisticsButton.enabled = YES;
        }
        self.transStartTimeLabel.text = detail.sendTimeString;
        self.transMessageLabel.text = detail.transMessageString;
        [self.tableView reloadData];
        //物流公司信息

        
    }];
    self.payButton.rac_command = self.viewModel.getUserIntegralCommand;
    [[[self.viewModel.getUserIntegralCommand executionSignals] switchToLatest] subscribeNext:^(id x) {
        @strongify(self)
        if (self.viewModel.userIntegral.integral.doubleValue >= self.viewModel.detail.igoTotalIntegral.doubleValue) {
            [self payAction];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的可用积分不足" message:nil delegate:self cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定",nil];
            [alert show];
        }
    }];
}

#pragma mark - setter and getter

- (IntegralDetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[IntegralDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (void)setOrderId:(NSNumber *)orderId {
    _orderId = orderId;
    self.viewModel.orederId = orderId;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralGoodsDetailController *VC = [[IntegralGoodsDetailController alloc] init];
    IGo *goodsInfo = self.viewModel.detail.igoList[indexPath.row];
    VC.integralGoodsID = goodsInfo.apiId;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.viewModel.detail.igoList.count;
    if (self.presentCellTotalHeight.constant != count*83) {
        self.presentCellTotalHeight.constant = count*83;
        [self.view layoutSubviews];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    
    [self loadCellContent:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)loadCellContent:(UITableViewCell *)cell indexPath:(NSIndexPath*)indexPath
{
    //这里把数据设置给Cell
    IntegralDetailTableViewCell *detailCell = (IntegralDetailTableViewCell *)cell;
    [detailCell setEntity:self.viewModel.detail.igoList[indexPath.row]];
}

#pragma mark - event response

- (void)backClick {
    NSArray *controllers = self.navigationController.viewControllers;
    if (controllers.count >= 2 && [controllers[controllers.count-2] isKindOfClass:NSClassFromString(@"PayOrderViewController")]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self btnClick];
    }
}

- (IBAction)checkTrans:(id)sender {
    QueryLogisticsViewController *VC = [[QueryLogisticsViewController alloc] init];
//    VC.expressCompanyId = self.viewModel.detail.igf

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    VC.expressCompanyId = [numberFormatter numberFromString:self.viewModel.detail.expressCompanyId];
    
    VC.expressCode = self.viewModel.detail.igoShipCode;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)payAction {
    PayOrderViewController *VC = [[PayOrderViewController alloc] init];
    VC.orderID = self.viewModel.orederId;
    VC.orderNumber = self.viewModel.detail.igoOrderSn;
    VC.totalPrice = self.viewModel.detail.igoTransFee.doubleValue;
    VC.jingGangPay = IntegralPay;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - private methods

#pragma mark - set UI appearance
- (void)setUIAppearance {
    [super setUIAppearance];
    self.view.backgroundColor = UIColorFromRGB(0xefefef);
    [self.ChecklogisticsButton setEnlargeEdgeWithTop:200 right:0 bottom:0 left:0];
    [self.orderStatusView addTopAndBottomLine:UIColorFromRGB(0xd7d7d7)];
    [self.integralMessageView addTopAndBottomLine:UIColorFromRGB(0xd7d7d7)];
    [self.payMessageView addTopAndBottomLine:UIColorFromRGB(0xd7d7d7)];
    [self.recieverMessageView addTopAndBottomLine:UIColorFromRGB(0xd7d7d7)];
    [self.transMessageView addTopAndBottomLine:UIColorFromRGB(0xd7d7d7)];
    [self.presentView addTopAndBottomLine:UIColorFromRGB(0xd7d7d7)];
    [self setTableViewAppearance];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(backClick) target:self];
    self.scrollView.delegate = self;
}

- (void)setTableViewAppearance {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 95.5;
    self.tableView.rowHeight = 95.5;
    
    UINib *nibCell = [UINib nibWithNibName:cellIdentifier bundle:nil];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:cellIdentifier.copy];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - dyci debug operation
- (void)updateOnClassInjection {
//    self.viewModel.orederId = @(55);
    [self.viewModel.getDetailCommand execute:nil];
    UIImage *imageCache = [self.markImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if (imageCache) {
        self.markImage.image = imageCache;
        self.markImage.tintColor = [UIColor greenColor];
    }
    IntegralResultViewController *VC = [[IntegralResultViewController alloc] init];
    VC.orderNumber = @"199029381";
    [self.navigationController pushViewController:VC animated:YES];
}

@end

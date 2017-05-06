//
//  SalesReturnDetailVC.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//
#import "SalesReturnDetailVC.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "SalesReturnListVC.h"
#import "ActionSheetStringPicker.h"
#import "APIManager.h"
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"

@interface SalesReturnDetailVC () <UITextFieldDelegate,APIManagerDelegate>

@property (nonatomic) UIImageView *salesReturnImage;
@property (nonatomic) UIImageView *salesReturnMark;
@property (nonatomic) UILabel *goodsDescription;
@property (nonatomic) UILabel *supplier;
@property (nonatomic) UIView *receiptView;
@property (nonatomic) UILabel *receiptTitle;
@property (nonatomic) UILabel *receiptDetail;
@property (nonatomic) UILabel *reasonTitle;
@property (nonatomic) UITextField *reasonText;
@property (nonatomic) UIView *wuliuView;
@property (nonatomic) UIImageView *carLogo;
@property (nonatomic) UILabel *company;
@property (nonatomic) UILabel *orderMark;
@property (nonatomic) UIImageView *triangleMark;
@property (nonatomic) UIImageView *orderNumber;
@property (nonatomic) UIButton *commitBtn;
@property (nonatomic) UITextField *orderText;
@property (nonatomic) UIButton *wayBtn;
@property (nonatomic) NSArray *companyDetail;
@property (nonatomic) ActionSheetStringPicker *actionPicker;
@property (nonatomic) NSNumber *expressId;
@property (nonatomic) MBProgressHUD *progressHUD;


@property (nonatomic) APIManager *companyListManager;
@property (nonatomic) APIManager *returnShipSaveManager;

@end

@implementation SalesReturnDetailVC

#define lableFont [UIFont systemFontOfSize:13.5]
#define labelTextColor UIColorFromRGB(0x666666)

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [self addSubViews];
    [self setUIContent];
    [self setViewsMASConstraint];
    [self checkCompanyName];
    self.returnShipSaveManager = [[APIManager alloc] initWithDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animate {
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField              // called when 'return' key pressed. return NO to ignore.
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 网络请求处理
- (void)apiManagerDidSuccess:(APIManager *)manager
{
    if (manager == self.companyListManager) {
        ShopExpressCompanyListResponse *response = self.companyListManager.successResponse;
        self.companyDetail = response.list;
    } else if (manager == self.returnShipSaveManager) {
        [self.progressHUD hide:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)apiManagerDidFail:(APIManager *)manager
{

}


#pragma mark - 改变快递方式
- (void)changeWay {
    
    NSMutableArray *wuliuCompanys = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.companyDetail.count; i++) {
        [wuliuCompanys addObject:[self wuliuCompanyName:i]];
    }
    
    NSArray *numberData = wuliuCompanys.copy;
    
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [self.wayBtn setTitle:selectedValue forState:UIControlStateNormal];
        self.expressId = [self wuliuID:selectedIndex];
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
    };
    self.actionPicker = [[ActionSheetStringPicker alloc] initWithTitle:@"选择物流" rows:numberData.copy initialSelection:0 doneBlock:done cancelBlock:cancel origin:self.view];
    [self.actionPicker showActionSheetPicker];
}

#pragma mark - 保存物流信息
- (void)commitAction {
    if (self.orderText.text.length < 9) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:@"请填写物流单号"
                                                        delegate:self
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"确定", nil];
        [alertV show];
    
    } else {
        self.progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.progressHUD.labelText = @"Loading";
        [self.progressHUD show:YES];
        [self.returnShipSaveManager returnShipSave:self.returnGoodsLogId.longValue expressId:self.expressId.longValue expressCode:self.orderText.text];
    }
}

#pragma mark - private methods

- (void)checkCompanyName {
    if (self.companyDetail == nil) {
        self.companyListManager = [[APIManager alloc] initWithDelegate:self];
        [self.companyListManager getWuliuCompanyList];
    } else {
        self.expressId = [self wuliuID:0];
    }
}

- (void)setBarButtonItem {
    //    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain  target:self  action:nil];
    //    self.navigationItem.backBarButtonItem = backButton;
    [self setLeftBarAndBackgroundColor];
}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.barTintColor = status_color;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"退货物流信息";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setViewsMASConstraint {
    
    UIView *superView = self.view;
    [self.salesReturnImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@50);
    }];
    [self.salesReturnMark mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.salesReturnImage).with.offset(23);
        make.centerY.equalTo(self.salesReturnImage);
        make.size.mas_equalTo(CGSizeMake(18, 23.5));
    }];
    [self.goodsDescription mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.salesReturnImage);
        make.left.equalTo(superView).with.offset(64);
    }];
    [self.supplier mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(self.salesReturnImage.mas_bottom);
        make.height.equalTo(@70);
    }];
    
    UIView *bottomLine = [self backLineView];
    [self.supplier addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.supplier);
        make.height.equalTo(@1);
        make.left.equalTo(self.supplier);
        make.right.equalTo(self.supplier);
    }];
    
    [self.receiptView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.supplier.mas_bottom).with.offset(12);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(self.reasonText).with.offset(12);

    }];
    
    [self.receiptTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receiptView);
        make.left.equalTo(self.receiptView).with.offset(8);
        make.right.equalTo(self.receiptView).with.offset(-8);
        make.height.equalTo(@36);
    }];
    bottomLine = [self backLineView];
    [self.receiptTitle addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.receiptTitle);
        make.height.equalTo(@1);
        make.left.equalTo(self.receiptTitle);
        make.right.equalTo(self.receiptTitle);
    }];
    
    [self.receiptDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receiptTitle.mas_bottom);
        make.left.equalTo(self.receiptTitle).with.offset(6);
        make.right.equalTo(superView);
        make.height.equalTo(@83);
    }];
    bottomLine = [self backLineView];
    [self.view addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.receiptDetail);
        make.height.equalTo(@1);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    
    [self.reasonTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receiptDetail.mas_bottom).with.offset(8);
        make.left.equalTo(self.receiptDetail);
    }];
    [self.reasonText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reasonTitle.mas_bottom).with.offset(8);
        make.left.equalTo(self.receiptTitle);
        make.right.equalTo(self.receiptTitle);
        make.height.equalTo(@69);
    }];
    
    [self.wuliuView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.receiptView.mas_bottom).with.offset(12);
        make.height.equalTo(@105);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
    }];
    bottomLine = [self backLineView];
    [self.wuliuView addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.wuliuView);
        make.height.equalTo(@0.5);
        make.width.equalTo(self.wuliuView);
    }];
    
    superView = self.wuliuView;
    [self.carLogo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 15.5));
        make.left.equalTo(superView).with.offset(12);
        make.centerY.equalTo(superView).multipliedBy(0.5);
    }];
    [self.company mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carLogo);
        make.left.equalTo(self.carLogo.mas_right).with.offset(6);
    }];
    [self.triangleMark mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).with.offset(-8);
        make.centerY.equalTo(self.carLogo);
        make.size.mas_equalTo(CGSizeMake(11, 21));
    }];
    [self.wayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.carLogo);
        make.right.equalTo(self.triangleMark.mas_left).with.offset(-6);
    }];

    [self.orderNumber mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(21, 15.5));
        make.left.equalTo(self.carLogo);
        make.centerY.equalTo(superView).multipliedBy(1.5);
    }];
    [self.orderMark mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNumber.mas_right).with.offset(6);
        make.centerY.equalTo(self.orderNumber);
    }];
    [self.commitBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wayBtn);
        make.right.equalTo(self.triangleMark);
        make.centerY.equalTo(self.orderNumber);
    }];
    [self.orderText mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.commitBtn);
        make.centerY.equalTo(self.orderNumber);
        make.left.equalTo(self.orderMark.mas_right).with.offset(15);
        make.right.equalTo(self.commitBtn.mas_left).with.offset(-10);
    }];
}

- (UIView *)backLineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

- (void)addSubViews {
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    
    [self.view addSubview:self.salesReturnImage];
    [self.view addSubview:self.salesReturnMark];
    [self.view addSubview:self.goodsDescription];
    [self.view addSubview:self.supplier];
    [self.view addSubview:self.receiptView];
    [self.view addSubview:self.receiptTitle];
    [self.view addSubview:self.receiptDetail];
    [self.view addSubview:self.reasonTitle];
    [self.view addSubview:self.reasonText];
    [self.view addSubview:self.wuliuView];
    
    [self.wuliuView addSubview:self.carLogo];
    [self.wuliuView addSubview:self.orderNumber];
    [self.wuliuView addSubview:self.company];
    [self.wuliuView addSubview:self.orderMark];
    [self.wuliuView addSubview:self.triangleMark];
    [self.wuliuView addSubview:self.wayBtn];
    [self.wuliuView addSubview:self.wayBtn];
    [self.wuliuView addSubview:self.orderText];
    [self.wuliuView addSubview:self.commitBtn];
}

#pragma mark - getters and settters

- (NSNumber *)wuliuID:(NSInteger)index {
    NSDictionary *wuliuDetail = self.companyDetail[index];
    return wuliuDetail[@"id"];
}

- (NSString *)wuliuCompanyName:(NSInteger)index {
    NSDictionary *wuliuDetail = self.companyDetail[index];
    return wuliuDetail[@"companyName"];
}

- (void)setCompanyList:(NSArray *)companyList
{
    self.companyDetail = companyList;
}

- (void)setGoodsName:(NSString *)goodsName
{
    self.goodsDescription.text = goodsName;
}
- (void)setReturnReason:(NSString *)reason;
{
    self.reasonText.text = reason;
}
- (void)setRecieveAddress:(NSString *)address
{
    self.receiptDetail.text = address;
}

- (UIButton *)wayBtn {
    if (_wayBtn == nil) {
        _wayBtn = [[UIButton alloc] init];
        [_wayBtn setTitle:[self wuliuCompanyName:0] forState:UIControlStateNormal];
        [_wayBtn addTarget:self action:@selector(changeWay) forControlEvents:UIControlEventTouchUpInside];
    }
    [_wayBtn setTitleColor:labelTextColor forState:UIControlStateNormal];
    return _wayBtn;
}

- (UITextField *)orderText {
    if (_orderText == nil) {
        _orderText = [[UITextField alloc] init];
        _orderText.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _orderText.delegate = self;
        _orderText.keyboardType = UIKeyboardTypeNamePhonePad;
        _orderText.layer.cornerRadius = 5.0;
    }
//    [_orderText setContentCompressionResistancePriority:752 forAxis:UILayoutConstraintAxisHorizontal];

    return _orderText;
}

- (UIButton *)commitBtn {
    if (_commitBtn == nil) {
        _commitBtn = [[UIButton alloc] init];
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _commitBtn.backgroundColor = UIColorFromRGB(0x05172);
        [_commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.layer.cornerRadius = 5.0;
    }
    
    return _commitBtn;
}

- (UIImageView *)triangleMark {
    if (_triangleMark == nil) {
        _triangleMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MORED"]];
    }
    
    return _triangleMark;
}

- (UILabel *)orderMark {
    if (_orderMark == nil) {
        _orderMark = [self standLabel];
        _orderMark.text = @"物流单号";
        [_orderMark setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisHorizontal];
    }

    return _orderMark;
}

- (UILabel *)company {
    if (_company == nil) {
        _company = [self standLabel];
        _company.text = @"物流公司";
    }

    return _company;
}

- (UIImageView *)orderNumber {
    if (_orderNumber == nil) {
        _orderNumber = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"danhao"]];
    }

    return _orderNumber;
}

- (UIImageView *)carLogo {
    if (_carLogo == nil) {
        _carLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car"]];
    }

    return _carLogo;
}

- (UIView *)wuliuView {
    if (_wuliuView == nil) {
        _wuliuView = [[UIView alloc] init];
        _wuliuView.backgroundColor = [UIColor whiteColor];
    }
    
    return _wuliuView;
}

- (UITextField *)reasonText {
    if (_reasonText == nil) {
        _reasonText = [[UITextField alloc] init];
        _reasonText.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _reasonText.userInteractionEnabled = NO;
        _reasonText.text = @"不想要了,后悔了";
        _reasonText.textColor = labelTextColor;
        _reasonText.font = lableFont;
        _reasonText.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
        _reasonText.leftViewMode = UITextFieldViewModeAlways;
        _reasonText.leftView = leftView;
    }

    return _reasonText;
}

- (UILabel *)reasonTitle {
    if (_reasonTitle == nil) {
        _reasonTitle = [self standLabel];
        _reasonTitle.text = @"退货问题描述:";
    }
    
    return _reasonTitle;
}

- (UILabel *)receiptDetail {
    if (_receiptDetail == nil) {
        _receiptDetail = [self standLabel];
        _receiptDetail.numberOfLines = 0;
        _receiptDetail.text = @"商户收货信息: \n \n 广东省深圳市xxxxxxx \n\n";
    }

    return _receiptDetail;
}

- (UILabel *)receiptTitle {
    if (_receiptTitle == nil) {
        _receiptTitle = [self standLabel];
        _receiptTitle.text = @"服务单收货详情";
    }

    return _receiptTitle;
}

- (UIView *)receiptView {
    if (_receiptView == nil) {
        _receiptView = [[UIView alloc] init];
        _receiptView.backgroundColor = [UIColor whiteColor];
    }

    return _receiptView;
}

- (UILabel *)supplier {
    if (_supplier == nil) {
        _supplier = [[UILabel alloc] init];
        _supplier.font = lableFont;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"本次退货服务由 云e生 为您提供"];
        [attributedString setAttributes:@{NSForegroundColorAttributeName : labelTextColor} range:NSMakeRange(0, attributedString.length)];
        NSRange range = [attributedString.string rangeOfString:@"云e生"];
        [attributedString setAttributes:@{NSForegroundColorAttributeName : status_color} range:range];
        _supplier.attributedText = attributedString.copy;
        _supplier.backgroundColor = [UIColor whiteColor];
        _supplier.textAlignment = NSTextAlignmentCenter;
    }
    
    return _supplier;
}

- (UILabel *)goodsDescription {
    if (_goodsDescription == nil) {
        _goodsDescription = [[UILabel alloc] init];
        _goodsDescription.textColor = [UIColor whiteColor];
        _goodsDescription.text = @"索尼SmartBand Talk SWR30 \n 可穿戴设备只能通话手表";
        _goodsDescription.numberOfLines = 2;
        _goodsDescription.font = lableFont;
    }

    return _goodsDescription;
}

- (UIImageView *)salesReturnMark {
    if (_salesReturnMark == nil) {
        _salesReturnMark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tui"]];
    }
    
    return _salesReturnMark;
}

- (UIImageView *)salesReturnImage {
    if (_salesReturnImage == nil) {
        _salesReturnImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titleo"]];
    }
    
    return _salesReturnImage;
}

- (UILabel *)standLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = lableFont;
    label.textColor = labelTextColor;
    return label;
}

#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self addSubViews];
    [self setViewsMASConstraint];
    [self setUIContent];
    
}

- (void)jumpVC {
    SalesReturnListVC *VC = [[SalesReturnListVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end

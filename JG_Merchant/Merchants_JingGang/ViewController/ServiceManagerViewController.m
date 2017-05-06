//
//  ServiceManagerViewController.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "ServiceManagerViewController.h"
#import "XKJHPackageManagerController.h"

@interface ServiceManagerViewController ()

@property (nonatomic) UIButton *taocanButton;
@property (nonatomic) UIButton *xianjinButton;
@property (nonatomic) UIImageView *xianjingImageView;
@property (nonatomic) UIImageView *taocanImageView;
@property (nonatomic) UILabel *xianjingLabel;
@property (nonatomic) UILabel *taocanLabel;

@end

@implementation ServiceManagerViewController

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.taocanButton];
    [self.view addSubview:self.xianjinButton];
    
    [self setUIContent];
    [self setViewsMASConstraint];
    [self RACProgress];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animate {
    [super viewWillDisappear:animate];
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate



#pragma mark - CustomDelegate



#pragma mark - event response

- (void)showTaocanList {
    DDLogDebug(@"显示套餐列表");
    
    XKJHPackageManagerController *packageManagerController = [[XKJHPackageManagerController alloc] init];
    packageManagerController.requestType = TicketManagerPackageType;
    [self.navigationController pushViewController:packageManagerController animated:YES];
}

- (void)showXianjinList {
    DDLogDebug(@"显示现金券列表");
    
    XKJHPackageManagerController *packageManagerController = [[XKJHPackageManagerController alloc] init];
    packageManagerController.requestType = TicketManagerCashType;
    [self.navigationController pushViewController:packageManagerController animated:YES];
}

#pragma mark - private methods

- (void)RACProgress {
    
}

- (void)setBarButtonItem {

}

- (void)setNavigationBar {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    navBar.backgroundColor = status_color;
}

- (void)setUIContent {
    [self setNavigationBar];
    [self setBarButtonItem];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"服务管理";
    self.view.backgroundColor = background_Color;
    self.taocanButton.layer.cornerRadius = 5.0;
    self.xianjinButton.layer.cornerRadius = 5.0;
    
    [self.xianjinButton addTarget:self action:@selector(showTaocanList) forControlEvents:UIControlEventTouchUpInside];
    [self.taocanButton addTarget:self action:@selector(showXianjinList) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setViewsMASConstraint {
    UIView *superView = self.view;
    [self.taocanButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(10);
        make.right.equalTo(superView).with.offset(-10);
        make.top.equalTo(superView).with.offset(10);
        make.height.equalTo(@(88));
    }];
    [self.xianjinButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.taocanButton);
        make.right.equalTo(self.taocanButton);
        make.height.equalTo(self.taocanButton);
        make.top.equalTo(self.taocanButton.mas_bottom).with.offset(10);
    }];
    
    superView = self.taocanButton;
    [self.xianjingImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(superView).with.offset(17);
    }];
    [self.xianjingLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.xianjingImageView.mas_bottom).with.offset(8);
        make.centerX.equalTo(superView);
    }];
    
    superView = self.xianjinButton;
    [self.taocanImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView);
        make.top.equalTo(superView).with.offset(17);
    }];
    [self.taocanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.taocanImageView.mas_bottom).with.offset(8);
        make.centerX.equalTo(superView);
    }];
}

#pragma mark - getters and settters

- (UIButton *)xianjinButton {
    if (_xianjinButton == nil) {
        _xianjinButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _xianjinButton.backgroundColor = UIColorFromRGB(0x0bc0ca);
        
        _taocanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Package vouchers"]];
        _taocanLabel = [[UILabel alloc] init];
        _taocanLabel.textColor = [UIColor whiteColor];
        _taocanLabel.text = @"套餐券管理";
        [_xianjinButton addSubview:_taocanLabel];
        [_xianjinButton addSubview:_taocanImageView];
    }
    return _xianjinButton;
}

- (UIButton *)taocanButton {
    if (_taocanButton == nil) {
        _taocanButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _taocanButton.backgroundColor = UIColorFromRGB(0xff663c);
        
        _xianjingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Coupons"]];
        _xianjingLabel = [[UILabel alloc] init];
        _xianjingLabel.textColor = [UIColor whiteColor];
        _xianjingLabel.text = @"现金券管理";
        [_taocanButton addSubview:_xianjingImageView];
        [_taocanButton addSubview:_xianjingLabel];
    }
    
    return _taocanButton;
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self viewDidLoad];
    
    
}


@end

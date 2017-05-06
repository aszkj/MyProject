//
//  MerchantManagerViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/18.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "MerchantManagerViewController.h"
#import "MerchantManageView.h"
#import "MerchantManageSelectView.h"

@interface MerchantManagerViewController () {

    MerchantManageView *_merchantLeftView;
    MerchantManageView *_merchantRightView;
    MerchantManageSelectView *_merchantManageSelectView;
}

@property (nonatomic, strong)MerchantManageView *merchantLeftView;
@property (nonatomic, strong)MerchantManageView *merchantRightView;

@end

@implementation MerchantManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _initTopView];
    
    [self _initContentLeftView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _merchantManageSelectView.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    _merchantManageSelectView.hidden = YES;
}


#pragma mark ----------------------- private Method -----------------------
- (void)_initContentLeftView {
    _merchantLeftView = [[MerchantManageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_merchantLeftView];
    _merchantLeftView.hidden = NO;
//    _merchantLeftView.merchantManagerHelper.merchantType = LishuMerchantType;
    _merchantLeftView.merchantType = LishuMerchantType;
    
}

- (void)_initTopView {
    
    _merchantManageSelectView = BoundNibView(@"MerchantManageSelectView", MerchantManageSelectView);
    CGFloat topEdge = 17;
    [self.navigationController.view addSubview:_merchantManageSelectView];
    [_merchantManageSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topEdge);
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.centerX.mas_equalTo(self.navigationController.view);
    }];
    if (iOS7) {
        _merchantManageSelectView.frame = CGRectMake((kScreenWidth-200)/2, topEdge, 200, 50);
    }
    WEAK_SELF
    _merchantManageSelectView.selectTopWitchBlock = ^(NSInteger index){
        if (index == 1) {//显示右边
            weak_self.merchantLeftView.hidden = YES;
            weak_self.merchantRightView.hidden = NO;
        }else{//显示左边
            weak_self.merchantLeftView.hidden = NO;
            weak_self.merchantRightView.hidden = YES;
        }
    };
}

#pragma mark - 右边视图懒加载
-(MerchantManageView *)merchantRightView {

    if (!_merchantRightView) {
        _merchantRightView = [[MerchantManageView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_merchantRightView];
        _merchantRightView.hidden = YES;
//        _merchantRightView.merchantManagerHelper.merchantType = XiaNeiMerchantType;
        _merchantRightView.merchantType = XiaNeiMerchantType;
    }
    return _merchantRightView;
}



@end

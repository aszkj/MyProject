//
//  XKO_BaseViewController.m
//  Operator_JingGang
//
//  Created by ray on 15/9/17.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "XKO_BaseViewController.h"
#import "XKO_CreateUIViewHelper.h"
#import "KJLoginController.h"

@interface XKO_BaseViewController ()

@end

@implementation XKO_BaseViewController


#pragma mark - life cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataCenter.delegate = self;
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.dataCenter.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc -- %s",__FUNCTION__);
    [self.dataCenter cancelRequest];
    self.dataCenter.delegate = nil;
    self.dataCenter = nil;
    [self.viewModel.client.dataCenter cancelRequest];
    self.viewModel.client.dataCenter.delegate = nil;
    self.viewModel.client.dataCenter = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    [self setUIAppearance];
}

- (void)bindViewModel {
    @weakify(self);
    RAC(self,title) = RACObserve(self.viewModel, title);
    [RACObserve(self.viewModel, isExcuting) subscribeNext:^(NSNumber *isExcuting) {
        @strongify(self);
        if ([isExcuting boolValue]) {
            [self.view showLoading];
            self.viewModel.active = YES;
        }
        else    [self.view hideLoading];
    }];
    [[RACObserve(self.viewModel, error) filter:^BOOL(NSError *value) {
        return value != nil;
    }] subscribeNext:^(NSError *error) {
        @strongify(self);
        if (self.closeDefaultErrorInform) return;
        NSString *errorMessage = @"未知错误";
        if (error.localizedDescription.length > 0) {
            errorMessage = error.localizedDescription;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        if (error.code == 2 || [errorMessage containsString:KInvalidTokenErrorCode]) {
            [alertView setMessage:KInvalidTokenErrorCode];
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
                KJLoginController *login = [[KJLoginController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
                [kUserDefaults removeObjectForKey:Token];
                [kUserDefaults synchronize];
                self.view.window.rootViewController = nav;
            }];
        } else {
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
//                [self errorHandle:error];
            }];
        }
        
        [alertView show];
    }];
}

#pragma mark - private methods
- (void)errorHandle:(NSError *)error {
    NSString *errorMessage = @"未知错误";
    if (error.localizedDescription.length > 0) {
        errorMessage = error.localizedDescription;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:errorMessage delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    if (error.code == 2 || [errorMessage containsString:KInvalidTokenErrorCode]) {
        [alertView setMessage:KInvalidTokenErrorCode];
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber *indexNumber) {
            KJLoginController *login = [[KJLoginController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
            [kUserDefaults removeObjectForKey:Token];
            [kUserDefaults synchronize];
            self.view.window.rootViewController = nav;
        }];
    }
    [alertView show];
}

- (XKO_ViewModel *)viewModel {
    return nil;
}

- (XKO_HttpRequestHelper *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[XKO_HttpRequestHelper alloc] init];
    }
    
    return _dataCenter;
}

- (void)setBarButtonItem {
    if (self.navigationController.viewControllers.count == 1) return;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(btnClick) target:self];
}

- (void)btnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUIAppearance {
    [self setBarButtonItem];
    self.view.backgroundColor = VCBackgroundColor;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark - 创建UI

// 创建frame为CGRectZero的UILabel
- (UILabel *)createLabelWithFont:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text{
    
    return [XKO_CreateUIViewHelper createLabelWithFont:font fontColor:fontColor text:text];
}

// 创建frame为CGRectZero的UIImageView
- (UIImageView *)createUIImageViewWithImage:(UIImage *)image {
    
    return [XKO_CreateUIViewHelper createUIImageViewWithImage:image];
}

// 创建frame为CGRectZero的UIButton
- (UIButton *)createUIButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC{
    
    return [XKO_CreateUIViewHelper createUIButtonWithTitle:title titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor hasRadius:hasRadius targetSelector:selector target:targetVC];
}

// 创建frame为CGRectZero的UIView
- (UIView *)createUIViewWithBackgroundColor:(UIColor *)backgroundColor {
    
    return [XKO_CreateUIViewHelper createUIViewWithBackgroundColor:backgroundColor];
}

// 带frame
// 创建带frame的UILabel
- (UILabel *)createLabelWithFrame:(CGRect)frame font:(UIFont *)font fontColor:(UIColor *)fontColor text:(NSString *)text {
    
    return [XKO_CreateUIViewHelper createLabelWithFrame:frame font:font fontColor:fontColor text:text];
}

// 创建带frame的UIImageView
- (UIImageView *)createUIImageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    
    return [XKO_CreateUIViewHelper createUIImageViewWithFrame:frame image:image];
}

// 创建带frame的UIButton
- (UIButton *)createUIButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backgroundColor:(UIColor *)backgroundColor hasRadius:(BOOL)hasRadius targetSelector:(SEL)selector target:(id)targetVC {
    
    return [XKO_CreateUIViewHelper createUIButtonWithFrame:frame title:title titleColor:titleColor titleFont:titleFont backgroundColor:backgroundColor hasRadius:hasRadius targetSelector:selector target:targetVC];
}

// 创建带frame的UIView
- (UIView *)createUIViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor {
    
    return [XKO_CreateUIViewHelper createUIViewWithFrame:frame backgroundColor:backgroundColor];
}

#pragma mark - DataCenterDelegate

// 读取数据成功
- (void)loadingFinishedWithDataArray:(NSArray *)dataArray methordName:(NSString *)methordName {
    
}

// 读取数据失败
- (void)loadingFailedWithErrorString:(NSError *)error methordName:(NSString *)methordName {
    
}


@end

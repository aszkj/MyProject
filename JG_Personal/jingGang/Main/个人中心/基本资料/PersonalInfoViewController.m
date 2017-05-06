//
//  PersonalInfoViewController.m
//  jingGang
//
//  Created by ray on 15/11/24.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "ChangeLoginViewController.h"
#import "UserInfoViewController.h"
#import "ChangYunbiPasswordViewController.h"
#import "TLTitleSelectorView.h"

@interface PersonalInfoViewController () <UIScrollViewDelegate>

@property (nonatomic) ChangeLoginViewController *changeLoginVC;
@property (nonatomic) UserInfoViewController *userInfoVC;
@property (nonatomic) ChangYunbiPasswordViewController *changeYunbiVC;
@property (nonatomic) UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet TLTitleSelectorView *titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation PersonalInfoViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleView setSelectorTitles:@"用户资料",@"修改密码",@"修改云币密码",nil];
    self.changeYunbiVC = [[ChangYunbiPasswordViewController alloc] init];
    self.changeLoginVC = [[ChangeLoginViewController alloc] init];
    self.userInfoVC = [[UserInfoViewController alloc] init];
    [self addChildViewController:self.changeLoginVC];
    [self addChildViewController:self.changeYunbiVC];
    [self addChildViewController:self.userInfoVC];
    [self.scrollView addSubview:self.changeLoginVC.view];
    [self.scrollView addSubview:self.changeYunbiVC.view];
    [self.scrollView addSubview:self.userInfoVC.view];

    [self setViewsMASConstraint];
}

- (void)bindViewModel {
    [super bindViewModel];
    WEAK_SELF
    self.titleView.buttonPressBlock = ^(NSInteger index) {
        CGPoint point = CGPointMake(index * __MainScreen_Width, 0);
        [weak_self.scrollView setContentOffset:point animated:YES];
    };
    
}

#pragma mark - event response

- (void)confirmAction {
//    CGPoint point = self.scrollView.contentOffset;
//    NSInteger currentPage = (int)(point.x / __MainScreen_Width);
//    if (currentPage == 0) {
////        [self.userInfoVC changeAction];
//    } else if (currentPage == 1) {
////        [self.changeLoginVC changeAction];
//    } else if (currentPage == 2) {
////        [self.changeYunbiVC changeAction];
//    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = self.scrollView.contentOffset;
    NSInteger currentPage = (int)(point.x / __MainScreen_Width);
    [self.titleView setSelectedIndex:currentPage];
}


#pragma mark - private methods


- (void)setUIAppearance {
    [super setUIAppearance];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.confirmButton];
    self.title = @"个人资料";
}

- (void)setViewsMASConstraint {
    [self.userInfoVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
    }];
    [self.changeLoginVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@[self.scrollView,self.changeYunbiVC.view,self.userInfoVC.view]);
        make.width.equalTo(@[@(__MainScreen_Width),self.changeYunbiVC.view,self.userInfoVC.view]);
        make.top.equalTo(@[self.scrollView,self.changeYunbiVC.view,self.userInfoVC.view]);
        make.bottom.equalTo(@[self.scrollView,self.changeYunbiVC.view,self.userInfoVC.view]);
        make.left.equalTo(self.userInfoVC.view.mas_right);
    }];
    [self.changeYunbiVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.changeLoginVC.view.mas_right);
        make.right.equalTo(self.scrollView);
    }];
   
    
}

#pragma mark - getters and settters

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(0, 0, 40, 35);
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


#pragma mark - debug operation
- (void)updateOnClassInjection {
    [self setViewsMASConstraint];
    NSLog(@"%@",self.changeYunbiVC.view);
}


@end

//
//  OptionViewController.m
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OptionViewController.h"
#import "Masonry.h"
#import "GlobeObject.h"
#import "PublicInfo.h"

@interface OptionViewController ()

@property (weak, nonatomic) IBOutlet UIView   *bottomView;
@property (weak, nonatomic) IBOutlet UILabel  *cancelLB;
@property (weak, nonatomic) IBOutlet UILabel  *gouwuLB;
@property (weak, nonatomic) IBOutlet UILabel  *buyLB;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelWatchBtn;
@property (weak, nonatomic) IBOutlet UIButton *addToGouWuBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UIView   *frontView;

@end

@implementation OptionViewController

#define defaultTextColor UIColorFromRGB(0x666666)

#pragma mark - life cycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad{
    
    [self setUIContent];
    [self setViewsMASConstraint];
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    
}

- (void)viewDidLayoutSubviews {
}

#pragma mark - UITableViewDelegate



#pragma mark - CustomDelegate



#pragma mark - event response

- (IBAction)dismissView:(id)sender {
    UIView *view = self.view;
    if (view.superview != nil) {
        [view removeFromSuperview];
    }
}

- (IBAction)cancelWatchAction:(id)sender {
    NSLog(@"取消关注:--");
    [self dismissView:nil];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (IBAction)intoGouWu:(id)sender {
    NSLog(@"加入购物车:--");
    [self dismissView:nil];
    //TODO:带完成加入购物车、立即购买跳转
    if (self.addShoppingBlock)
    {
        self.addShoppingBlock();
    }

}

- (IBAction)buyAction:(id)sender {
    NSLog(@"立即购买:--");
    [self dismissView:nil];
    if (self.buyCurrentBlock)
    {
        self.buyCurrentBlock();
    }
}

#pragma mark - private methods

- (void)setUIContent
{
    self.bottomView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.bottomView.tintColor = defaultTextColor;
    self.cancelLB.textColor = defaultTextColor;
    self.buyLB.textColor = defaultTextColor;
    self.gouwuLB.textColor = defaultTextColor;
//    self.cancelBtn.layer.borderColor = defaultTextColor.CGColor;
    if (self.isServerView) {
        self.gouwuLB.hidden = YES;
        self.addToGouWuBtn.hidden = YES;
    }
    self.cancelLB.text = @"取消收藏";
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.view;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@187);
        make.bottom.equalTo(superView);
    }];
    [self.frontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    superView = self.bottomView;
    [self.cancelWatchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(35);
        make.left.equalTo(self.cancelBtn);
        make.size.mas_equalTo(CGSizeMake(53.5, 53.5));
    }];
    [self.cancelLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.cancelWatchBtn);
        make.top.equalTo(self.cancelWatchBtn.mas_bottom).with.offset(6);
    }];

    [self.addToGouWuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.cancelWatchBtn);
        make.centerY.equalTo(self.cancelWatchBtn);
        make.centerX.equalTo(superView);
    }];
    [self.gouwuLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelLB);
        make.centerX.equalTo(self.addToGouWuBtn);
    }];
    
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.cancelWatchBtn);
        make.right.equalTo(self.cancelBtn);
        make.centerY.equalTo(self.cancelWatchBtn);
    }];
    [self.buyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelLB);
        make.centerX.equalTo(self.buyBtn);
    }];
    
    if (self.isServerView) {
        [self.buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.addToGouWuBtn);
        }];
        [self.buyLB mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.gouwuLB);
        }];
    }
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView).with.offset(-14);
        make.left.equalTo(superView).with.offset(38);
        make.right.equalTo(superView).with.offset(-38);
        make.height.equalTo(@44);
    }];
}

#pragma mark - getters and settters

@end

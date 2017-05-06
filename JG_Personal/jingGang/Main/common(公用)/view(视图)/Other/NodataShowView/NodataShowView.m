//
//  NodataShowView.m
//  jingGang
//
//  Created by 张康健 on 15/8/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "NodataShowView.h"
#import "Masonry.h"
#import "GlobeObject.h"
#import "MBProgressHUD.h"

@interface NodataShowView()
@property (nonatomic, copy)ReloadBlock reloadBlock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showStatusImgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showImgStatusWidthConstraint;

@property (nonatomic,strong)NSString *alertStr;
@property (nonatomic,strong)NSString *alertImageName;
@property (nonatomic,strong)NodataShowView *nodataView;

@end
@implementation NodataShowView

+(id)showInContentView:(UIView *)contentView withReloadBlock:(ReloadBlock)reloadBlock requestResultType:(NetWorkRequestResultType)requestResultType
{
    [[self class] hideInContentView:contentView];
    NodataShowView *sel = [self shareNodataView];
    sel.reloadBlock = reloadBlock;
    sel.tag = -1000;
    [contentView addSubview:sel];
    sel.frame = CGRectMake(0, 0, CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds));
    NSString *showImgName = @"nodate-6+.png";
    NSString *alertTitle = @"";
    if (requestResultType == NoDataType) {//没有数据
        alertTitle = @"数据为空，刷新试试";
    } else if (requestResultType == No_OrderType){//没有订单
        alertTitle = @"没有订单";
        showImgName = @"Order form";
    } else if (requestResultType == MerchantIsEmpty) {//没有商家
        alertTitle = @"暂无此类商家,请看看别的吧";
    }else if (requestResultType == No_GoodsConsultType){
        alertTitle = @"暂无咨询";
    }else{
        alertTitle = @"网络加载失败，请重新加载";
    }
    [sel.alertButton setTitle:alertTitle forState:UIControlStateNormal];
    UIImage *showImage = [UIImage imageNamed:showImgName];
    CGFloat widthHeightPercent = showImage.size.height / showImage.size.width;
    sel.showStatusImgViewHeightConstraint.constant = sel.showImgStatusWidthConstraint.constant * widthHeightPercent;
    sel.showStatusImgView.image = showImage;

    return sel;
}

+(void)showInContentView:(UIView *)contentView
         withReloadBlock:(ReloadBlock)reloadBlock
              alertTitle:(NSString *)alertTitle
{
    NSString *alertImageName = @"nodate-6+.png";
    if (!alertTitle) {
        alertTitle = @"暂无数据";
    }
    [self _comminSetWithContentView:contentView withReloadBlock:reloadBlock alertTitle:alertTitle alertImageName:alertImageName];
}


+(void)showInContentView:(UIView *)contentView
       withReloadBlock:(ReloadBlock)reloadBlock
            alertTitle:(NSString *)alertTitle
        alertImageName:(NSString *)alertImageName
{
    
    if (!alertTitle) {
        alertTitle = @"暂无数据";
    }
    if (!alertImageName) {
        alertImageName = @"nodate-6+.png";
    }
    
    [self _comminSetWithContentView:contentView withReloadBlock:reloadBlock alertTitle:alertTitle alertImageName:alertImageName];

}


+(void)_comminSetWithContentView:(UIView *)contentView withReloadBlock:(ReloadBlock)reloadBlock  alertTitle:(NSString *)alertTitle alertImageName:(NSString *)alertImageName{
    
    [[self class] hideInContentView:contentView];
    NodataShowView *sel = [self shareNodataView];
    sel.reloadBlock = reloadBlock;
    sel.tag = -1000;
    [contentView addSubview:sel];
    sel.frame = CGRectMake(0, 0, CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds));
    [sel.alertButton setTitle:alertTitle forState:UIControlStateNormal];
    UIImage *showImage = [UIImage imageNamed:alertImageName];
    CGFloat widthHeightPercent = showImage.size.height / showImage.size.width;
    sel.showStatusImgViewHeightConstraint.constant = sel.showImgStatusWidthConstraint.constant * widthHeightPercent;
    sel.showStatusImgView.image = showImage;
    
}


+ (void)hideInContentView:(UIView *)contentView {
    if ([contentView viewWithTag:-1000]) {
        [[contentView viewWithTag:-1000] removeFromSuperview];
    }
}

+ (void)showLoadingInView:(UIView *)contentView {
    [[self class] hideInContentView:contentView];
    UIView *loadingView = [MBProgressHUD showHUDAddedTo:contentView animated:YES];
    loadingView.tag = -1000;
}

- (void)awakeFromNib {

    self.alertButton.titleLabel.numberOfLines = 0;

}

+ (NodataShowView *)shareNodataView {
    
    return BoundNibView(@"NodataShowView", NodataShowView);
    
}

-(void)hide {
    
    [self removeFromSuperview];
}

- (IBAction)reloadAction:(id)sender {
    
    if (self.reloadBlock) {
        self.reloadBlock();
        [self removeFromSuperview];
        self.hidden = YES;
    }
}


@end

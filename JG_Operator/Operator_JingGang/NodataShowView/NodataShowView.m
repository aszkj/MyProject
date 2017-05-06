//
//  NodataShowView.m
//  jingGang
//
//  Created by 张康健 on 15/8/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "NodataShowView.h"
#import "Masonry.h"
#import "MBProgressHUD.h"

@interface NodataShowView()
@property (nonatomic, copy)ReloadBlock reloadBlock;
@property (weak, nonatomic) IBOutlet UIButton *alertButton;
@property (weak, nonatomic) IBOutlet UIImageView *showStatusImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showStatusImgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showImgStatusWidthConstraint;

@end
@implementation NodataShowView

+(id)showInContentView:(UIView *)contentView withReloadBlock:(ReloadBlock)reloadBlock requestResultType:(NetWorkRequestResultType)requestResultType
{
    [[self class] hideInContentView:contentView];
    NodataShowView *sel = [self shareNodataView];
    sel.reloadBlock = reloadBlock;
    sel.tag = -1000;
    [contentView addSubview:sel];
//    [sel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(contentView);
//    }];
    sel.frame = CGRectMake(0, 0, CGRectGetWidth(contentView.bounds), CGRectGetHeight(contentView.bounds));
    NSString *showImgName = @"nodate-6+.png";
    NSString *alertTitle = @"";
    if (requestResultType == NoDataType) {//没有数据
        alertTitle = @"暂无记录";
    } else if (requestResultType == No_OrderType){//没有订单
        alertTitle = @"没有订单";
        showImgName = @"Order form";
    } else if (requestResultType == MerchantIsEmpty) {//没有商家
        alertTitle = @"暂无此类商家,请看看别的吧";
    } else if (requestResultType == No_ExpectType){
        alertTitle = @"暂无收益";
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

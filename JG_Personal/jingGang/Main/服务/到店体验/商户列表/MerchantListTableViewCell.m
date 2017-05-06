//
//  MerchantListTableViewCell.m
//  JingGangIB
//
//  Created by thinker on 15/9/10.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "MerchantListTableViewCell.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "APIManager.h"
#import "UIImageView+WebCache.h"
#import "Util.h"

@interface MerchantListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *signMark;
@property (weak, nonatomic) IBOutlet UIImageView *mapImage;
@property (weak, nonatomic) IBOutlet UIImageView *recommandImage;


@end

@implementation MerchantListTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content
- (void)configWithObject:(id)object {
    StoreSearch *storeSearch = object;
    [self.merchanImage sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(storeSearch.storeInfoPath,CGRectGetWidth(self.merchanImage.frame),CGRectGetHeight(self.merchanImage.frame))]
                         placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];
    self.shopName.text = storeSearch.storeName;
//    self.shopAddress.text = [@"地址:" stringByAppendingString:storeSearch.storeAddress];
    self.shopAddress.text = storeSearch.storeAddress;
    self.distance.text = [Util transferDistanceStrWithDistance:storeSearch.distance];
    self.starView.count = storeSearch.storeEvaluationAverage.integerValue;
}


#pragma mark - event response


#pragma mark - set UI init

- (void)setAppearence
{
    self.signMark.textColor = [UIColor whiteColor];
    self.signMark.backgroundColor = [UIColor clearColor];
    self.shopName.textColor = textBlackColor;
    self.shopAddress.textColor = textGrayColor;
    self.distance.textColor = textLightGrayColor;
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    UIView *topView = [self colorView:textLightGrayColor];
    [superView addSubview:topView];
    UIView *bottomView = [self colorView:textLightGrayColor];
    [superView addSubview:bottomView];
    UIView *whiteBackView = [self colorView:[UIColor whiteColor]];
    UIImageView *signBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"04_"]];
    [superView addSubview:signBackView];
    [superView addSubview:whiteBackView];
    [superView sendSubviewToBack:signBackView];
    [superView sendSubviewToBack:whiteBackView];
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(10);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
    [bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superView);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(0.5));
    }];
    [whiteBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    superView = whiteBackView;
    [self.merchanImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(125, 90));
        make.top.equalTo(superView).with.offset(10);
        make.left.equalTo(superView).with.offset(8);
        make.bottom.equalTo(superView).with.offset(-10);
    }];
    [self.shopName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.merchanImage).with.offset(10);
        make.left.equalTo(self.merchanImage.mas_right).with.offset(6);
        make.right.equalTo(self.signMark.mas_left).with.offset(6);
    }];
    
    [self.signMark setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
    [self.signMark setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisVertical];
    [self.signMark mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopName);
        make.right.equalTo(superView).with.offset(-10);
    }];
    [signBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signMark);
        make.width.equalTo(self.signMark);
        make.top.equalTo(self.signMark);
        make.height.equalTo(self.signMark);
    }];
    [self.recommandImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(11, 11));
        make.top.equalTo(self.shopName.mas_bottom).with.offset(8);
        make.left.equalTo(self.shopName);
    }];
    [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.recommandImage);
        make.width.mas_equalTo(@(80));
        make.top.equalTo(self.recommandImage);
        make.left.equalTo(self.recommandImage.mas_right).with.offset(6);
    }];
    [self.distance mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.signMark);
        make.centerY.equalTo(self.recommandImage);
    }];
    [self.mapImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(9, 12));
        make.centerY.equalTo(self.recommandImage);
        make.right.equalTo(self.distance.mas_left).with.offset(-3);
    }];
    [self.shopAddress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopName);
        make.right.equalTo(self.signMark);
        make.top.equalTo(self.distance.mas_bottom);
        make.bottom.equalTo(self.merchanImage).with.offset(-4);
    }];
}

#pragma mark - getters and settters
- (UIView *)colorView:(UIColor *)backgroundColor {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = backgroundColor;
    return view;
}

@end

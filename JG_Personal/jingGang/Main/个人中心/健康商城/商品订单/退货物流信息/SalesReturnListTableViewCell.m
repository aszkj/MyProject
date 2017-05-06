//
//  SalesReturnListTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SalesReturnListTableViewCell.h"
#import "Masonry.h"
#import "ShopCenterListReformer.h"
#import "UIImageView+WebCache.h"

@interface SalesReturnListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *operatBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *statusMark;

@end

@implementation SalesReturnListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setAppearence];
    [self setViewsMASConstraint];
}

#pragma mark - set UI content

- (void)configWithReformedOrder:(NSDictionary *)returnData
{
    NSInteger goodsReturnStatus = ((NSString *)returnData[returnGoodsKeyStatus]).integerValue;
    /*退货商品状态 -2为超过退货时间未能输入退货物流 -1为申请被拒绝，1为可以退货 5为退货申请中 6为审核通过可进行退货 7为退货中，10为退货完成,等待退款，11为平台退款完成*/
    if (-2 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusTimeout;
    } else if (-1 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusCheckFail;
    } else if (1 == goodsReturnStatus) {

    } else if (5 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusWaitCheck;
    } else if (6 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusWaitWrite;
    } else if (7 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusWaitMoney;
    } else if (10 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusWaitMoney;
    } else if (11 == goodsReturnStatus) {
        self.salesReturnStatus = TLSalesReturnStatusGetMoney;
    }
    
    
    self.goodsDetail.text = returnData[returnGoodsKeyGoodsName];
    NSString *goodsMainPhotoPath = returnData[returnGoodsKeyImagePath];
    [self.goodsLogo sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(goodsMainPhotoPath,self.goodsLogo.frame.size.width,self.goodsLogo.frame.size.width)] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}

- (void)setSalesReturnStatus:(TLSalesReturnStatus)salesReturnStatus {
    _salesReturnStatus = salesReturnStatus;
    
    if (TLSalesReturnStatusWaitCheck == salesReturnStatus) {
        [self.operatBtn setTitle:@"取消退货" forState:UIControlStateNormal];
        
    } else if (TLSalesReturnStatusWaitWrite == salesReturnStatus) {
        [self.operatBtn setTitle:@"填写物流" forState:UIControlStateNormal];
        self.statusMark.image = [UIImage imageNamed:@"zhuangtai02"];
        
    } else if (TLSalesReturnStatusWaitMoney == salesReturnStatus) {
        self.operatBtn.hidden = YES;
        self.statusMark.image = [UIImage imageNamed:@"zhuangtai03"];
        
    } else if (TLSalesReturnStatusGetMoney == salesReturnStatus) {
        [self.operatBtn setTitle:@"删除记录" forState:UIControlStateNormal];
        self.statusMark.image = [UIImage imageNamed:@"zhuangtai04"];
        
    } else if (TLSalesReturnStatusCheckFail == salesReturnStatus) {
        [self.operatBtn setTitle:@"删除记录" forState:UIControlStateNormal];
        self.statusMark.image = [UIImage imageNamed:@"zhuangtai05"];
    } else if (TLSalesReturnStatusTimeout == salesReturnStatus) {
        [self.operatBtn setTitle:@"删除记录" forState:UIControlStateNormal];
        self.statusMark.image = [UIImage imageNamed:@"zhuangtai05"];
    }
}

#pragma mark - event response

- (IBAction)operateAction:(id)sender {
    if (self.buttonPressBlock) {
        self.buttonPressBlock(self.salesReturnStatus,self.indexPath);
    }
}

#pragma mark - set UI init

- (void)setAppearence
{
    
}

#pragma mark - set Constraint

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(12);
        make.left.equalTo(superView);
        make.bottom.equalTo(superView);
        make.right.equalTo(superView);
    }];
    
    superView = self.backView;
    [self.goodsLogo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(77, 78));
        make.bottom.equalTo(superView).with.offset(-8.5);
        make.top.greaterThanOrEqualTo(superView).with.offset(8.5);
        make.left.equalTo(superView).with.offset(8.5);
    }];
    [self.goodsDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsLogo.mas_right).with.offset(4);
        make.top.equalTo(self.goodsLogo);
        make.right.equalTo(superView).with.offset(-40);
    }];
    [self.statusMark mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.goodsLogo);
        make.left.equalTo(self.goodsDetail);
        make.height.equalTo(@20);
        make.right.lessThanOrEqualTo(self.operatBtn.mas_left).with.offset(-8);
    }];
    [self.operatBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).with.offset(-11);
        make.bottom.equalTo(self.statusMark);
    }];
}

@end

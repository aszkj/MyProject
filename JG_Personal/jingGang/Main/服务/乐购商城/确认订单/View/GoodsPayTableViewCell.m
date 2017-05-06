//
//  GoodsPayTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodsPayTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "GoodsDetailView.h"
#import "PublicInfo.h"
#import "Util.h"
#import "GlobeObject.h"
#import "GoodsManager.h"
#import "BRPlaceholderTextView.h"

@interface GoodsPayTableViewCell () <UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIView *goodsViews;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *payDetailView;
@property (weak, nonatomic) IBOutlet UIImageView *shopMark;
@property (weak, nonatomic) IBOutlet UIImageView *shop_icon;

@property (weak, nonatomic) IBOutlet UIView *youhuiView;
@property (weak, nonatomic) IBOutlet UIImageView *youhuiMark;

@property (weak, nonatomic) IBOutlet UIView *sendView;
@property (weak, nonatomic) IBOutlet UILabel *sendWayLB;
@property (weak, nonatomic) IBOutlet UILabel *sendWaySelect;

//@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet BRPlaceholderTextView *message;
@property (weak, nonatomic) IBOutlet UILabel *goodsTotalPrice;

@property (weak, nonatomic) IBOutlet UIImageView *mark;

@property (nonatomic) NSInteger totalCount;
@property (nonatomic) double transportPrice;
@property (nonatomic) double youhuiVaule;
@property (nonatomic) double jifengVaule;

@property (assign, nonatomic) NSInteger youhuiCount;

@property (strong,nonatomic) UILabel *youhuiCountLab;


@end


@implementation GoodsPayTableViewCell


- (void)awakeFromNib {
    // Initialization code
    [self setViewsMASConstraint];
    [self setAppearence];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark - UITextFieldDelegate

- (void)keyboardWillHidde
{
    if (self.textEditend) {
        self.textEditend(self.indexPath,self.feedMessage);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self keyboardWillHidde];
}

#pragma mark - set UI content

- (void)setYouhuiPrice:(double)youhuiPrice
{
    self.youhuiVaule = youhuiPrice;
    [self updateGoodTotalPrice];
}

- (void)setTransport:(NSString *)transport
{
    self.sendWaySelect.text = transport;
    float value = 0.0;
    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    value = [[transport stringByTrimmingCharactersInSet:nonDigits] floatValue];

    self.transportPrice = value;
    [self updateGoodTotalPrice];
}

- (NSString *)feedMessage {
    return self.message.text;
}

- (NSString *)transWay {
    NSString *transWay = self.sendWaySelect.text;
    if (transWay.length > 2) {
        transWay = [transWay substringToIndex:2];
    }
    return transWay;
}


- (void)setTotalPrice:(float)totalPrice count:(NSInteger)totalCount
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%lu件商品    合计: ¥%.2f",totalCount,totalPrice] ];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:15.0],NSFontAttributeName,
                                   status_color,NSForegroundColorAttributeName,
                                   nil
                                   ];
    NSRange range = [attributedString.string rangeOfString:@"¥"];
    range = NSMakeRange(range.location, attributedString.length - range.location);
    [attributedString addAttributes:attributeDict range:range];

    self.goodsTotalPrice.attributedText = attributedString.copy;
    [self setTotalPrice:@(totalPrice)];
}

- (void)updateGoodTotalPrice {
    
//    float totalPrice = self.goodsRealPrice + self.transportPrice - self.youhuiVaule - self.jifengVaule;
    [self setTotalPrice:self.totalPrice.floatValue count:self.totalCount];
}


- (void)configYouhuiList:(NSArray *)couponInfoArray
{
    if (couponInfoArray.count > 0) {
        [self setHasCouponInfoList:YES];
     } else {
         [self setHasCouponInfoList:NO];
     }
    self.youhuiCount = couponInfoArray.count;
    self.youhuiCountLab.text = [NSString stringWithFormat:@"%ld",couponInfoArray.count];
}

- (void)configShopManager:(ShopManager *)shopManager
{
    self.shopName.text = shopManager.shopName;
    JGLog(@"%@",shopManager.shopName);
    self.shop_icon.image = shopManager.shop_icon;
    self.totalCount = shopManager.totalCount;
    self.totalPrice = shopManager.totalPrice;
    
    for (UIView *subView in self.goodsViews.subviews) {
        [subView removeFromSuperview];
    }

    for (int i = 0; i < shopManager.goodsArray.count; i++) {
        GoodsManager *goodsCart = (GoodsManager *)shopManager.goodsArray[i];
        GoodsDetailView *goodsDetailView = [[NSBundle mainBundle] loadNibNamed:@"GoodsDetailView" owner:self options:nil].firstObject;
        NSString *goodsMainPhotoPath = goodsCart.goodsMainPhotoPath;
        [goodsDetailView.goodsLogo sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(goodsMainPhotoPath,goodsDetailView.goodsLogo.frame.size.width,goodsDetailView.goodsLogo.frame.size.width)] placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];
        
        NSNumber *goodsCurrentPrice = goodsCart.goodsCurrentPrice;
        if (goodsCart.hasMobilePrice) {
            goodsDetailView.phoneVIP.hidden = NO;
        }
        if (goodsCart.jifengDescrition != nil) {
            goodsDetailView.jifengLB.text = goodsCart.jifengDescrition;
        }
        goodsDetailView.goodsName.text = goodsCart.goodsName;
        goodsDetailView.goodsPrice.text = [NSString stringWithFormat:@"%.2f",goodsCurrentPrice.floatValue];
        
        goodsDetailView.goodsNumber.text = [NSString stringWithFormat:@"x%d",goodsCart.goodscount.intValue];
        goodsDetailView.goodsSpecInfo.text = [Util removeHTML2:goodsCart.goodsSpecInfo];
        [self.goodsViews addSubview:goodsDetailView];
        goodsDetailView.selectedBlock = ^(BOOL selectedBlock) {
            goodsCart.isSelectedIntegral = selectedBlock;
            if (self.selectJifengBlock) {
                self.selectJifengBlock();
            }
            [self setTotalPrice:shopManager.totalPrice.floatValue count:self.totalCount];
        };
    }
    
    [self setTotalPrice:shopManager.totalPrice.floatValue count:self.totalCount];
    [self remakeGoodsViewConstraints];
}

#pragma mark - event response
- (void)TapClick:(UITapGestureRecognizer *)tapGesture {
    UIView *view = tapGesture.view;
    UIColor *preColor = view.backgroundColor;
    UIColor *darkGrayColor = [UIColor lightGrayColor];
    view.backgroundColor = darkGrayColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.backgroundColor = preColor;
    });
    if (self.sendView == view && self.selecTransport) {
        self.selecTransport(self.indexPath);
    } else if (self.youhuiView == view && self.selecYouhui) {
        self.selecYouhui(self.indexPath);
    }
}

#pragma mark - set UI init

- (void)setAppearence
{
    self.message.delegate = self;
    self.message.placeholder = @"给卖家留言";
    [self.message setPlaceholderColor:[UIColor lightGrayColor]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidde) name:UIKeyboardDidHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    [self.sendView addGestureRecognizer:tap];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapClick:)];
    [self.youhuiView addGestureRecognizer:tap2];
}

#pragma mark - set Constraint

- (UIView *)lineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    return lineView;
}

- (void)setHasCouponInfoList:(BOOL)hasCouponInfoList
{
    _hasCouponInfoList = hasCouponInfoList;
//    self.youhuiView.hidden = !hasCouponInfoList;
    NSNumber *height = @(193/4);
    UIView *superView = self.payDetailView;
//    if (hasCouponInfoList) {
        [self.youhuiView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView);
            make.right.equalTo(superView);
            make.height.equalTo(height);
            make.top.equalTo(superView);
            make.bottom.equalTo(self.sendView.mas_top);
            
        }];
//    } else {
//        [self.youhuiView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(superView);
//            make.right.equalTo(superView);
//            make.height.equalTo(@0.0);
//            make.top.equalTo(superView);
//            make.bottom.equalTo(self.sendView.mas_top);
//            
//        }];
//    }

}

- (void)remakeGoodsViewConstraints
{
    for (int i = 0; i < self.goodsViews.subviews.count; i++) {
        GoodsDetailView *goodsDetailView = self.goodsViews.subviews[i];
        [goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.goodsViews);
            make.left.equalTo(self.goodsViews);
            if (goodsDetailView.jifengLB.text.length > 2) {
                make.height.equalTo(@(90+40));
            } else {
                make.height.equalTo(@(90));
            }
        }];
        
        if (goodsDetailView == self.goodsViews.subviews.firstObject) {
            [goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.goodsViews);
            }];
        } else {
            UIView *preView = self.goodsViews.subviews[i-1];
            [goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(preView.mas_bottom).with.offset(2);
            }];
        }
        
        if (goodsDetailView == self.goodsViews.subviews.lastObject) {
            [goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.goodsViews);
            }];
        
        }
    }
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(superView);
    }];
    [self.goodsViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(self.topView.mas_bottom);
//        make.bottom.equalTo(self.payDetailView.mas_top);
    }];
    [self.payDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(self.goodsViews.mas_bottom);
    }];
    
    CGFloat onePXHeight = 1 / [UIScreen mainScreen].scale;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
        make.top.equalTo(self.payDetailView.mas_bottom);
        make.height.equalTo(@(11+onePXHeight));
    }];
    UIView *lineView = [self lineView];
    [self.bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView);
        make.right.equalTo(self.bottomView.mas_right);
        make.top.equalTo(self.bottomView);
        make.height.equalTo(@(onePXHeight));
    }];
    
    superView = self.topView;
    CGFloat leftDis = 8;
    [self.shopMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).with.offset(leftDis);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(self.shopMark.mas_right).with.offset(6);
    }];
    [self.shop_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopName.mas_right);
        make.centerY.equalTo(superView);
        make.height.equalTo(@14);
        make.width.equalTo(@36);
    }];
    
    superView = self.payDetailView;
    NSNumber *height = @(193/4);
    [self.youhuiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(0));
        make.top.equalTo(superView);
        make.bottom.equalTo(self.sendView.mas_top);
    }];
    lineView = [self lineView];
    [self.youhuiView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.youhuiView).with.offset(leftDis);
        make.right.equalTo(self.youhuiView).with.offset(-leftDis);
        make.bottom.equalTo(self.youhuiView);
        make.height.equalTo(@(onePXHeight));
    }];
    
    [self.sendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.youhuiView.mas_bottom);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(height);
    }];
    lineView = [self lineView];
    [self.sendView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendView).with.offset(leftDis);
        make.right.equalTo(self.sendView).with.offset(-leftDis);
        make.bottom.equalTo(self.sendView);
        make.height.equalTo(@(onePXHeight));
    }];
    
    [self.message mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.greaterThanOrEqualTo(self.sendView);
        make.height.greaterThanOrEqualTo(@(60));
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(self.sendView.mas_bottom);
    }];
    lineView = [self lineView];
    [superView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.message).with.offset(leftDis);
        make.right.equalTo(self.message).with.offset(-leftDis);
        make.top.equalTo(self.message.mas_bottom);
        make.height.equalTo(@(onePXHeight));
    }];
    [self.goodsTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.message.mas_bottom);
        make.bottom.equalTo(superView);
        make.right.equalTo(superView).with.offset(-leftDis);
        make.height.equalTo(height);
    }];
    
    superView = self.youhuiView;
    [self.youhuiLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).with.offset(leftDis);
    }];
    [self.youhuiMark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(superView).with.offset(-leftDis);
        make.centerY.equalTo(self.youhuiLB);
        make.size.mas_equalTo(CGSizeMake(7, 17));
    }];
    
    UIImageView *countBackgroudImg = [[UIImageView alloc] init];
    countBackgroudImg.x = CGRectGetMaxX(self.youhuiLB.frame) - 10;
    countBackgroudImg.y = self.youhuiLB.y - 4;
    countBackgroudImg.width = 24;
    countBackgroudImg.height = 12;
    countBackgroudImg.image = [UIImage imageNamed:@"jg_icon_yhj"];
    countBackgroudImg.backgroundColor = [UIColor clearColor];
    [self.youhuiView addSubview:countBackgroudImg];
    
    UILabel *countBackgroudLab = [[UILabel alloc] init];
    countBackgroudLab.x = 0;
    countBackgroudLab.y = 0;
    countBackgroudLab.width = countBackgroudImg.width;
    countBackgroudLab.height = countBackgroudImg.height;
    countBackgroudLab.textColor = [UIColor whiteColor];
    countBackgroudLab.font = JGFont(12);
    countBackgroudLab.textAlignment = NSTextAlignmentCenter;
    countBackgroudLab.backgroundColor = [UIColor clearColor];
    [countBackgroudImg addSubview:countBackgroudLab];
    self.youhuiCountLab = countBackgroudLab;
    
    superView = self.sendView;
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 17));
        make.centerY.equalTo(superView);
        make.right.equalTo(superView).with.offset(-leftDis);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.width = 150;
    
    // 5s 20
    // 6 40
    lab.x = ScreenWidth - lab.width - 20;
    lab.y = self.mark.y - 15 ;
    lab.height = 30;
    lab.textAlignment = NSTextAlignmentRight;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = @"不使用优惠券";
    [self.youhuiView addSubview:lab];
    self.useCouponLab = lab;
    
    [self.sendWayLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).with.offset(leftDis);
    }];
    [self.sendWaySelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mark.mas_left).with.offset(-4);
        make.centerY.equalTo(superView);
    }];
}

@end

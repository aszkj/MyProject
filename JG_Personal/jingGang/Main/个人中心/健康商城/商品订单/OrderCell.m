//
//  OrderCell.m
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "OrderCell.h"
#import "PublicInfo.h"
#import "Masonry.h"
#import "ShopCenterListReformer.h"
#import "UIImageView+WebCache.h"
#import "WIntegralShopView.h"
#import "Util.h"

@interface OrderCell ()

@property (weak, nonatomic) IBOutlet UIView       *backVIew;
@property (weak, nonatomic) IBOutlet UIImageView  *shopType_Icon;
@property (weak, nonatomic) IBOutlet UILabel      *results;
@property (weak, nonatomic) IBOutlet UIView       *operateContainer;
@property (weak, nonatomic) IBOutlet UILabel      *orderNumberLB;
@property (weak, nonatomic) IBOutlet UIView       *grayView;
@property (weak, nonatomic) IBOutlet UILabel      *priceDetail;
@property (weak, nonatomic) IBOutlet UILabel      *usrName;
@property (nonatomic, strong) MASConstraint *grayHeightConstraint;
@property (strong,nonatomic) WIntegralShopView *shopView;

@property (nonatomic) NSArray *operateButtons;

@end


@implementation OrderCell

- (void)awakeFromNib {
    // Initialization code

    [self setAppearence];
    [self setViewsMASConstraint];
}



#pragma mark - event response

- (IBAction)tapAction:(id)sender {
    if (self.tapBlack) {
        self.tapBlack(self.indexPath);
    }
}

- (void)operateButtonsAction:(UIButton *)button
{
    if (self.buttonPressBlock) {
        self.buttonPressBlock(button.tag,self.indexPath);
    }
}

#pragma mark - config UI content

- (void)configWithReformedOrder:(NSDictionary *)orderData
{
    [self setOrderNumber:orderData[orderKeyOrderID]];
    self.usrName.text = [NSString stringWithFormat:@"收货人:%@",orderData[orderKeyReceiverName]];
    
    NSInteger orderStatus = ((NSNumber *)orderData[orderKeyStatus]).integerValue;
    if (0 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusClosed;
    } else if (10 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusWaitPay;
    } else if (20 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusWaitSend;
    } else if (30 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusWaitRecieve;
    } else if (40 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusWaitComment;
    } else if (50 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusPlusComment;
    } else if (65 == orderStatus) {
        self.purchaseStatus = TLPurchaseStatusTimeOut;
    }
    
    NSInteger count = ((NSNumber *)orderData[orderKeyGoodsCount]).integerValue;
    float totalPrice = ((NSNumber *)orderData[orderKeyTotalPrice]).floatValue;
    float transPrice = ((NSNumber *)orderData[orderKeyTransPrice]).floatValue;
    [self setPriceDetailWith:count price:totalPrice courier:transPrice];
   
}

- (void)setAddTime:(NSString *)addTime {
    JGLog(@"addTime:%@",addTime);
    NSString *timeString = [NSString stringWithFormat:@"下单时间:%@",addTime];
    self.shopView.addTimeLab.text = timeString;
}

- (void)setgoodsViews:(NSArray<__kindof GoodsInfo *> *)array {
    for (UIView *subview in self.grayView.subviews) {
        [subview removeFromSuperview];
    }
    BOOL hiddenSeperatedView = array.count > 1 ? NO : YES;
    [array enumerateObjectsUsingBlock:^(__kindof GoodsInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WIntegralShopView *shopView = [[NSBundle mainBundle] loadNibNamed:@"WIntegralShopView" owner:self options:nil][0];
        shopView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        shopView.seperateView.hidden = hiddenSeperatedView;
        if (!hiddenSeperatedView) {
            if (idx == array.count-1) {//最后一个隐藏
                shopView.seperateView.hidden = YES;
            }
        }
        UIImageView *goodsImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"com_cancel_pressed"]];
        [shopView.imageView sd_setImageWithURL:[NSURL URLWithString: TwiceImgUrlStr(obj.goodsMainphotoPath,goodsImage.frame.size.width,goodsImage.frame.size.width)] placeholderImage:[UIImage imageNamed:@"com_cancel_pressed"]];
        shopView.titleLabel.text = obj.goodsName;
        shopView.countLabel.text = [@"x" stringByAppendingString:obj.goodsCount.stringValue];
        NSString *string = [NSString stringWithFormat:@"%@ \n ￥%.2f",[Util removeHTML2:obj.goodsGspVal],obj.goodsPrice.floatValue];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributeString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:[string rangeOfString:[Util removeHTML2:obj.goodsGspVal]]];
        shopView.integralLabel.attributedText = attributeString.copy;
        [self.grayView addSubview:shopView];
        self.shopView = shopView;
    }];
    
    UIView *superview = self.grayView;
    [superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull goodsView, NSUInteger idx, BOOL * _Nonnull stop) {
        [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview);
            make.right.equalTo(superview);
            if (idx == 0) {
                make.top.equalTo(superview).with.offset(5);
            } else {
                UIView *preView = superview.subviews[(idx-1)];
                make.top.equalTo(preView.mas_bottom).with.offset(2);
                make.height.equalTo(preView);
            }
            if (idx == array.count-1) {
                make.bottom.equalTo(superview).with.offset(-5);
            }
        }];
    }];
    [self setGrayViewConstraint];
}

- (void)addOperationButtons:(NSArray *)titles specColor:(UIColor *)color
{
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        button.layer.cornerRadius = 5.0;
        if (titles.count-1 == i) {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.backgroundColor = UIColorFromRGB(0x59C4F0);
        } else {
            button.layer.borderColor = self.operateContainer.tintColor.CGColor;
            [button setTitleColor:self.operateContainer.tintColor forState:UIControlStateNormal];
            button.layer.borderWidth = 1.0;
        }

        [button addTarget:self action:@selector(operateButtonsAction:) forControlEvents:UIControlEventTouchUpInside];
        [mArray addObject:button];
    }
    self.operateButtons = mArray.copy;
    [self setButtonsConstraint];
}

- (void)setOrderNumber:(NSString *)orderNumber {
    self.orderNumberLB.text = [NSString stringWithFormat:@"订单编号: %@",orderNumber];
}

- (void)setPurchaseStatus:(TLPurchaseStatus)purchaseStatus {
    _purchaseStatus = purchaseStatus;
    
    NSString *result = @"";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    switch (purchaseStatus) {
        case TLPurchaseStatusUnknown:
            result = @"未知问题";
            break;
            
        case TLPurchaseStatusWaitPay:
            result = @"待付款";
            [array addObjectsFromArray:@[@"取消订单",@"付款"]];
            break;
           
        case TLPurchaseStatusWaitSend:
            result = @"待发货";
//            [array addObjectsFromArray:@[@"查看物流"]];
            break;
            
        case TLPurchaseStatusWaitRecieve:
            result = @"待收货";
            [array addObjectsFromArray:@[@"签收",@"查看物流"]];
            break;
            
        case TLPurchaseStatusWaitComment:
            result = @"交易成功";
            [array addObjectsFromArray:@[@"删除订单",@"立即评价"]];
            break;
            
        case TLPurchaseStatusPlusComment:
            result = @"交易成功";
            [array addObjectsFromArray:@[@"删除订单",
//                                         @"追加评价"
                                         ]];
            break;
            
        case TLPurchaseStatusTimeOut:
            result = @"交易成功";
            [array addObjectsFromArray:@[@"删除订单"]];
            break;
            
        case TLPurchaseStatusClosed:
            result = @"订单已取消";
            [array addObjectsFromArray:@[@"删除订单"]];
        
        default:
            break;
    }
    
    self.results.text = result;
    [self addOperationButtons:array.copy specColor:UIColorFromRGB(0x59C4F0)];
}

- (void)setOperateButtons:(NSArray *)operateButtons {
    for (NSInteger i = 0; i < _operateButtons.count;i++) {
        UIButton *button = _operateButtons[i];
        [button removeFromSuperview];
    }
    
    _operateButtons = operateButtons;
    for (NSInteger i = 0; i < operateButtons.count;i++) {
        UIButton *button = operateButtons[i];
        [self.operateContainer addSubview:button];

        switch (_purchaseStatus) {
            case TLPurchaseStatusWaitPay:
                if (0 == i) {
                    button.tag = TLOperationTypeCancel;
                } else if (1 == i) {
                    button.tag = TLOperationTypePay;
                }
                break;

            case TLPurchaseStatusWaitSend:
//                if (0 == i) {
//                    button.tag = TLOperationTypeCheckLogistics;
//                }
                break;
             
            case TLPurchaseStatusWaitRecieve:
                if (0 == i) {
                    button.tag = TLOperationTypeRecieve;
                } else if (1 == i) {
                    button.tag = TLOperationTypeCheckLogistics;
                }
                break;
                
            case TLPurchaseStatusWaitComment:
                if (0 == i) {
                    button.tag = TLOperationTypeDelete;
                } else if (1 == i) {
                    button.tag = TLOperationTypeWriteComment;
                }
                break;
                
            case TLPurchaseStatusPlusComment:
                if (0 == i) {
                    button.tag = TLOperationTypeDelete;
                } else if (1 == i) {
                    button.tag = TLOperationTypeWriteComment;
                }
                break;
                
            case TLPurchaseStatusTimeOut:
                if (0 == i) {
                    button.tag = TLOperationTypeDelete;
                }
                break;
                
            case TLPurchaseStatusClosed:
                if (0 == i) {
                    button.tag = TLOperationTypeDelete;
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)setShopType:(TLShopType)shopType {
    _shopType = shopType;
    if (TLShopTypeDefault == _shopType) {

        
    } else if (TLShopTypeOfficial == _shopType) {

        
    } else if (TLShopTypeStatusUnknown == _shopType) {
//        self.shopType_Icon.image = [UIImage imageNamed:];
//        self.shopDescription_Icon.image = [UIImage imageNamed:];
        
    }
}

- (void)setPriceDetailWith:(NSInteger)number price:(float)totalPrice courier:(float)courierPrice
{
    if ( number <= 1) {
        number = 1;
    }
    
//    self.price.text = [NSString stringWithFormat:@"¥ %.2f",(totalPrice-courierPrice)/number];
    NSString *priceDetail = [NSString stringWithFormat:@"共%lu件商品  合计: ¥ %.2f  (含运费¥ %.2f)",number,totalPrice,courierPrice];
    self.priceDetail.text = priceDetail;
}

#pragma mark - set UI init

- (void)setAppearence
{
    self.contentView.tintColor = UIColorFromRGB(0x666666);
}

#pragma mark - set Constraint

- (void)setButtonsConstraint
{
    UIView *superView = self.operateContainer;
    for (NSInteger i = 0; i < self.operateButtons.count; i++) {
        UIButton *button = self.operateButtons[i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@70);
            make.height.equalTo(superView.mas_height).with.offset(-12);
            make.centerY.equalTo(superView);
            if (self.operateButtons.count-1 == i) {
                make.right.equalTo(superView).with.offset(-6);
            } else {
                UIButton *nextButton = self.operateButtons[i+1];
                make.right.equalTo(nextButton.mas_left).with.offset(-6);
            }
        }];
    }
}

- (void)setViewsMASConstraint
{
    UIView *superView = self.contentView;
    [self.backVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(10);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(self.operateContainer.mas_top).with.offset(-1);
    }];
    [self.operateContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.bottom.equalTo(superView);
    }];
    superView = self.operateContainer;
    [self.usrName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView);
        make.left.equalTo(superView).with.offset(8);
    }];
    
    superView = self.backVIew;
    [self.shopType_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView).with.offset(12);
        make.top.equalTo(superView).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.orderNumberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopType_Icon);
        make.left.equalTo(self.shopType_Icon.mas_right).with.offset(4);
    }];

    [self setGrayViewConstraint];
    [self.results mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopType_Icon);
        make.right.equalTo(superView).with.offset(-12);
    }];

    
    superView = self.backVIew;
    [self.priceDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayView.mas_bottom).with.offset(8);
        make.bottom.equalTo(superView).with.offset(-8);
        make.right.equalTo(superView).with.offset(-4);
    }];
}

- (void)setGrayViewConstraint {
    NSUInteger count = self.grayView.subviews.count;
    CGFloat height = count > 1 ? 84*count-5 : 84;
//    CGFloat height = count > 1 ? 110*count-10 : 110;
    UIView *superView = self.backVIew;
    [self.grayView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView).with.offset(36);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(@(height));
    }];
}

@end

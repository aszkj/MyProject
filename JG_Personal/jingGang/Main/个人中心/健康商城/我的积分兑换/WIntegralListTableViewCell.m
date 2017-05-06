//
//  WIntegralListTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralListTableViewCell.h"
#import "PublicInfo.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "WIntegralShopView.h"

typedef enum : NSUInteger {
    kHidden,         //隐藏按钮
    kCancel = 1000,  //取消
    kCertain,        //确定
    kPay,            //付款
} kOrderStatus;


@interface WIntegralListTableViewCell ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *cancelAlertView;
@property (nonatomic, strong) UIAlertView *certainAlertView;

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn1;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn2;

@end

@implementation WIntegralListTableViewCell

-(void)setData:(OrderListBO *)data
{
    _data = data;
    for (UIView *v in self.contentView.subviews)
    {
        if (v.tag == 1111) {
            [v removeFromSuperview];
        }
    }
    //TODO:商品详情
    for (NSInteger idx = 0; idx < data.orderBOList.count; idx++) {
        WIntegralShopView *shopView = [[NSBundle mainBundle] loadNibNamed:@"WIntegralShopView" owner:self options:nil][0];
        shopView.dict = data.orderBOList[idx];
        shopView.frame = CGRectMake(0, 55 + 90 *idx, __MainScreen_Width, 80);
        shopView.shopAction = ^(NSDictionary *dict){
            if (self.shopAction) {
                self.shopAction(dict);
            }
        };
        [self.contentView addSubview:shopView];
    }
    //订单编号
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",data.igoOrderSn];
    
    //订单状态，0为已提交未付款，20为付款成功，30为已发货，40为已收货完成,-1为已经取消，此时不归还用户积分
    switch ([data.igoStatus integerValue]) {
        case 0:
        {
            self.statusLabel.text = @"待付款";
            [self setRightBtnStatus:kPay withButton:self.rightBtn2];
            [self setRightBtnStatus:kCancel withButton:self.rightBtn1];
        }
            break;
        case 20:
        {
            self.statusLabel.text = @"已付款";
            [self setRightBtnStatus:kHidden withButton:self.rightBtn1];
            [self setRightBtnStatus:kHidden withButton:self.rightBtn2];
        }
            break;
        case 30:
        {
            self.statusLabel.text = @"已发货";
            [self setRightBtnStatus:kCertain withButton:self.rightBtn1];
            [self setRightBtnStatus:kHidden withButton:self.rightBtn2];
        }
            break;
        case 40:
        {
            self.statusLabel.text = @"已收货";
            [self setRightBtnStatus:kHidden withButton:self.rightBtn1];
            [self setRightBtnStatus:kHidden withButton:self.rightBtn2];
        }
            break;
        case -1:
        {
            self.statusLabel.text = @"已取消";
            [self setRightBtnStatus:kHidden withButton:self.rightBtn1];
            [self setRightBtnStatus:kHidden withButton:self.rightBtn2];
        }
            break;
        default:
            break;
    }
    
    //设置消费金额
    [self setWithShopCount:[data.goodsCount integerValue] withIntegral:[data.igoTotalIntegral integerValue] withPostal:[data.igoTransFee floatValue]];
}

- (void)awakeFromNib {
    
}
#pragma mark - 设置商品个数，积分数，邮费金额
- (void) setWithShopCount:(NSInteger)count withIntegral:(NSInteger)integral withPostal:(CGFloat )postal
{
    NSString *contentStr = [NSString stringWithFormat:@"共%ld件商品  消费%ld积分  邮费%.2f元",count,integral,postal];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc ]initWithString:contentStr];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName,status_color,NSForegroundColorAttributeName, nil];
    
    NSRange rangeCount = [attributedStr.string rangeOfString:[NSString stringWithFormat:@"%ld",count]];
    [attributedStr addAttributes:dict range:rangeCount];
    
    NSRange rangeIntegral = [attributedStr.string rangeOfString:[NSString stringWithFormat:@"%ld",integral]];
    [attributedStr addAttributes:dict range:rangeIntegral];
    
    NSRange rangePostal = [attributedStr.string rangeOfString:[NSString stringWithFormat:@"%.2f",postal] options:NSBackwardsSearch];
    [attributedStr addAttributes:dict range:rangePostal];
    
    self.priceLabel.attributedText = attributedStr;
}
- (void)setRightBtnStatus:(kOrderStatus)status withButton:(UIButton *)btn
{
    btn.tag = status;
    btn.hidden = NO;
    switch (status) {
        case kHidden:
        {
            btn.hidden = YES;
        }
            break;
        case kCancel://取消按钮
        {
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGB(0X666666) forState:UIControlStateNormal];
        }
            break;
        case kCertain://确定收货
        {
            btn.backgroundColor = status_color;
            [btn setTitle:@"确定收货" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        case kPay://付款
        {
            btn.backgroundColor = status_color;
            [btn setTitle:@"付款" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (IBAction)rigthAction1:(UIButton *)sender
{
    [self rightActionWithType:sender.tag];
}
- (IBAction)rightAction2:(UIButton *)sender
{
    [self rightActionWithType:sender.tag];
}
#pragma mark - 点击按钮事件通过block返回
-(void)rightActionWithType:(kOrderStatus)status
{
    switch (status) {
        case kCancel:
        {
            if (self.cancelAction)
            {
                self.cancelAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认取消兑换？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [self.cancelAlertView show];
            }
        }
            break;
        case kCertain:
        {
            if (self.certainAction)
            {
                self.certainAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认已收到订单中的全部商品?"  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [self.certainAlertView show];
            }
        }
            break;
        case kPay:
        {
            if (self.payAction)
            {
                self.payAction();
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.cancelAlertView)
    {
        if (!buttonIndex) {
            self.cancelAction();
        }
    }
    else if (alertView == self.certainAlertView)
    {
        if (!buttonIndex) {
            self.certainAction();
        }
    }
}



@end

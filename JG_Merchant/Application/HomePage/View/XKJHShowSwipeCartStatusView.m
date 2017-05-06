//
//  XKJHShowSwipeCartStatusView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShowSwipeCartStatusView.h"

#define ProduceOrderStr     @"已生成订单，请刷卡";
#define SwipeCartSuccessStr @"刷卡成功";

@interface XKJHShowSwipeCartStatusView() {
    
}

@property (weak, nonatomic) IBOutlet UIImageView *swipeCartSuccessImgView;
@property (weak, nonatomic) IBOutlet UIImageView *produceOrderImgView;

//生成订单，以及刷卡成功view
@property (weak, nonatomic) IBOutlet UIView *produceOrderAndSwipeCardSucessView;
//生成订单，以及刷卡成功label
@property (weak, nonatomic) IBOutlet UILabel *produceOrderAndSwipeCartSuccessLabel;
//正在刷卡view
@property (weak, nonatomic) IBOutlet UIView *isSwipingCartView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, copy)BeginSwipeCartBlock beginSwipeCartBlock;


@end

@implementation XKJHShowSwipeCartStatusView


+(id)showInContentView:(UIView *)contentView beginSwipeCart:(BeginSwipeCartBlock)beginSwipeCart
{
    
    XKJHShowSwipeCartStatusView *showSwipeCartStatusView = [self showSwipeCartStatusView];
    [contentView addSubview:showSwipeCartStatusView];
    //状态初始化,生成订单状态
    showSwipeCartStatusView.swipeCartStatus = ProduceOrderStatus;
    //开始刷卡block
    showSwipeCartStatusView.beginSwipeCartBlock = beginSwipeCart;
    [showSwipeCartStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentView);
    }];
    
    return showSwipeCartStatusView;
}


+(XKJHShowSwipeCartStatusView *)showSwipeCartStatusView {
    
    return BoundNibView(@"XKJHShowSwipeCartStatusView", XKJHShowSwipeCartStatusView);
    
}

-(void)awakeFromNib {
    
    [self insertSubview:_bgView atIndex:0];
    
}


- (IBAction)makeSureAction:(id)sender {
    
    if (self.swipeCartStatus == ProduceOrderStatus) {//当前为生成订单状态，
        //点击确定，转为刷卡状态，
        self.swipeCartStatus = IsswipingCartStatus;
        //回调进行刷卡操作
        if (self.beginSwipeCartBlock) {
            self.beginSwipeCartBlock();
        }
    }else if (self.swipeCartStatus == SwipeCartSuccessStatus)//当前为刷卡成功状态，
    {
        //点击确定，隐藏视图
        [self hiddden];
    }
        
}



-(void)hiddden {

    self.hidden = YES;
    [self removeFromSuperview];
}


-(void)setSwipeCartStatus:(SwipeCartStatus)swipeCartStatus {
    
    _swipeCartStatus = swipeCartStatus;
    switch (swipeCartStatus) {
        case ProduceOrderStatus://生成订单
        {
            self.produceOrderAndSwipeCardSucessView.hidden = NO;
            self.isSwipingCartView.hidden = YES;
            self.produceOrderImgView.hidden = NO;
            self.swipeCartSuccessImgView.hidden = YES;
            self.produceOrderAndSwipeCartSuccessLabel.text = ProduceOrderStr;
        }
            break;
        case IsswipingCartStatus://正在刷卡
        {
            self.isSwipingCartView.hidden = NO;
            self.produceOrderAndSwipeCardSucessView.hidden = YES;
        }
            break;
        case SwipeCartSuccessStatus://刷卡成功
        {
            self.produceOrderAndSwipeCardSucessView.hidden = NO;
            self.isSwipingCartView.hidden = YES;
            self.produceOrderImgView.hidden = YES;
            self.swipeCartSuccessImgView.hidden = NO;
            self.produceOrderAndSwipeCartSuccessLabel.text =SwipeCartSuccessStr;
        }
            break;
        default:
            break;
    }
}




@end

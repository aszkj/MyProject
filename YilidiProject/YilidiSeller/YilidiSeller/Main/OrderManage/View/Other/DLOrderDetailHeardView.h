//
//  DLOrderDetailHeardView.h
//  YilidiSeller
//
//  Created by 曾勇兵 on 16/8/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LocationBlock)(void);
typedef void(^BuyerPhoneBlock)(void);
@interface DLOrderDetailHeardView : UIView
@property (strong, nonatomic) IBOutlet UIButton *orderDistanceButton;
@property (strong, nonatomic) IBOutlet UILabel *deliveryTimer;
@property (weak, nonatomic) IBOutlet UIButton *selfTakeUserPhoneNumberButton;


@property (nonatomic,strong)LocationBlock locationBlock;
@property (nonatomic,strong)BuyerPhoneBlock buyerPhoneBlock;
@end

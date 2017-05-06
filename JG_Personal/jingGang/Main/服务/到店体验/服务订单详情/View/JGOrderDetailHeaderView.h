//
//  JGOrderDetailHeaderView.h
//  jingGang
//
//  Created by dengxf on 15/12/26.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapImageGestureBlock)(void);
typedef void(^TapintoServiceDetailBlock)(void);
@class POrderDetails;
@interface JGOrderDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;

@property (weak, nonatomic) IBOutlet UILabel *totlesLab;


@property (weak, nonatomic) IBOutlet UIButton *payMoneyButton;

- (IBAction)payForMoneyAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceTextTopConstraint;

@property (strong,nonatomic) POrderDetails *orderDetail;

- (void)stControlWidgetWithStatus:(NSInteger)status;
@property (weak, nonatomic) IBOutlet UILabel *qrcodeTextLab;

@property (weak, nonatomic) IBOutlet UILabel *consumeCodeLab;

@property (copy , nonatomic) TapImageGestureBlock tapImageGestureBlock;

@property (nonatomic, copy)TapintoServiceDetailBlock tapintoServiceDetailBlock;



@end

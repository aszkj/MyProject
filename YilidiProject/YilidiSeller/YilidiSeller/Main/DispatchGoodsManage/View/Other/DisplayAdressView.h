//
//  DisplayAdressView.h
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDefaultAdressViewHeight 63
#define kNoDefaultAdressViewHeight 34
typedef void(^ClickAdressBlock)(void);
@class AdressModel;
@interface DisplayAdressView : UIView
@property (nonatomic,copy)ClickAdressBlock clickAdressBlock;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (nonatomic,strong)AdressModel *adressModel;

@end

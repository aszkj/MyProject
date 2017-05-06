//
//  DLPersonalrDataVC.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/15.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLBuyerBaseController.h"

@interface DLPersonalrDataVC : DLBuyerBaseController
@property (strong, nonatomic) IBOutlet UIImageView *userHeaderImage;
@property (strong, nonatomic) IBOutlet UIButton *nameButton;
@property (strong, nonatomic) IBOutlet UIButton *genderButton;
@property (strong, nonatomic) IBOutlet UIButton *birthButton;
@property (strong, nonatomic) IBOutlet UILabel *isVipLabel;
@property (nonatomic,strong)NSString *userImageStr;
@property (nonatomic,strong)NSString *birthStr;
@end

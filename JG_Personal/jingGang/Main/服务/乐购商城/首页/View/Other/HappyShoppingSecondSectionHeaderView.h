//
//  HappyShoppingSecondSectionHeaderView.h
//  jingGang
//
//  Created by 张康健 on 15/11/21.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HappyShoppingSecondSectionHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *sectionIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitlLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sectionIconTwoImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secionIconHeightConstraint;

@end

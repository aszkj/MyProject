//
//  HeadImgCell.h
//  weimi
//
//  Created by 张康健 on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateHeaderImgBlock)(void);
@interface HeadImgCell : UITableViewCell

@property (nonatomic,strong)UIImageView *headerImgView;

@property (nonatomic, copy)UpdateHeaderImgBlock updateHeaderImgBlock;

@end

//
//  DLMyOrderGoodsCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/6.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLMyOrderGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriginalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;

@end

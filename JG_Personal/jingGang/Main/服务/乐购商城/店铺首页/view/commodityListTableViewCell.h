//
//  commodityListTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commodityListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iphoneView;
@property (weak, nonatomic) IBOutlet UILabel *jifenLabel;

//隐藏最底部积分Label
- (void) willCellWithModel:(NSDictionary *)dict;
- (void) willSearchCellWithModel:(NSDictionary *)dict;


@end

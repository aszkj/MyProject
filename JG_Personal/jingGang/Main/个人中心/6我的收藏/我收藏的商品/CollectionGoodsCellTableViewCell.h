//
//  CollectionGoodsCellTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionGoodsCellTableViewCell : UITableViewCell

typedef void(^OptionBlock)(NSIndexPath *indexPath);

@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic, getter = isAssociatedAction) BOOL associatedAction;
@property (copy) OptionBlock optionBlock;

@property (weak, nonatomic) IBOutlet UIImageView *goodsLogo;
@property (weak, nonatomic) IBOutlet UILabel     *goodsDescription;
@property (weak, nonatomic) IBOutlet UILabel     *goodsPrice;
@property (weak, nonatomic) IBOutlet UIImageView *phoneVIP;

@end

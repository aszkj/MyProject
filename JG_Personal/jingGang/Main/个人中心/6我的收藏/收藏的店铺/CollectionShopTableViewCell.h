//
//  CollectionShopTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionShopTableViewCell : UITableViewCell

typedef void(^CancelShopAtIndex)(NSIndexPath *indexPath);
typedef void(^AccessShopAtIndex)(NSIndexPath *indexPath);

@property (weak, nonatomic) IBOutlet UIImageView *shopLogo;
@property (weak, nonatomic) IBOutlet UIImageView *shopType;
@property (weak, nonatomic) IBOutlet UILabel     *shopName;
@property (weak, nonatomic) IBOutlet UIButton    *accessBtn;
@property (weak, nonatomic) IBOutlet UIButton    *cancelBtn;
@property (nonatomic) NSIndexPath *indexPath;

@property (nonatomic, getter = isAssociatedAction) BOOL associatedAction;
@property (copy) CancelShopAtIndex cancelShop;
@property (copy) AccessShopAtIndex accessShop;

@end

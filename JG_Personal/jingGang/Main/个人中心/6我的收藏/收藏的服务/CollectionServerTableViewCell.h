//
//  CollectionServerTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionServerTableViewCell : UITableViewCell

typedef void(^OptionBlock)(NSIndexPath *indexPath);

@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic, getter = isAssociatedAction) BOOL associatedAction;
@property (copy) OptionBlock optionBlock;

@property (weak, nonatomic) IBOutlet UIImageView *serverImage;
@property (weak, nonatomic) IBOutlet UILabel *serverName;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *serverPrice;

@end

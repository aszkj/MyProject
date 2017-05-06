//
//  WSJSiftRowTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSJSiftRowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


- (void) selectCellWith:(BOOL)select;

@end

//
//  mainPublicTableViewCell.h
//  jingGang
//
//  Created by thinker on 15/11/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainPublicTableViewCell : UITableViewCell

@property (nonatomic, retain)IBOutlet UIImageView  *left_img;//图片
@property (nonatomic, retain)IBOutlet UILabel      *name_lab;//标题
@property (nonatomic, retain)IBOutlet UILabel      *sub_lab;//内容
@property (nonatomic, retain)IBOutlet UIImageView  *bg_img;

@end

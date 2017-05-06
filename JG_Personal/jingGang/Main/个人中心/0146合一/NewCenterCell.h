//
//  NewCenterCell.h
//  jingGang
//
//  Created by wangying on 15/5/29.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCenterCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *countText;
-(void)getIndexRow:(NSInteger)index index:(NSInteger)indexs;
@end

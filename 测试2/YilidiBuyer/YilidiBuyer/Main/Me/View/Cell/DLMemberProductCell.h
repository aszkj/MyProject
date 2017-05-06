//
//  DLMemberProductCell.h
//  YilidiBuyer
//
//  Created by yld on 16/6/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLMemberProductModel;
@interface DLMemberProductCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *count;


@property (nonatomic,strong)DLMemberProductModel *model;
@end

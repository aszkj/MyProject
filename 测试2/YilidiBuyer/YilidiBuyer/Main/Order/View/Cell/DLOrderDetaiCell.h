//
//  DLOrderDetaiCell.h
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DLOrdertailsModel;
@interface DLOrderDetaiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productSpecification;
@property (weak, nonatomic) IBOutlet UILabel *productCount;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (nonatomic,strong)DLOrdertailsModel *model;
@end

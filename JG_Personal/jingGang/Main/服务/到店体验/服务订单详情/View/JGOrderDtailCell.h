//
//  JGOrderDtailCell.h
//  jingGang
//
//  Created by dengxf on 15/12/26.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailModel.h"
@interface JGOrderDtailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderStatusLab;

@property (weak, nonatomic) IBOutlet UILabel *consumeCodeLab;

@property (weak, nonatomic) IBOutlet UIButton *qrcodeButton;

@property (strong,nonatomic) JGOrderDetailModel *detailModel;


@end

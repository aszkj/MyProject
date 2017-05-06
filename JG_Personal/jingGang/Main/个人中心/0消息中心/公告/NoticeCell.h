//
//  NoticeCell.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleBO;
@class NoticeModel;
@interface NoticeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *headTitleLab;

@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UILabel *operatorsLab;

@property (weak, nonatomic) IBOutlet UILabel *postClassTypeLabel;

@property (strong,nonatomic)ArticleBO *articleBO;

@end

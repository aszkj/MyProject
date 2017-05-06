//
//  NoticeCell.h
//  Operator_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleBO;
@class OpNotices;
@class NoticeModel;
@interface NoticeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *headTitleLab;

@property (strong, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) IBOutlet UILabel *operatorsLab;

@property (strong,nonatomic)ArticleBO *articleBO;
@property (strong,nonatomic)OpNotices *opNotices;

@property (nonatomic, strong)NoticeModel *noticeModel;

@end

//
//  NoticeCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeCell.h"
#import "NoticeModel.h"

@implementation NoticeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}

- (void)setNoticeModel:(NoticeModel *)noticeModel {
    _noticeModel = noticeModel;
    self.headTitleLab.text = noticeModel.headTitle;
    self.timeLab.text = noticeModel.time;
    self.operatorsLab.text = noticeModel.operators;
    self.operatorsLab.textColor = status_color;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

//
//  NoticeCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeCell.h"
#import "ArticleBO.h"


@implementation NoticeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        
    }
    return self;
}

-(void)setArticleBO:(ArticleBO *)articleBO {

    _articleBO = articleBO;
    self.headTitleLab.text = articleBO.title;
    self.timeLab.text = [NSString stringWithFormat:@"%@",articleBO.addTime];
    self.operatorsLab.textColor = status_color;
    self.operatorsLab.text = @"云e生公告";
}

-(void)setOpNotices:(OpNotices *)opNotices {
    _opNotices = opNotices;
    self.headTitleLab.text = opNotices.ntTitle;
    self.timeLab.text = [NSString stringWithFormat:@"%@",opNotices.addTime];
    self.operatorsLab.textColor = status_color;
    self.operatorsLab.text = opNotices.operatorName;
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

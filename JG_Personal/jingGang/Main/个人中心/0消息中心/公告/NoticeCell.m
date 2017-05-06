//
//  NoticeCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/29.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "NoticeCell.h"
#import "ArticleBO.h"
#import "PublicInfo.h"


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
    self.postClassTypeLabel.text = [NSString stringWithFormat:@"【%@】",articleBO.articleClassName];
    self.headTitleLab.text = articleBO.title;
    self.timeLab.text = [NSString stringWithFormat:@"%@",articleBO.addTime];
    self.operatorsLab.textColor = status_color;
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

//
//  DLGoodsOneLevelClassCell.m
//  YilidiBuyer
//
//  Created by mm on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsOneLevelClassCell.h"
#import "ProjectStandardUIDefineConst.h"
#import "GoodsClassModel.h"

@interface DLGoodsOneLevelClassCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *levelLabelMaxWidthConstraint;

@end

@implementation DLGoodsOneLevelClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.levelLabelMaxWidthConstraint.constant = (kScreenWidth * 0.221)-10;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLGoodsOneLevelClassCell (setCellModel)

- (void)setGoodsOneLevelModel:(GoodsClassModel *)cellModel {

    self.titleLabel.textColor = (cellModel.selected ? KCOLOR_PROJECT_RED : [UIColor darkTextColor]);
    self.lineView.hidden = !cellModel.selected;
    self.titleLabel.text = cellModel.className;

}

@end


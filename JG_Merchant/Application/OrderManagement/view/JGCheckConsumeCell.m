//
//  JGCheckConsumeCell.m
//  Merchants_JingGang
//
//  Created by dengxf on 15/12/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "JGCheckConsumeCell.h"

@interface JGCheckConsumeCell ()


@end

@implementation JGCheckConsumeCell

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [[UIButton alloc] init];
        [self.contentView addSubview:_selectedButton];
    }
    return _selectedButton;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (self.isSelected) {
        // 已经选择了
        //        [self.selectedButton setImage:[UIImage imageNamed:@"action-red-button"] forState:UIControlStateNormal];
        //        [self.selectedButton setImage:[UIImage imageNamed:@"action-gray-button"] forState:UIControlStateSelected];
        [self.selectedButton setTitleColor:status_color forState:UIControlStateNormal];
        [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
    }else {
        //        [self.selectedButton setImage:[UIImage imageNamed:@"action-gray-button"] forState:UIControlStateNormal];
        //        [self.selectedButton setImage:[UIImage imageNamed:@"action-red-button"] forState:UIControlStateSelected];
        [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.selectedButton setTitleColor:status_color forState:UIControlStateSelected];
    }
    [self setNeedsLayout];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = self.contentView.height;
    CGFloat buttonHeight = 32;
    CGFloat buttonWidth = 300;
    CGFloat buttonOriginX = 15;
    CGFloat buttonOriginY = (height - buttonHeight)/2;
    
    self.selectedButton.x = buttonOriginX;
    self.selectedButton.y = buttonOriginY;
    self.selectedButton.width = buttonWidth;
    self.selectedButton.height = buttonHeight;
//    
//    if (self.isSelected) {
//        // 已经选择了
////        [self.selectedButton setImage:[UIImage imageNamed:@"action-red-button"] forState:UIControlStateNormal];
////        [self.selectedButton setImage:[UIImage imageNamed:@"action-gray-button"] forState:UIControlStateSelected];
//        [self.selectedButton setTitleColor:status_color forState:UIControlStateNormal];
//        [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
//        
//    }else {
////        [self.selectedButton setImage:[UIImage imageNamed:@"action-gray-button"] forState:UIControlStateNormal];
////        [self.selectedButton setImage:[UIImage imageNamed:@"action-red-button"] forState:UIControlStateSelected];
//        [self.selectedButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.selectedButton setTitleColor:status_color forState:UIControlStateSelected];
//    }
    [self.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectedButtonAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.selectedIndexPathBlock) {
        self.selectedIndexPathBlock(btn.isSelected);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

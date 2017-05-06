//
//  mainPublicTableViewHeader.m
//  jingGang
//
//  Created by thinker on 15/11/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "mainPublicTableViewHeader.h"
#import "PublicInfo.h"


@interface mainPublicTableViewHeader ()
@property (weak, nonatomic) IBOutlet UILabel *xianLabel;

@end

@implementation mainPublicTableViewHeader

-(void)awakeFromNib
{
    _rightBtn.hidden = YES;
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleNameLabel.textColor = color_section_1;
    self.xianLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}

- (UIButton *)rightBtn
{
    _rightBtn.hidden = YES;
    return _rightBtn;
}

@end

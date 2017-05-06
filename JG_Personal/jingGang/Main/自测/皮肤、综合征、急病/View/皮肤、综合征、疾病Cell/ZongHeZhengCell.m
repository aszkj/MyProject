//
//  ZongHeZhengCell.m
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ZongHeZhengCell.h"
#import "CheckGroup.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"

@implementation ZongHeZhengCell

- (void)awakeFromNib {

    [super awakeFromNib];
    
    self.btView.layer.cornerRadius = 5.0f;
    self.btView.layer.masksToBounds = NO;
    
}

-(void)layoutSubviews{

    [super layoutSubviews];
    self.selfTest_Title.text = self.checkGroup.groupTitle;
    NSString *twicImgUrl = TwiceImgUrlStr(self.checkGroup.thumbnail, kScreenWidth-22, 156);
    [self.self_test_Img sd_setImageWithURL:[NSURL URLWithString:twicImgUrl]  placeholderImage:[UIImage imageNamed:@"test_01.png"]];
    self.summary_TextView.text = self.checkGroup.summary;
    
}

- (IBAction)beginTest:(id)sender {
    
    
}


- (IBAction)lookUpDetail:(id)sender {
    
}

@end



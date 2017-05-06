//
//  WSJSelectCityTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSelectCityTableViewCell.h"

@interface WSJSelectCityTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;

@end

@implementation WSJSelectCityTableViewCell

- (void)awakeFromNib {
    self.xianHeight.constant = 0.3;
}


@end

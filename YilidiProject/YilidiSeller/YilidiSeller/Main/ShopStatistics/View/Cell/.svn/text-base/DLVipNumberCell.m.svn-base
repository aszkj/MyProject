//
//  DLVipNumberCell.m
//  YilidiSeller
//
//  Created by yld on 16/6/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLVipNumberCell.h"
#import "DLVipNumberModel.h"
#import "GlobeMaco.h"
@implementation DLVipNumberCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (kScreenWidth==iPhone5_width) {
        _date.font = [UIFont systemFontOfSize:12];
        _registerCount.font = [UIFont systemFontOfSize:12];
        _vipCount.font = [UIFont systemFontOfSize:12];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setVipModel:(DLVipNumberModel *)vipModel{

    _vipModel=vipModel;
    if (_vipModel) {
        
        _date.text = _vipModel.date;
        _registerCount.text = [_vipModel.registerNumber stringValue];
        _vipCount.text = [_vipModel.vipNumber stringValue];
        
    }
}
@end

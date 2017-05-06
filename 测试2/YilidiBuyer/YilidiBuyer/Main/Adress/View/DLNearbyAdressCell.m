//
//  DLNearbyAdressCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLNearbyAdressCell.h"

@implementation DLNearbyAdressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLNearbyAdressCell (setAdress)

-(void)setNearbySearchAdressWithNearbyAdressModel:(DLNeartyAdressModel *)model {
    
    self.mainSearchAdressLabel.text = model.mainAdress;
    self.detailSearchAdressLabel.text = model.detailAdress;
}

@end
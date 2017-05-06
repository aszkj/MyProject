//
//  DLNearbyAdressCell.m
//  YilidiBuyer
//
//  Created by yld on 16/4/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSearchAdressCell.h"


@implementation DLSearchAdressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation DLSearchAdressCell (setAdress)

-(void)setNearbySearchAdressWithNearbyAdressModel:(CommunityModel *)model {
    
    self.mainSearchAdressLabel.text = model.communityName;
    self.detailSearchAdressLabel.text = model.communityAdressDetail;
}

@end
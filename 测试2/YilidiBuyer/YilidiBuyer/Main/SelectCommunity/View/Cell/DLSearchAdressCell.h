//
//  DLNearbyAdressCell.h
//  YilidiBuyer
//
//  Created by yld on 16/4/28.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityModel.h"
#define kSearchedAdressCellHeight 70
@interface DLSearchAdressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainSearchAdressLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailSearchAdressLabel;

@end

@interface DLSearchAdressCell (setAdress)

-(void)setNearbySearchAdressWithNearbyAdressModel:(CommunityModel *)model;

@end
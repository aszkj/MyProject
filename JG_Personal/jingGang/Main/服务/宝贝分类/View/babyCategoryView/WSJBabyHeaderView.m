//
//  WSJBabyHeaderView.m
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJBabyHeaderView.h"
#import "PublicInfo.h"


@interface WSJBabyHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *xianView;

@property (weak, nonatomic) IBOutlet UILabel *quanbuLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation WSJBabyHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

-(void)awakeFromNib
{
    self.xianView.hidden = YES;
    self.quanbuLabel.hidden = YES;
}

- (void)setType:(tableType)type
{
    _type = type;
    switch (type) {
        case k_Header:
        {
            self.xianView.hidden = NO;
            self.xianView.backgroundColor = status_color;
            self.nameLabel.text = @"全部宝贝";
            self.nameLabel.textColor = status_color;
        }
            break;
        case k_footer:
        {
            self.nameLabel.text = @"男性专区";
            self.nameLabel.textColor = [UIColor blackColor];
        }
            break;
        case k_sectionHeader:
        {
            self.quanbuLabel.hidden = NO;
            self.nameLabel.textColor =[UIColor blackColor];
            self.imageview.hidden = YES;
        }
            break;
        default:
            break;
    }

}
- (IBAction)TapAction:(id)sender
{
    if (self.block)
    {
        self.block();
    }
}


@end

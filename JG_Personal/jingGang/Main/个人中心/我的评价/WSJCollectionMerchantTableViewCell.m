//
//  WSJCollectionMerchantTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJCollectionMerchantTableViewCell.h"
#import "WSJStarView.h"
#import "UIImageView+WebCache.h"

@interface WSJCollectionMerchantTableViewCell ()
//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
//商户名字
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//星星
@property (weak, nonatomic) IBOutlet WSJStarView *starView;
//距离
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;

@end

@implementation WSJCollectionMerchantTableViewCell

- (void)willCustomCellWithData:(NSDictionary *)dict
{
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"storeInfoPath"]]];
    self.titleLabel.text = dict[@"storeName"];
    self.starView.count = [dict[@"evaluationAverage"] intValue];

    
    self.distanceLable.text = [dict[@"distance"] intValue] > 10000 ? [NSString stringWithFormat:@"%.2fkm",[dict[@"distance"] floatValue] / 1000]  :[NSString stringWithFormat:@"%@m",dict[@"distance"]];
}

- (void)awakeFromNib {
    self.starView.count = 3;
}

- (IBAction)collectionAction:(UIButton *)sender
{
    if (self.cancelCollection)
    {
        self.cancelCollection(self.index);
    }
}


@end

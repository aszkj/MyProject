//
//  WIntegralDeleteTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/10/29.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralDeleteTableViewCell.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "Util.h"
#import "VApiManager.h"
#import "GlobeObject.h"


@interface WIntegralDeleteTableViewCell ()
{
    VApiManager *_vapiManager;
}


@property (nonatomic, assign) BOOL oneFirt;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabal;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation WIntegralDeleteTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _vapiManager = [[VApiManager alloc] init];
}
-(void)setDataCell:(IntegralGoodsDetails *)dataCell{
    _dataCell = dataCell;
    self.oneFirt = NO;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:dataCell.igGoodsImg]];
    self.titleNameLabal.text = dataCell.igGoodsName;
    self.countLabel.text = [dataCell.igExchangeCount stringValue];
}
- (IBAction)subAction:(id)sender {
    if (!self.oneFirt) {
        self.oneFirt = YES;
        [self requestData];
    }
    if ([self.countLabel.text intValue] == 1) {
        
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",[self.countLabel.text intValue] - 1];
    [self.dataCell setValue:@([self.countLabel.text intValue]) forKey:@"igExchangeCount"];
    if (self.changeShopCount) {
        self.changeShopCount();
    }
}
- (IBAction)addAction:(id)sender {
    if (!self.oneFirt) {
        self.oneFirt = YES;
        [self requestData];
    }
    if ([self.countLabel.text intValue] == self.dataCell.igGoodsCount.intValue) {
        [Util ShowAlertWithOnlyMessage:@"没那么多库存量"];
        return;
    }
    self.countLabel.text = [NSString stringWithFormat:@"%d",[self.countLabel.text intValue] + 1];
    [self.dataCell setValue:@([self.countLabel.text intValue]) forKey:@"igExchangeCount"];
    if (self.changeShopCount) {
        self.changeShopCount();
    }
}
- (IBAction)deleteAction:(id)sender {
    if (self.deleteCell) {
        self.deleteCell(self.indexPath);
    }
}

- (void)requestData
{
    WEAK_SELF
    IntegralGoodCountGetRequest *request = [[IntegralGoodCountGetRequest alloc] init:GetToken];
    request.api_ids = [self.dataCell.apiId stringValue];
    [_vapiManager integralGoodCountGet:request success:^(AFHTTPRequestOperation *operation, IntegralGoodCountGetResponse *response) {
        NSLog(@"ceshi ---- %@",response);
        [weak_self.dataCell setValue:response.integralGoodsList[0][@"igGoodsCount"] forKey:@"igGoodsCount"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"count ---- %@",error);
    }];
}


@end

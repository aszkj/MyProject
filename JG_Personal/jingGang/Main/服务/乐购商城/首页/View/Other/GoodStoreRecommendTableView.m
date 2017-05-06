//
//  GoodStoreRecommendTableView.m
//  jingGang
//
//  Created by 张康健 on 15/10/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GoodStoreRecommendTableView.h"
#import "GoodStoreRecommendCell.h"
#import "PStoreInfoModel.h"
#import "GlobeObject.h"
#import "UIImageView+WebCache.h"
#import "UIView+firstResponseController.h"
#import "WSJMerchantDetailViewController.h"
@implementation GoodStoreRecommendTableView

static NSString *GoodStoreRecommendID = @"GoodStoreRecommendID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];

    if (self) {
        
        [self _init];
    }
    
    return self;
}


- (void)_init {
    
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"GoodStoreRecommendCell" bundle:nil]  forCellReuseIdentifier:GoodStoreRecommendID];
    self.rowHeight = GoodStoreCellHeight;
    self.scrollEnabled = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
//    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodStoreRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodStoreRecommendID forIndexPath:indexPath];
    PStoreInfoModel *model = self.dataArr[indexPath.row];
    [self _comfigureCell:cell withModel:model];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PStoreInfoModel *model = self.dataArr[indexPath.row];
    WSJMerchantDetailViewController *goodStoreVC = [[WSJMerchantDetailViewController alloc] init];
    goodStoreVC.api_classId = @(model.PStoreInfoModelID.integerValue);
    goodStoreVC.hidesBottomBarWhenPushed = YES;
    [self.firstResponseController.navigationController pushViewController:goodStoreVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)_comfigureCell:(GoodStoreRecommendCell *)cell withModel:(PStoreInfoModel *)model {

    NSString *twiceImgUrl = TwiceImgUrlStr(model.photoPath, 115, 81);
    [cell.storeImgView sd_setImageWithURL:[NSURL URLWithString:twiceImgUrl] placeholderImage:nil];
    NSLog(@"店铺名称 %@",model.storeName);
    cell.storeNameLabel.text = model.storeName;
    cell.rateView.scorePercent = model.storeEvaluationAverage.floatValue;
    cell.distanceLabel.text = [Util transferDistanceStrWithDistance:model.distance];
    cell.addressLabel.text = model.storeAddress;
}


#pragma mark ----------------------- request Method -----------------------
-(void)requestWithStoreCode:(NSString *)storeCode result:(GoodStoreRequestBlcok)resultBlock
{
    //推荐位请求
    
    
}




@end

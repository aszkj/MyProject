//
//  GotoStoreExperienceTableView.m
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "GotoStoreExperienceTableView.h"
#import "PromoteSaleRecommendCell.h"
#import "NearestCell.h"
#import "GoodStoreRecommendCell.h"

@implementation GotoStoreExperienceTableView


static NSString *PromoteSaleRecommendCellID = @"PromoteSaleRecommendCellID";
static NSString *NearestCellID = @"NearestCellID";
static NSString *GoodStoreRecommendCellID = @"GoodStoreRecommendCellID";


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.backgroundColor = JGRandomColor;
    }
    return self;
}


-(void)setGotoStoreTableType:(GotoStoreTableType)gotoStoreTableType {

    NSString *nibName = nil;
    NSString *cellIdentifier = nil;
    _gotoStoreTableType = gotoStoreTableType;
    if (_gotoStoreTableType == PromoteRecommendTableType) {//促销推荐
        nibName = @"PromoteSaleRecommendCell";
        cellIdentifier = PromoteSaleRecommendCellID;
    }else if (_gotoStoreTableType == GoodStoreRecommendTableType) {//好店推荐
        nibName = @"GoodStoreRecommendCell";
        cellIdentifier = GoodStoreRecommendCellID;
    }else {//离我最近
        nibName = @"NearestCell";
        cellIdentifier = NearestCellID;
    }
    
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_gotoStoreTableType == PromoteRecommendTableType) {//促销推荐
        PromoteSaleRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:PromoteSaleRecommendCellID forIndexPath:indexPath];
        cell.serviceModel = self.dataArr[indexPath.row];
        return cell;
    }else if (_gotoStoreTableType == GoodStoreRecommendTableType) {//好店推荐
        GoodStoreRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodStoreRecommendCellID forIndexPath:indexPath];
        cell.recommendStoreModel = self.dataArr[indexPath.row];
        return cell;
    }else {//离我最近
        NearestCell *cell = [tableView dequeueReusableCellWithIdentifier:NearestCellID forIndexPath:indexPath];
        cell.awareStoreModel = self.dataArr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 98;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickItemBlock) {
        NSNumber *itemID;
        if (_gotoStoreTableType == PromoteRecommendTableType) {//促销推荐
            ServiceModel *model = self.dataArr[indexPath.row];
            itemID = model.ServiceModelID;
        }else if (_gotoStoreTableType == GoodStoreRecommendTableType) {//好店推荐
            RecommendStoreModel *model= self.dataArr[indexPath.row];
            itemID = model.RecommendStoreModelID;
        }else {//离我最近
            AwareStoreModel *model = self.dataArr[indexPath.row];
            itemID = model.goodsId;
        }
        self.clickItemBlock(itemID);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





@end

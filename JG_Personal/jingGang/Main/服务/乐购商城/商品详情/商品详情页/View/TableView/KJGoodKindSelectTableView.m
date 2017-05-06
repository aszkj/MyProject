//
//  KJGoodKindSelectTableView.m
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJGoodKindSelectTableView.h"
#import "KGGoodKindSelectCell.h"
#import "KJSelectGoodsCountCell.h"
#import "welfareView.h"

@implementation KJGoodKindSelectTableView

static NSString *KGGoodKindSelectCellID = @"KGGoodKindSelectCellID";
static NSString *KJSelectGoodsCountCellID = @"KJSelectGoodsCountCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[KGGoodKindSelectCell class] forCellReuseIdentifier:KGGoodKindSelectCellID];
        [self registerNib:[UINib nibWithNibName:@"KJSelectGoodsCountCell" bundle:nil] forCellReuseIdentifier:KJSelectGoodsCountCellID];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cationPropertyDic.allKeys.count + 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.cationPropertyDic.allKeys.count) {//最后一个cell
        
        KJSelectGoodsCountCell *cell = [self dequeueReusableCellWithIdentifier:KJSelectGoodsCountCellID forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor redColor];
        cell.goodsStockCount = self.goodsStockCount;
        return cell;
        
    }else{
    
        KGGoodKindSelectCell *cell = [self dequeueReusableCellWithIdentifier:KGGoodKindSelectCellID forIndexPath:indexPath];
//        cell.typeTitle = @"颜色";
//        cell.typeArr = @[@"红色",@"黄色",@"绿色绿色",@"绿色绿色",@"红色"];
        NSString *cationKey = self.cationPropertyDic.allKeys[indexPath.row];
        cell.typeTitle = cationKey;
        cell.typeArr = [self _getPropertyArrWithCationKey:cationKey];
        cell.properArr = self.cationPropertyDic[cationKey];

        return cell;
    }
}


-(NSArray *)_getPropertyArrWithCationKey:(NSString *)cationKey{
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in self.cationPropertyDic[cationKey]) {
        NSString *propertyStr = dic[@"value"];
        [arr addObject:propertyStr];
    }
    
    return (NSArray *)arr;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.cationPropertyDic.allKeys.count) {
        return 44;
    }else{
        welfareView *welfView = [welfareView new];
        //计算高度
        NSString *cationKey = self.cationPropertyDic.allKeys[indexPath.row];
        CGFloat typeHeight = [welfView beginCaculateHeightWithTitleArr:[self _getPropertyArrWithCationKey:cationKey]];
        return 30 + typeHeight + 15;
    }
}



@end

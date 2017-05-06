//
//  KJOrderDetailResultTableView.m
//  jingGang
//
//  Created by 张康健 on 15/8/12.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJOrderDetailResultTableView.h"
#import "KJOrderdetailResultCell.h"

@implementation KJOrderDetailResultTableView


static NSString *KJOrderdetailResultCellID = @"KJOrderdetailResultCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"KJOrderdetailResultCell" bundle:nil] forCellReuseIdentifier:KJOrderdetailResultCellID];
    }
    
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.resultData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZhengZhuangAllCell *cell = [self dequeueReusableCellWithIdentifier:zhengZhuangAllCellID forIndexPath:indexPath];
//
    KJOrderdetailResultCell *cell = [tableView dequeueReusableCellWithIdentifier:KJOrderdetailResultCellID forIndexPath:indexPath];
    NSDictionary *dic = self.resultData[indexPath.row];
    NSString *key = [dic allKeys][0];
    cell.firstItemLabel.text = key;
    NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",[dic[key] floatValue]];
//    cell.secondItemLabel.text = [dic[key] stringValue];
    cell.secondItemLabel.text = priceStr;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 21;
    
}




@end

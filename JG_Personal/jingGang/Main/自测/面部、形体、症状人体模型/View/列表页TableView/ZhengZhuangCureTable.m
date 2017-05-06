//
//  ZhengZhuangCureTable.m
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ZhengZhuangCureTable.h"
#import "zhengZhuangCureCell.h"

@implementation ZhengZhuangCureTable

static NSString *zhengZhuangCureCellID = @"zhengZhuangCureCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self _init];
    }
    
    return self;
}


-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
    
    [self registerNib:[UINib nibWithNibName:@"zhengZhuangCureCell" bundle:nil]  forCellReuseIdentifier:zhengZhuangCureCellID];
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.data.count;
//    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zhengZhuangCureCell *cell = [self dequeueReusableCellWithIdentifier:zhengZhuangCureCellID forIndexPath:indexPath];

    if (self.isFaceClick) {
        
        NSDictionary *dic = self.data[indexPath.row];
        cell.zhengZhuangCureLabel.text = dic[@"title"];
    }else{
    
        NSDictionary *dic = self.data[indexPath.row];
        cell.zhengZhuangCureLabel.text = dic[@"name"];
        
    }
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 48;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.isFaceClick) {
        
        NSDictionary *dic = self.data[indexPath.row];
        long ID = [dic[@"id"] longValue];
        if (self.testBlock != nil) {
            self.testBlock(ID);
        }
    }else{
        
        NSDictionary *dic = self.data[indexPath.row];
        if (self.foodCulateBlock) {
            self.foodCulateBlock(dic);
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




@end

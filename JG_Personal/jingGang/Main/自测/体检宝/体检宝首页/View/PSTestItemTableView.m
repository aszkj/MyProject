//
//  PSTestItemTableView.m
//  jingGang
//
//  Created by 张康健 on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PSTestItemTableView.h"
#import "PSTestItemCell.h"

@implementation PSTestItemTableView

static NSString *PSTestItemCellID = @"PSTestItemCellID";

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
    [self registerNib:[UINib nibWithNibName:@"PSTestItemCell" bundle:nil]  forCellReuseIdentifier:PSTestItemCellID];
    self.rowHeight = 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSTestItemCell *cell = [self dequeueReusableCellWithIdentifier:PSTestItemCellID forIndexPath:indexPath];
    NSDictionary *dic = self.data[indexPath.row];
    cell.itemImgView.image = [UIImage imageNamed:dic[@"itemImgName"]];
    cell.itemLabel.text = dic[@"itemName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemClickBlock) {
        self.itemClickBlock(indexPath);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end

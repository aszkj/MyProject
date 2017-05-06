//
//  MycommonTableView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/22.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MycommonTableView.h"
#import "GlobleErrorView.h"

@implementation MycommonTableView
{
    UITableViewCell *cell;
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self _init];
        
    }
    return self;
}

- (void)_init {
    self.delegate = self;
    self.dataSource = self;
    self.editingStyle = UITableViewCellEditingStyleNone;
    self.firstSectionHeaderHeight = 0;
    self.cellHeight = 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return self.dataLogicModule.currentDataModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     cell = [self dequeueReusableCellWithIdentifier:self.cellIdentifer forIndexPath:indexPath];
    NSAssert(self.cellIdentifer != nil, @"cell标识符不能为空");
    id model = self.self.dataLogicModule.currentDataModelArr[indexPath.row];
    NSAssert(self.configurecellBlock != nil, @"配置cell的block不能为空");
    self.configurecellBlock(tableView,model,cell);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.firstSectionHeaderNibName) {
        if (self.secontionHeaderHeightBlock) {
            return self.secontionHeaderHeightBlock(tableView,section);
        }else {
            return self.firstSectionHeaderHeight;
        }
    }else {
        return self.firstSectionHeaderHeight > 0 ? self.firstSectionHeaderHeight : 0.00000001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.firstSectionFooterNibName) {
        if (self.secontionFooterHeightBlock) {
            return self.secontionFooterHeightBlock(tableView,section);
        }else {
            return self.firstSectionFooterHeight;
        }
    }else {
        return self.firstSectionFooterHeight > 0 ? self.firstSectionFooterHeight : 0.00000001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.cellHeightBlock) {
        id model = self.self.dataLogicModule.currentDataModelArr[indexPath.row];
        return self.cellHeightBlock(tableView,model);
    }else {
        return self.cellHeight;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.firstSectionHeaderNibName) {
        UIView *firstSectionHeaderView = BoundNibView(self.firstSectionHeaderNibName, UIView);
        if (self.configurefirstSectionHeaderBlock) {
            self.configurefirstSectionHeaderBlock(tableView,nil,firstSectionHeaderView);
        }
        return firstSectionHeaderView;
    }else {
        return nil;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.firstSectionFooterNibName) {
        UIView *firstSectionFooterView = BoundNibView(self.firstSectionFooterNibName, UIView);
        if (self.configureTablefirstSectionFooterBlock) {
            self.configureTablefirstSectionFooterBlock(tableView,nil,firstSectionFooterView);
        }
        return firstSectionFooterView;
    }else {
        return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.editingStyle == UITableViewCellEditingStyleNone ? NO : YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.editingStyle;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    
    if (self.editingCellBlock) {
        NSAssert(self.editingStyle != UITableViewCellEditingStyleNone, @"设置了编辑block,没有设置cell编辑类型");
        id model = self.self.dataLogicModule.currentDataModelArr[indexPath.row];
        self.editingCellBlock(tableView,editingStyle,indexPath,model);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.clickCellBlock) {
        self.clickCellBlock(tableView,self.dataLogicModule.currentDataModelArr[indexPath.row],cell,indexPath);
    }
    [self deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -------------------Private Method----------------------
- (void)_registerCellForNibName:(NSString *)cellNibName {
    self.cellIdentifer = [cellNibName stringByAppendingString:@"ID"];
    [self registerNib:[UINib nibWithNibName:cellNibName bundle:nil]  forCellReuseIdentifier:self.cellIdentifer];

}
-(void)setCellNibName:(NSString *)cellNibName {
    
    _cellNibName = cellNibName;
    [self _registerCellForNibName:cellNibName];
}



-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(ConfigureCellBlock)configurecellBlock
{
    [self configurecellNibName:cellNibName cellDataSource:nil configurecellData:configurecellBlock clickCell:nil];
}

-(void)configurecellNibName:(NSString *)cellNibName
          configurecellData:(ConfigureCellBlock)configurecellBlock
                  clickCell:(ClickTableCellBlock)clickCellBlock
{
    [self configurecellNibName:cellNibName cellDataSource:nil configurecellData:configurecellBlock clickCell:clickCellBlock];
}

-(void)configurecellNibName:(NSString *)cellNibName
             cellDataSource:(NSArray *)cellDataSource
          configurecellData:(ConfigureCellBlock)configurecellBlock
                  clickCell:(ClickTableCellBlock)clickCellBlock
{
    [self _registerCellForNibName:cellNibName];
    self.dataLogicModule.currentDataModelArr = [cellDataSource mutableCopy];
    self.configurecellBlock = configurecellBlock;
    self.clickCellBlock = clickCellBlock;
}


#pragma mark - 配置firstSectionHeader/Footer
- (void)configureFirstSectioHeaderNibName:(NSString *)firstSectionHeaderNibName
    ConfigureTablefirstSectionHeaderBlock:(ConfigureTablefirstSectionHeaderBlock)configurefirstSectionHeaderBlock
{
    
    self.configurefirstSectionHeaderBlock = configurefirstSectionHeaderBlock;
    self.firstSectionHeaderNibName = firstSectionHeaderNibName;
    
}
- (void)configureFirstSectioFooterNibName:(NSString *)firstSectionFooterNibName
    ConfigureTablefirstSectionFooterBlock:(ConfigureTablefirstSectionFooterBlock)configurefirstSectionFooterBlock
{
    self.configureTablefirstSectionFooterBlock = configurefirstSectionFooterBlock;
    self.firstSectionFooterNibName = firstSectionFooterNibName;

}


@end

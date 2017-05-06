//
//  BaseTopbarTypeHelper.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseTableView;
@interface BaseTopbarTypeHelper : NSObject

//初始化方法，可重写，也可不重写
-(id)initWithTableCount:(NSInteger)tableCount vcRootView:(UIView *)vcRootView;

//是否每次切换topbar都进行刷新，默认为NO
@property (nonatomic, assign)BOOL isAutoFreshEachTimeWhenSwitchedTopbarIndex;

//每次当前刷新的表
@property (nonatomic, strong)BaseTableView *currentFreshTableView;

//表放在那个view上，即表的父视图
@property (nonatomic, strong)UIView *baseView;

//@property (nonatomic, strong)VApiManager *vapManager;

@property (nonatomic, strong)NSMutableArray *contentTableArr;

#pragma mark ----------------------------- 供子类调用 -----------------------------
#pragma mark - 设置第index个表的属性，每次创建一张表，就调用设置属性
-(void)setTableAttributeAtIndex:(NSInteger )index forTableView:(BaseTableView *)tableView;

#pragma mark - 数据请求之后，将模型放在数组之后调用
-(void)configureTableAfterRequestData:(NSArray *)modelDatas;

#pragma mark ----------------------------- 供子类重写 -----------------------------
#pragma mark - 请求数据 - @required
-(void)requestData;

#pragma mark - 根据点击那张表，返回请求类型 - @required
-(NSString *)getRequestTypeWithTalbleTag:(NSInteger)tag;

#pragma mark - 加载每张表
-(void)loadTableInView:(UIView *)vcRootView tableCount:(NSInteger)tableCount;


#pragma mark ----------------------------- 一般供外部类调用(控制器，view等)，也可以供子类重写 -----------------------------
//点击上面的topbar部分，做相应的处理，隐藏，自动刷新等
-(void)clickTopbarAtIndex:(NSInteger)clickedTopBarIndex;

@end

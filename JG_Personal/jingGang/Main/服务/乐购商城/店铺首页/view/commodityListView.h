//
//  commodityListView.h
//  jingGang
//
//  Created by thinker on 15/8/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    classSearch,    //默认为商品分类
    keywordSearch,  //关键字搜索
    storeList       //店铺列表
}WSJShopAndSearchType;

@interface commodityListView : UIView
//类型
@property (nonatomic, assign) WSJShopAndSearchType type;
//商品分类id和keyword
@property (nonatomic, copy) NSString * keyword;
@property (nonatomic, copy) NSNumber *ID;


//点击筛选按钮回调(商品列表的数据)
@property (nonatomic, copy) void(^siftAction)(NSArray *data);
//1卖家包邮goodsTransfee   (默认)nil
@property (nonatomic, copy) NSString *transfee;
//-1(默认)全部0仅显示有货goodsInventory
@property (nonatomic, copy) NSNumber *inventory;
//properties商品属性|如:|6,白色
@property (nonatomic, copy) NSString *properties;
//商品列表筛选的数据
@property (nonatomic, strong) NSMutableArray *shopgoodsProperty;


//店铺的筛选结果id
@property (nonatomic, copy) NSNumber *categoryID;


//点击TableView中cell的某行回调
@property (nonatomic, copy) void(^selectRowBlock)(NSDictionary *dict);

- (void)clearData;
- (void)reloadData;


@end

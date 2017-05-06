//
//  DLGoodsSearchShowView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/15.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsSearchShowView.h"
#import "DLGoodsAllshowCell.h"
#import "GlobleConst.h"
#import "GoodsModel.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
#import "DLSearchedGoodsCell.h"
#import "DLGoodsSearchCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ProjectStandardUIDefineConst.h"
@interface DLGoodsSearchShowView()

@end

@implementation DLGoodsSearchShowView

#pragma mark -------------------Init Method----------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self _initGoodsSearchTableView];
    }
    return self;
}
-(void)_init {
    [self _initGoodsSearchTableView];
}


-(void)_initGoodsSearchTableView {
    
    self.searchGoodsTableView = [[MycommonTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarAndStatusBarHeight)];
    [self addSubview:self.searchGoodsTableView];
    self.searchGoodsTableView.backgroundColor = KViewBgColor;
    self.searchGoodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchGoodsTableView.allowsSelection = NO;
    self.searchGoodsTableView.noDataLogicModule.nodataAlertTitle = @"抱歉，没有搜到相关商品";
    WEAK_SELF
    
    self.searchGoodsTableView.cellHeight = IsShareStock ? kGoodsSearchCellHeight - 40 : kGoodsSearchCellHeight;
    [self.searchGoodsTableView configurecellNibName:@"DLGoodsSearchCell" configurecellData:^(UITableView *tableView,id cellModel, UITableViewCell *cell) {
        GoodsModel *model = (GoodsModel *)cellModel;
        DLGoodsSearchCell *searchGoodsCell = (DLGoodsSearchCell *)cell;
        [searchGoodsCell setCellModel:model];
        WEAK_OBJ(model)
        WEAK_OBJ(searchGoodsCell)
        searchGoodsCell.onOffShelfBlock = ^(NSNumber *shelfNumber){
            
            [weak_self _requestGoodsOnOffShelfOffShelfNumber:shelfNumber atGoodsCell:weak_searchGoodsCell ofCellModel:weak_model];
        };
    } clickCell:^(UITableView *tableView,id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        
    }];
    
    [self.searchGoodsTableView headerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
    [self.searchGoodsTableView footerRreshRequestBlock:^{
        [weak_self requestGoodsData];
    }];
    
}

- (NSArray *)_getTestData{
    GoodsModel *model1 = [[GoodsModel alloc] init];
    model1.goodsId = @"134";
    model1.goodsName = @"水果绿茶";
    model1.goodsOriginalPrice = @(10.0);
    model1.goodsVipPrice = @(11.0);
    model1.goodsOnShelf = @(1);
    model1.goodsSalesVulome = @(100);
    model1.goodsStock = @(100);

    model1.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    GoodsModel *model2 = [[GoodsModel alloc] init];
    model2.goodsId = @"135";
    model2.goodsName = @"水果绿茶";
    model2.goodsOriginalPrice = @(10.0);
    model2.goodsVipPrice = @(11.0);
    model2.goodsSalesVulome = @(100);
    model2.goodsStock = @(100);
    model2.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    model2.goodsOnShelf = @(1);

    
    GoodsModel *model3 = [[GoodsModel alloc] init];
    model3.goodsId = @"136";
    model3.goodsName = @"水果绿茶";
    model3.goodsOriginalPrice = @(10.0);
    model3.goodsVipPrice = @(11.0);
    model3.goodsOnShelf = @(0);
    model3.goodsSalesVulome = @(100);
    model3.goodsStock = @(100);
    model3.goodsThumbnail = @"http://pic1.nipic.com/2008-09-19/2008919124332774_2.jpg";
    
    NSArray *class1Arr = @[model1,model2,model3];
    return class1Arr;
}


#pragma mark -------------------Api Method----------------------
- (void)requestGoodsData {
    
    NSDictionary *requestParam = @{
                                   @"enabledFlag":@(0),
                                   @"keyword":self.keyWords,
                                   kRequestPageNumKey:@(self.searchGoodsTableView.dataLogicModule.requestFromPage),
                                   kRequestPageSizeKey:@(kRequestDefaultPageSize)};
    
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_GoodsSearch block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        NSArray *resultArr = resultDic[EntityKey][@"list"];
        NSArray *transferedArr = [GoodsModel objectGoodsModelWithGoodsArr:resultArr];
        [self.searchGoodsTableView configureTableAfterRequestPagingData:transferedArr];
    }];
    

}

- (void)_requestGoodsOnOffShelfOffShelfNumber:(NSNumber *)shelfNumber atGoodsCell:(DLGoodsSearchCell *)searchedGoodsCell ofCellModel:(GoodsModel *)goodsModel {
    
    NSInteger requestShelfNumber = 0;
    NSString *loadingTitle = nil;
    if (shelfNumber.integerValue) {
        requestShelfNumber = kShelfNumberOnShelf;
        loadingTitle = @"正在上架..";
    }else{
        requestShelfNumber = kShelfNumberOffShelf;
        loadingTitle = @"正在下架..";
    }
    NSDictionary *requestParam = @{@"saleProductIds":goodsModel.goodsId,
                                   @"enabledFlag":@(requestShelfNumber)
                                   };
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hub.labelText = loadingTitle;
    [AFNHttpRequestOPManager postWithParameters:requestParam subUrl:kUrl_SetGoodsOnOffShelf block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code  != 1) {
            hub.labelText = error.localizedDescription;
        }else {
            NSString *hideSuccessTitle = shelfNumber.integerValue ? @"上架成功" : @"下架成功";
            hub.labelText = hideSuccessTitle;
            goodsModel.goodsOnShelf = @(shelfNumber.integerValue);
            [searchedGoodsCell configureOnOffShelfUiByGoodsModel:goodsModel];
        }
        [hub hide:YES afterDelay:0.2];
    }];

    
    
    
   
}

#pragma mark -------------------Setter/Getter Method----------------------
-(void)setKeyWords:(NSString *)keyWords {
    _keyWords = keyWords;
//    [self.searchGoodsTableView configureTableAfterRequestData:[self _getTestData]];
    self.searchGoodsTableView.dataLogicModule.requestFromPage = 1;
    [self requestGoodsData];
}

@end

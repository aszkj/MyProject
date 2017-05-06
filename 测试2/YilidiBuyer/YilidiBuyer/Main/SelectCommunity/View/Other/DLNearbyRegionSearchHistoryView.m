//
//  DLNearbyRegionSearchHistoryView.m
//  YilidiBuyer
//
//  Created by yld on 16/6/2.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLNearbyRegionSearchHistoryView.h"
#import "MycommonTableView.h"
#import "DLSearchAdressCell.h"
#import "DLCacheManager.h"
#import "UIButton+Block.h"
#import <Masonry/Masonry.h>
const CGFloat historyNearbyRegionSearchSectionHeaderHeight = 50;
const CGFloat historyNearbyRegionSearchSectionFooterHeight = 100;

@interface DLNearbyRegionSearchHistoryView()

@property (nonatomic,strong)MycommonTableView *nearbyRegionSearchHistoryTableView;

@property (nonatomic, strong)UILabel *noHistorySearchLabel;


@end

@implementation DLNearbyRegionSearchHistoryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.nearbyRegionSearchHistoryTableView = [[MycommonTableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight-kNavBarAndStatusBarHeight-10) style:UITableViewStyleGrouped];
    self.nearbyRegionSearchHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.nearbyRegionSearchHistoryTableView];
    [self _configureNearbyRegionSearchHistoryTableView];
    [self _getHistoryData];
}

- (void)_getHistoryData {

    NSArray *cachedNearbySearchArr = [[DLCacheManager sharedManager] cachedNearbyRegionSearchHistoryDatas];
    [self _configureUIHasOrNoHistory];
    self.nearbyRegionSearchHistoryTableView.dataLogicModule.currentDataModelArr = [cachedNearbySearchArr mutableCopy];
    [self.nearbyRegionSearchHistoryTableView reloadData];
    
}

- (void)_requestCommunityInfoWithCommunityId:(NSString *)communityId {
    
    NSDictionary *param = @{@"communityId":communityId};
    [AFNHttpRequestOPManager postWithParameters:param subUrl:kUrl_GetCommunityDetailInfo block:^(NSDictionary *resultDic, NSError *error) {
        if (isEmpty(resultDic[EntityKey])) {
            return ;
        }
        CommunityModel *communityModel = [[CommunityModel alloc] initWithDefaultDataDic:resultDic[EntityKey]];
        emptyBlock(self.selectHistorySearchRegionBlock,communityModel);

    }];
}

- (void)_configureUIHasOrNoHistory {
    
    NSInteger historyCount = [DLCacheManager sharedManager].cachedNearbyRegionSearchHistoryDatas.count;
    self.nearbyRegionSearchHistoryTableView.hidden = !historyCount;
    self.noHistorySearchLabel.hidden = historyCount;
}


- (void)_configureNearbyRegionSearchHistoryTableView {
    
    self.nearbyRegionSearchHistoryTableView.cellHeight = kSearchedAdressCellHeight;
    WEAK_SELF
    [self.nearbyRegionSearchHistoryTableView configurecellNibName:@"DLSearchAdressCell" configurecellData:^(UITableView *tableView, id cellModel, UITableViewCell *cell) {
        CommunityModel *adressModel = (CommunityModel *)cellModel;
        DLSearchAdressCell *searchAdressCell = (DLSearchAdressCell *)cell;
        [searchAdressCell setNearbySearchAdressWithNearbyAdressModel:adressModel];
        
    } clickCell:^(UITableView *tableView, id cellModel, UITableViewCell *cell, NSIndexPath *clickIndexPath) {
        CommunityModel *adressModel = (CommunityModel *)cellModel;
        [[DLCacheManager sharedManager] cacheNearbyRegionSearchWithAdressModel:adressModel];
        weak_self.hidden = YES;
        [weak_self _requestCommunityInfoWithCommunityId:adressModel.communityId];
    }];
    
    self.nearbyRegionSearchHistoryTableView.firstSectionHeaderHeight = historyNearbyRegionSearchSectionHeaderHeight;
    [self.nearbyRegionSearchHistoryTableView configureFirstSectioHeaderNibName:@"DLHistoryRegionSearchTableSectionHeaderView" ConfigureTablefirstSectionHeaderBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionHeaderView) {
        
    }];
    self.nearbyRegionSearchHistoryTableView.firstSectionFooterHeight = historyNearbyRegionSearchSectionFooterHeight;
    [self.nearbyRegionSearchHistoryTableView configureFirstSectioFooterNibName:@"DLHistoryRegionSearchTableSectionFooterView" ConfigureTablefirstSectionFooterBlock:^(UITableView *tableView, id cellModel, UIView *firstSectionFooterView) {
        UIButton *clearHistoryButton = (UIButton *)[firstSectionFooterView viewWithTag:1];
        [clearHistoryButton addActionHandler:^(NSInteger tag) {
            [[DLCacheManager sharedManager] clearNearbyRegionSearchCache];
            [weak_self _configureUIHasOrNoHistory];
            MycommonTableView *historyTableView = (MycommonTableView *)tableView;
            [historyTableView.dataLogicModule.currentDataModelArr removeAllObjects];
            [historyTableView reloadData];
        }];
    }];
}

- (UILabel *)noHistorySearchLabel {
    
    if (!_noHistorySearchLabel) {
        _noHistorySearchLabel = [UILabel new];
        [self addSubview:_noHistorySearchLabel];
        [_noHistorySearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(30);
        }];
        _noHistorySearchLabel.font = kSystemFontSize(14.0f);
        _noHistorySearchLabel.textAlignment = NSTextAlignmentCenter;
        _noHistorySearchLabel.textColor = [UIColor darkGrayColor];
        _noHistorySearchLabel.text = @"暂无历史搜索记录";
    }
    return _noHistorySearchLabel;
}

@end

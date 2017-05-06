//
//  DLLatestHoteSearchView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/25.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLLatestHoteSearchView.h"
#import "JCTagListView.h"
#import "LatestHoteSearchViewModel.h"
#import "CommonCategaryModel.h"
#import "DLCacheManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
const CGFloat defaultLatestSearchContentViewHeight = 100.0f;
@interface DLLatestHoteSearchView()
@property (weak, nonatomic) IBOutlet UILabel *noSearchHistoryLabel;
@property (weak, nonatomic) IBOutlet UIView *latestSearchContentView;
@property (weak, nonatomic) IBOutlet JCTagListView *hoteSearchTagView;
@property (nonatomic, strong)JCTagListView *historySearchTagView;
@property (weak, nonatomic) IBOutlet UIButton *clearHistoryButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historySearchContentViewHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hoteSearchViewHeightConstraint;

@property (nonatomic, strong)LatestHoteSearchViewModel *latestHoteSearchViewModel;


@end

@implementation DLLatestHoteSearchView

- (void)awakeFromNib {
    
    [self bindViewModel];
    
    [self _initHoteSearchTagView];
    
    [self _assignHistoryViewData];
    
    [self _assignHoteSearchViewData];
}

- (void)_initHoteSearchTagView {
    [self _configureAttributeForTagView:_hoteSearchTagView];
}

- (void)bindViewModel {
    _latestHoteSearchViewModel = [[LatestHoteSearchViewModel alloc] init];
    @weakify(self);
    [RACObserve(self.latestHoteSearchViewModel, hasSearchHistory) subscribeNext:^(NSNumber *hasSearchHistory) {
        @strongify(self);
        self.noSearchHistoryLabel.hidden = hasSearchHistory.integerValue;
        self.clearHistoryButton.hidden = !hasSearchHistory.integerValue;
        if (!hasSearchHistory.integerValue) {
            self.historySearchContentViewHeightContraint.constant = defaultLatestSearchContentViewHeight;
        }
        self.historySearchTagView.hidden = !hasSearchHistory.integerValue;

    }];
}

- (void)setShow:(BOOL)show {
    _show = show;
    self.hidden = !show;
    if (show) {
        [self _assignHistoryViewData];
    }
}

- (void)_assignHistoryViewData {
    self.historySearchTagView.tags = [[self.latestHoteSearchViewModel getHistorySearchData] mutableCopy];
    [self.historySearchTagView reloadData];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.historySearchContentViewHeightContraint.constant = self.historySearchTagView.contentHeight;
    });
}

- (void)_assignHoteSearchViewData {
    @weakify(self);
    [SVProgressHUD showWithStatus:@"拼命加载中.."];
    [[self.latestHoteSearchViewModel trigerHoteSearchDataRequestSignal] subscribeNext:^(NSArray *hoteKeysModels) {
        [SVProgressHUD dismiss];
        @strongify(self);
        self.hoteSearchTagView.tags = [hoteKeysModels mutableCopy];
        [self.hoteSearchTagView reloadData];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.hoteSearchViewHeightConstraint.constant = self.hoteSearchTagView.contentHeight;
        });
    }];
}

- (void)_configureAttributeForTagView:(JCTagListView *)tagView {
    tagView.tagCornerRadius = 2.0f;
    tagView.minuHorizonalSpace = 5.0f;
    tagView.minuVerticalSpace = 5.0f;
    tagView.contentSectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    tagView.tagStrokeColor = UIColorFromRGB(0xF2F3F4);
    tagView.canSelectTags = NO;
    tagView.canSelectMutialTags = NO;
    WEAK_SELF
    [tagView setCompletionBlockWithSelected:^(NSInteger index, NSArray *selectedTags, NSArray *tags) {
        if (index > tags.count) {
            return;
        }
        CommonCategaryModel *selectedCategaryModel = tags[index];
        emptyBlock(weak_self.latestHoteSearchSelectKeyWordsBlock,selectedCategaryModel.categaryName);
        [[DLCacheManager sharedManager] cacheGoodsSearchKeyWords:selectedCategaryModel.categaryName];
        weak_self.hidden = YES;
    }];
}


- (IBAction)clearHistorySearchAction:(id)sender {
    [self.latestHoteSearchViewModel clearHistorySearchData];
    self.historySearchTagView.hidden = YES;
}

- (JCTagListView *)historySearchTagView {

    if (!_historySearchTagView) {
        _historySearchTagView = [JCTagListView new];
        [self.latestSearchContentView addSubview:_historySearchTagView];
        WEAK_SELF
        [_historySearchTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weak_self.latestSearchContentView);
        }];
        [self _configureAttributeForTagView:_historySearchTagView];
    }
    return _historySearchTagView;
}

@end

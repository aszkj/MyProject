//
//  DLGoodsManageMentVC.m
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLGoodsThirdLevelClassController.h"
#import "SegementView.h"
#import "ClassifitionGoodsManageView.h"
#import <Masonry/Masonry.h>
#import "UIBarButtonItem+WNXBarButtonItem2.h"
#import "DLSearchVC.h"
#import "GlobleConst.h"
#import "GoodsClassModel.h"
#import "DLTagShowView.h"

typedef enum : NSUInteger {
    SiftGoodsByClass,
    SiftGoodsBySortRule,
} SiftGoodsRuleType;


@interface DLGoodsThirdLevelClassController ()

@property (nonatomic, strong)ClassifitionGoodsManageView *onShelfGoodsView;

@property (nonatomic, strong)ClassifitionGoodsManageView *offShelfGoodsView;

@property (nonatomic, strong)SegementView *onOffShelfSwitchView;
@property (weak, nonatomic) IBOutlet UIButton *classArrowButton;
@property (weak, nonatomic) IBOutlet UIButton *sortArrowButton;

@property (nonatomic, strong)DLTagShowView *goodsSiftTagView;
@property (nonatomic, assign)SiftGoodsRuleType siftGoodsRuleType;

@property (nonatomic,copy) NSMutableArray *goodsTotalSortArr;
@property (nonatomic,copy) NSArray *goodsAllClassArr;

@property (nonatomic,assign) NSInteger goodsSortRuleNumber;
@property (nonatomic,copy) NSString *goodsClassCode;

@property (weak, nonatomic) IBOutlet UIButton *topClassSelectTitleButton;
@property (weak, nonatomic) IBOutlet UIButton *topSortSelectButton;

@end

@implementation DLGoodsThirdLevelClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _init];
    
    [self _initOnOffShelfSwitchView];
    
    [self _initClassInfo];
    
    [self _initOnShelfView];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navBarColor = KSelectedBgColor;
    self.backIconName = @"返回箭头白色";
}


#pragma mark -------------------Init Method----------------------
-(void)_init {
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithNormalImage:@"搜索白" target:self action:@selector(searchGoods)];
}

-(void)_initOnOffShelfSwitchView {
    
    self.onOffShelfSwitchView = [[SegementView alloc] initWithSegementFrame:CGRectMake(0, 0, 170, 28) segementTitles:@[@"销售中",@"已下架"]];
    self.navigationItem.titleView = self.onOffShelfSwitchView;
    WEAK_SELF
    self.onOffShelfSwitchView.selectedSegementBlock = ^(NSInteger selectIndex){
        if (selectIndex == 0) {
            weak_self.onShelfGoodsView.hidden = NO;
            weak_self.offShelfGoodsView.hidden = YES;
        }else {
            weak_self.onShelfGoodsView.hidden = YES;
            weak_self.offShelfGoodsView.hidden = NO;
        }
        [weak_self _updateOnOffShelfViewData];
    };
}

- (void)_initClassInfo {
    
    NSMutableArray *classArr = [NSMutableArray arrayWithCapacity:self.goodsClassModel.subClassList.count];
    for (GoodsClassModel *classModel in self.goodsClassModel.subClassList) {
        CommonCategaryModel *transferModel = [[CommonCategaryModel alloc] init];
        transferModel.categaryName = classModel.className;
        transferModel.categaryId = classModel.classCode;
        [classArr addObject:transferModel];
    }
    self.goodsAllClassArr = [classArr copy];
    NSInteger selectClassModelIndex = [self _getDefaultSelectIndex];
    if (selectClassModelIndex != -1001) {
        CommonCategaryModel *transferModel = (CommonCategaryModel *)[self.goodsAllClassArr objectAtIndex:selectClassModelIndex];
        transferModel.selected = YES;
        [self _setTopSelectClassTitleWithClassModel:transferModel];
    }else {
        [self _setTopSelectClassButtonTitle:self.goodsClassModel.className];
    }
    
}


- (void)_initOnShelfView {
    self.onShelfGoodsView.hidden = NO;
    self.onOffShelfSwitchView.selectedSegementIndex = 0;
    self.goodsClassCode = [self _getDefaultClassCode];
    self.goodsSortRuleNumber = [self _getDefaultSortRuleNumber];
    [self _updateOnOffShelfViewData];
}

#pragma mark ---------------------Private Method------------------------------
- (void)_updateOnOffShelfViewData {
    if (self.onOffShelfSwitchView.selectedSegementIndex == 0) {
        [self.onShelfGoodsView setGoodsClassCode:self.goodsClassCode sortRuleNumber:self.goodsSortRuleNumber];
    }else {
        [self.offShelfGoodsView setGoodsClassCode:self.goodsClassCode sortRuleNumber:self.goodsSortRuleNumber];
    }
}

- (void)_setTopSelectClassButtonTitle:(NSString *)title {
    [self.topClassSelectTitleButton setTitle:title forState:UIControlStateNormal];
}

- (void)_setTopSelectClassTitleWithClassModel:(CommonCategaryModel *)classModel {
    [self _setTopSelectClassButtonTitle:classModel.categaryName];
}

- (void)_setTopSelectSortRuleTitle:(NSString *)title {
    [self.topSortSelectButton setTitle:title forState:UIControlStateNormal];
}


- (NSString *)_getDefaultClassCode {
    NSInteger selectClassModelIndex = [self _getDefaultSelectIndex];
    if (selectClassModelIndex == -1001) {
        return self.goodsClassModel.classCode;
    }else {
        return [(GoodsClassModel *)self.goodsClassModel.subClassList[selectClassModelIndex] classCode];
    }
}

- (NSInteger)_getDefaultSortRuleNumber {
    return [[self.goodsTotalSortArr.firstObject categaryId] integerValue];
}

- (NSInteger)_getDefaultSelectIndex {
    
    if (!self.goodsClassModel.subClassList.count) {
        return -1001;
    }else {
        if (isEmpty(self.goodsClassChildModel)) {
            return 0;
        }else {
            return [self.goodsClassModel.subClassList indexOfObject:self.goodsClassChildModel];
        }
    }
}


- (void)_switchDifferentGoodsSiftRule:(SiftGoodsRuleType)siftGoodsRuleType {
    NSArray *showData = nil;
    UIButton *willSelectButton = nil;
    if (siftGoodsRuleType == SiftGoodsByClass) {
        showData = self.goodsAllClassArr;
        willSelectButton = self.classArrowButton;
    }else {
        showData = self.goodsTotalSortArr;
        willSelectButton = self.sortArrowButton;
    }
    if (!showData.count) {
        return;
    }
    
    _siftGoodsRuleType = siftGoodsRuleType;
    willSelectButton.selected = YES;
    [self.goodsSiftTagView showWithData:showData];

}


#pragma mark -------------------Action Method----------------------
- (void)searchGoods {
    DLSearchVC *goodsSearchVC = [[DLSearchVC alloc] init];
    goodsSearchVC.searchType = SearchType_Goods;
    [self navigatePushViewController:goodsSearchVC animate:YES];
}

- (IBAction)clickThirdLevelClassAction:(id)sender {
    self.siftGoodsRuleType = SiftGoodsByClass;
}

- (IBAction)clickSortRuleAction:(id)sender {
    self.siftGoodsRuleType = SiftGoodsBySortRule;
}

#pragma mark -------------------Setter/Getter Method----------------------
- (void)setSiftGoodsRuleType:(SiftGoodsRuleType)siftGoodsRuleType {
    [self _switchDifferentGoodsSiftRule:siftGoodsRuleType];
}

- (NSArray *)getTotalSortArr{
    
    CommonCategaryModel *model0 = [[CommonCategaryModel alloc] init];
    model0.categaryName = @"默认排序";
    model0.categaryId = @"01";
    model0.selected = YES;
    
    CommonCategaryModel *model1 = [[CommonCategaryModel alloc] init];
    model1.categaryName = @"销量最高";
    model1.categaryId = @"22";
    model1.selected = NO;
    
    CommonCategaryModel *model2 = [[CommonCategaryModel alloc] init];
    model2.categaryName = @"库存最低";
    model2.categaryId = @"11";
    model2.selected = NO;
    
    CommonCategaryModel *model3 = [[CommonCategaryModel alloc] init];
    model3.categaryName = @"库存最高";
    model3.categaryId = @"12";
    model3.selected = NO;
    
    CommonCategaryModel *model4 = [[CommonCategaryModel alloc] init];
    model4.categaryName = @"销量最低";
    model4.categaryId = @"21";
    model4.selected = NO;
    
    NSArray *goodsTotalSortArr = @[model0,model1,model2,model3,model4];
    return goodsTotalSortArr;
}

- (NSArray *)getGoodsClassArr{
    CommonCategaryModel *model1 = [[CommonCategaryModel alloc] init];
    model1.categaryName = @"分类一";
    model1.selected = YES;
    
    CommonCategaryModel *model2 = [[CommonCategaryModel alloc] init];
    model2.categaryName = @"分类二分类二分类二分类二";
    model2.selected = NO;
    
    CommonCategaryModel *model3 = [[CommonCategaryModel alloc] init];
    model3.categaryName = @"分类三";
    model3.selected = NO;
    
    CommonCategaryModel *model4 = [[CommonCategaryModel alloc] init];
    model4.categaryName = @"分类四";
    model4.selected = NO;
    
    NSArray *goodsClassArr = @[model1,model2,model3,model4];
    return goodsClassArr;
}



- (ClassifitionGoodsManageView *)onShelfGoodsView {
    
    if (!_onShelfGoodsView) {
        _onShelfGoodsView = BoundNibView(@"ClassifitionGoodsManageView", ClassifitionGoodsManageView);
        [self.view addSubview:_onShelfGoodsView];
        [_onShelfGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(39);
            make.left.bottom.right.mas_equalTo(self.view);
        }];
        _onShelfGoodsView.shelfNumber = @(kShelfNumberOnShelf);
        
    }
    return _onShelfGoodsView;
    
}

- (ClassifitionGoodsManageView *)offShelfGoodsView {
    
    if (!_offShelfGoodsView) {
        _offShelfGoodsView = BoundNibView(@"ClassifitionGoodsManageView", ClassifitionGoodsManageView);
        [self.view addSubview:_offShelfGoodsView];
        [_offShelfGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(39);
            make.left.bottom.right.mas_equalTo(self.view);
        }];
        _offShelfGoodsView.shelfNumber = @(kShelfNumberOffShelf);
        if (_goodsSiftTagView) {
            [self.view insertSubview:_goodsSiftTagView aboveSubview:_offShelfGoodsView];
        }
    }
    return _offShelfGoodsView;
}

-(DLTagShowView *)goodsSiftTagView {
    
    if (!_goodsSiftTagView) {
        _goodsSiftTagView = [DLTagShowView new];
        [self.view addSubview:_goodsSiftTagView];
        WEAK_SELF
        [_goodsSiftTagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weak_self.onShelfGoodsView.mas_top).with.offset(0);
            make.left.bottom.right.mas_equalTo(weak_self.onShelfGoodsView);
        }];
        _goodsSiftTagView.selectItemBlock = ^(CommonCategaryModel *model){
            NSString *selectId = model.categaryId;
            if (weak_self.siftGoodsRuleType == SiftGoodsByClass) {
                weak_self.goodsClassCode = selectId;
                [weak_self _setTopSelectClassTitleWithClassModel:model];
                weak_self.classArrowButton.selected = NO;
            }else {
                weak_self.goodsSortRuleNumber = [selectId integerValue];
                weak_self.sortArrowButton.selected = NO;
                [weak_self _setTopSelectSortRuleTitle:model.categaryName];
            }
            [weak_self _updateOnOffShelfViewData];
        };
        
        _goodsSiftTagView.closeBlock = ^{
            UIButton *willSelectButton = nil;
            if (weak_self.siftGoodsRuleType == SiftGoodsByClass) {
                willSelectButton = self.classArrowButton;
            }else {
                willSelectButton = self.sortArrowButton;
            }
            willSelectButton.selected = NO;
        };
    }
    return _goodsSiftTagView;
    
}

- (NSMutableArray *) goodsTotalSortArr{
    
    if (!_goodsTotalSortArr) {
        _goodsTotalSortArr = [NSMutableArray arrayWithArray:[self getTotalSortArr]];
    }
    return _goodsTotalSortArr;
}




@end

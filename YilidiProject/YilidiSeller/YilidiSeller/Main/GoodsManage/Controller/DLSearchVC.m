//
//  DLGoodsSearchVC.m
//  YilidiBuyer
//
//  Created by yld on 16/5/16.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSearchVC.h"
#import "DLGoodsSearchTopView.h"
#import "DLGoodsSearchShowView.h"
#import "GoodsSearchKeyWordsListView.h"
#import "DLCacheManager.h"
#import "DLOrderSearchShowView.h"
#import <Masonry/Masonry.h>
#import "DLOrderDetailVC.h"

@interface DLSearchVC ()

@property (nonatomic, strong)DLGoodsSearchTopView *goodsSearchTopView;
@property (nonatomic, strong)DLGoodsSearchShowView *goodsSearchShowView;
@property (nonatomic, strong)DLOrderSearchShowView *orderSearchShowView;
@property (nonatomic, strong)GoodsSearchKeyWordsListView *goodsSearchKeyWordsListView;
@property (nonatomic, copy)NSString *keyWords;
@end

@implementation DLSearchVC

- (void)viewDidLoad {
    self.doNotNeedBaseBackItem = YES;
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [self _initGoodsSearchTopView];
    if (!_goodsSearchTopView) {
        [self _initGoodsSearchTopView];
    }else {
        _goodsSearchTopView.hidden = NO;
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [self.goodsSearchTopView removeFromSuperview];
    _goodsSearchTopView.hidden = YES;

}

#pragma mark -------------------Init Method----------------------
-(void)_initGoodsSearchTopView {
    self.goodsSearchTopView = BoundNibView(@"DLGoodsSearchTopView", DLGoodsSearchTopView);
    self.goodsSearchTopView.searchType = self.searchType;
    [self.navigationController.view addSubview:self.goodsSearchTopView];
    WEAK_SELF
    [self.goodsSearchTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weak_self.navigationController.view.mas_top).with.offset(20);
        make.left.right.mas_equalTo(weak_self.navigationController.view);
        make.height.mas_equalTo(44);
    }];
    
    @weakify(self);
    //下面这句有问题，因为_goodsSearchShowView是getter方法创建的，所以一开始_goodsSearchShowView就是空的，所以下面的searchShowView是nil,所以你对_goodsSearchShowView采用weak或block修饰都没什么卵用，都是空的，，只能用点语法
//    __weak DLGoodsSearchShowView *searchShowView = _goodsSearchShowView;
    __block UIView *searchView = nil;
    if (self.searchType == SearchType_Goods) {
        searchView = self.goodsSearchShowView;
    }else if (self.searchType == SearchType_Order){
        searchView = self.orderSearchShowView;
    }
    [self.goodsSearchTopView.searchTextValidateSignal subscribeNext:^(NSNumber* validate) {
        @strongify(self);
//        self.latestHoteSearchView.hidden = validate.integerValue;
        self.goodsSearchKeyWordsListView.hidden = !validate.integerValue;
        searchView.hidden = YES;
    }];
    
    self.goodsSearchTopView.searchBackBlock = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.goodsSearchTopView.cancelSearchBlock = ^(){
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    self.goodsSearchTopView.beginSearchBlock = ^(NSString *keyWords){
        //这里为什么需要延时调用，，有个坑－》点击TextFiled代理方法return或搜索按钮，上面的那个信号self.goodsSearchTopView.searchTextValidateSignal居然会走，实际上是textField.rac_textSignal会走，，所以上面的监听会走，
        [weak_self performSelector:@selector(setKeyWords:) withObject:keyWords afterDelay:0.1];
     
    };
}



#pragma mark -------------------PageNavigate Method----------------------
- (void)_enterOrderDetailPageWithOrderNo:(NSString *)orderNo {
    DLOrderDetailVC *orderDetailVC = [[DLOrderDetailVC alloc] init];
    orderDetailVC.orderNo = orderNo;
    [self navigatePushViewController:orderDetailVC animate:YES];
}

#pragma mark -------------------Getter/Setter Method----------------------
- (void)setKeyWords:(NSString *)keyWords {
    _keyWords = keyWords;
    self.goodsSearchKeyWordsListView.hidden = YES;
    if (self.searchType == SearchType_Goods) {
        self.goodsSearchShowView.hidden = NO;
        self.goodsSearchShowView.keyWords = _keyWords;
    }else if (self.searchType == SearchType_Order){
        self.orderSearchShowView.hidden = NO;
        self.orderSearchShowView.keyWords = _keyWords;
    }

    //    [[DLCacheManager sharedManager] cacheGoodsSearchKeyWords:keyWords];
}

- (DLGoodsSearchShowView *)goodsSearchShowView {
    if (!_goodsSearchShowView) {
        _goodsSearchShowView = [DLGoodsSearchShowView new];
        [self.view addSubview:_goodsSearchShowView];
        [_goodsSearchShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _goodsSearchShowView;
}

- (DLOrderSearchShowView *)orderSearchShowView {
    if (!_orderSearchShowView) {
        _orderSearchShowView = [DLOrderSearchShowView new];
        [self.view addSubview:_orderSearchShowView];
        [_orderSearchShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        WEAK_SELF
        _orderSearchShowView.comeToOrderDetailBlock = ^(NSString *orderNo){
            [weak_self _enterOrderDetailPageWithOrderNo:orderNo];
        };
    }
    return _orderSearchShowView;
}


- (GoodsSearchKeyWordsListView *)goodsSearchKeyWordsListView {
    
    if (!_goodsSearchKeyWordsListView) {
        _goodsSearchKeyWordsListView = [GoodsSearchKeyWordsListView new];
        [self.view addSubview:_goodsSearchKeyWordsListView];
        [_goodsSearchKeyWordsListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _goodsSearchKeyWordsListView;
}


@end

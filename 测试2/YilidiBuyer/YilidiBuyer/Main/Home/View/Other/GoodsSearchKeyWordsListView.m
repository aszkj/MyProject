//
//  GoodsSearchKeyWordsListView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "GoodsSearchKeyWordsListView.h"
#import "MycommonTableView.h"

@interface GoodsSearchKeyWordsListView()

@property (nonatomic,strong)MycommonTableView *goodsSearchedKeywordsTableView;

@end

@implementation GoodsSearchKeyWordsListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setup];
    }
    return self;
}

- (void)_setup {
    self.backgroundColor = [UIColor whiteColor];
    self.goodsSearchedKeywordsTableView = [[MycommonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:self.goodsSearchedKeywordsTableView];
}


@end

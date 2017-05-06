//
//  DLSearchAdressKeyWordsListView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/26.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSearchAdressKeyWordsListView.h"
#import "MycommonTableView.h"

@interface DLSearchAdressKeyWordsListView()

@property (nonatomic,strong)MycommonTableView *adressSearchedKeywordsTableView;

@end

@implementation DLSearchAdressKeyWordsListView

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
    self.adressSearchedKeywordsTableView = [[MycommonTableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    [self addSubview:self.adressSearchedKeywordsTableView];
}

@end

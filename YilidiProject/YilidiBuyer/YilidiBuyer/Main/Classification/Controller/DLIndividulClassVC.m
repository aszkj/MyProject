//
//  DLIndividulClassVC.m
//  YilidiBuyer
//
//  Created by mm on 17/3/29.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLIndividulClassVC.h"
#import "DLGoodsClassView.h"
#import <Masonry.h>

@interface DLIndividulClassVC ()

@property (nonatomic,strong) DLGoodsClassView *goodsClassView;

@end

@implementation DLIndividulClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageTitle = @"分类";
    [self.goodsClassView requestClassDataConfigure];
}

-(DLGoodsClassView *)goodsClassView {
    
    if (!_goodsClassView) {
        _goodsClassView = BoundNibView(@"DLGoodsClassView", DLGoodsClassView);
        [self.view addSubview:_goodsClassView];
        [_goodsClassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _goodsClassView;
}


@end

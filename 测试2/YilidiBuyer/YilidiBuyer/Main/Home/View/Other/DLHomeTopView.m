//
//  DLHomeTopView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLHomeTopView.h"
#import "UIButton+Design.h"
#import "GlobleConst.h"
#import <Masonry.h>
#import "UIButton+Block.h"

static NSString *deafaultDisplayCommunityTitle = @"请选择附近小区";

@interface DLHomeTopView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *communityLabelWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UILabel *communityNameLabel;
@end

@implementation DLHomeTopView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.scanButton setEnlargeEdge:kUIExternReponsedEdge];
    self.communityLabelWidthConstraint.constant = kScreenWidth - 210;

    [self _loadTopSearchView];
}


- (void)_loadTopSearchView {
    self.topSearchView = BoundNibView(@"DLHomeTopSearchView", UIView);
    [self addSubview:self.topSearchView];
    [self.topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }]; 
    self.topSearchView.alpha = 0.0;
    WEAK_SELF
    UIButton *searchButton = (UIButton *)[self.topSearchView viewWithTag:11];
    [searchButton addActionHandler:^(NSInteger tag) {
        emptyBlock(weak_self.beginSearchBlock);
    }];

}

- (void)setSearchViewAlpha:(CGFloat)searchViewAlpha {

    self.topSearchView.alpha = searchViewAlpha;
    
}


- (IBAction)selecteShopAction:(id)sender {
    emptyBlock(self.selectdShopBlock);
}

- (IBAction)beginSearchAction:(id)sender {
    emptyBlock(self.beginSearchBlock);
}

- (IBAction)scanGoodsAction:(id)sender {
    emptyBlock(self.scanGoodsBlock);
}

- (void)setCommunityName:(NSString *)communityName {
    _communityName = communityName;
    if (!isEmpty(_communityName)) {
        self.communityNameLabel.text = _communityName;
    }else {
        self.communityNameLabel.text = deafaultDisplayCommunityTitle;

    }
}


@end

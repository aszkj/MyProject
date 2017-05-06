//
//  DLTagShowView.m
//  YilidiSeller
//
//  Created by yld on 16/5/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLTagShowView.h"
#import "UIView+BlockGesture.h"
#import <Masonry/Masonry.h>
#import "ProjectStandardUIDefineConst.h"

@interface DLTagShowView()

@property (nonatomic, strong)MASConstraint *tagViewHeightConstraint;

@property (nonatomic, strong)UIView *maskView;

@property (nonatomic,copy)NSArray *datas;

@end

@implementation DLTagShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _setUp];
    }
    return self;
}

-(void)_initTagListView {
    
    self.tagListView.canSelectTags = YES;
    self.tagListView.tagCornerRadius = 10.0f;
    self.tagListView.tagTextColor = KTextColor;
    self.tagListView.itemHeight = 20.0f;
    self.tagListView.minuHorizonalSpace = 10.0;
    self.tagListView.minuVerticalSpace = 10.0;
    self.tagListView.canCancelSelectedTag = NO;
    self.tagListView.canSelectMutialTags = NO;
    self.tagListView.tagStrokeColor = KLineColor;
    self.tagListView.tagSelectedBackgroundColor = KSelectedBgColor;
    self.tagListView.tagSelectedTextColor = [UIColor whiteColor];
    self.tagListView.backgroundColor = [UIColor whiteColor];
    self.tagListView.contentSectionInset = UIEdgeInsetsMake(11, 10, 11, 10);
    WEAK_SELF
    [self.tagListView setCompletionBlockWithSelected:^(NSInteger index,NSArray *selectedTags,NSArray *tags) {
        JLog(@"______%ld______", (long)index);
        JLog(@"%@",selectedTags);
        emptyBlock(weak_self.selectItemBlock,selectedTags.firstObject);
        [weak_self close];
    }];
}

- (void)showWithData:(NSArray *)datas {
    
    [self show];
    self.datas = datas;
    
}

- (void)show {
    self.isOpen = YES;
    self.hidden = NO;
}

- (void)close {
    self.isOpen = NO;
    [self _showTagViewAnimationWithHeight:0];
    self.hidden = YES;
    emptyBlock(self.closeBlock);
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self _assignTagViewData];
}

- (void)_assignTagViewData {
    self.tagListView.tags = [self.datas mutableCopy];
    [self.tagListView reloadData];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self _showTagViewAnimationWithHeight:self.tagListView.contentHeight];
    });
}

-(void)_showTagViewAnimationWithHeight:(CGFloat)tagViewHeight {
    WEAK_SELF
    [UIView animateWithDuration:0.3 animations:^{
        [self.tagListView mas_updateConstraints:^(MASConstraintMaker *make) {
            weak_self.tagViewHeightConstraint = make.height.mas_equalTo(tagViewHeight);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)_setUp {
    self.backgroundColor = [UIColor clearColor];
    self.maskView = [UIView new];
    [self addSubview:self.maskView];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0.5;

    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    WEAK_SELF
    self.maskView.userInteractionEnabled = YES;
    [self.maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self close];
    }];
    
    self.tagListView = [[JCTagListView alloc] init];
    [self addSubview:self.tagListView];
    [self.tagListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        weak_self.tagViewHeightConstraint = make.height.mas_equalTo(0);
    }];
    
    [self _initTagListView];
}


@end

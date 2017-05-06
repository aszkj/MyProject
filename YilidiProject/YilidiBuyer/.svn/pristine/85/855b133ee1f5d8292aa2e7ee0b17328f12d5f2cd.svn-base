//
//  SeckillActivitySceneView.m
//  YilidiBuyer
//
//  Created by yld on 16/8/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "SeckillActivitySceneView.h"
#import <Masonry/Masonry.h>
#import "UIView+BlockGesture.h"

const CGFloat seckillActivitySceneViewHeight = 44;
const CGFloat seckillActivitySceneViewToBottomGap = 8;


@interface SeckillActivitySceneView()

@property (nonatomic,strong)UIImageView *seckillActivityBgView;
@property (nonatomic,strong)UIImageView *seckillActivityArrowImgView;

@property (nonatomic, assign)CGFloat activityViewWidth;


@end

@implementation SeckillActivitySceneView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.currentActivityIndex = -1000;
    }
    return self;
}

#pragma mark -------------------Init Method----------------------
-(void)_setUpUi{
    
    UIScrollView *secKillActivityScrollView = [UIScrollView new];
    [self addSubview:secKillActivityScrollView];
    [secKillActivityScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    secKillActivityScrollView.clipsToBounds = NO;

    
    UIView *secKillActivityScrollViewContentView = [UIView new];
    [secKillActivityScrollView addSubview:secKillActivityScrollViewContentView];
    [secKillActivityScrollViewContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(secKillActivityScrollView);
    }];
    
    NSInteger activityCount = self.secKillActivitys.count;
    NSInteger displayCountOneScreen = 4;
    self.activityViewWidth = kScreenWidth / activityCount;
    
    UIView *darkBgView = [UIView new];
    [secKillActivityScrollViewContentView addSubview:darkBgView];
    [darkBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(secKillActivityScrollViewContentView);
        make.height.mas_equalTo(seckillActivitySceneViewHeight);
    }];
    darkBgView.backgroundColor = UIColorFromRGB(0x353636);

    
    self.seckillActivityBgView = [UIImageView new];
    self.seckillActivityBgView.backgroundColor = [UIColor redColor];
    [secKillActivityScrollViewContentView addSubview:self.seckillActivityBgView];
    [self.seckillActivityBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(secKillActivityScrollViewContentView);
        make.width.mas_equalTo(self.activityViewWidth);
        make.height.mas_equalTo(seckillActivitySceneViewHeight);
    }];
    
    self.seckillActivityArrowImgView = [UIImageView new];
    self.seckillActivityArrowImgView.image = IMAGE(@"箭头");
    [secKillActivityScrollViewContentView addSubview:self.seckillActivityArrowImgView];
    [self.seckillActivityArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seckillActivityBgView.mas_bottom);
        make.centerX.mas_equalTo(self.seckillActivityBgView);
        make.size.mas_equalTo(CGSizeMake(15, 7));
    }];
    
    secKillActivityScrollViewContentView.clipsToBounds = NO;
    SeckillActivityPerSceneView *leftView = nil;
    for (int i=0; i<activityCount; i++) {
        SeckillActivityPerSceneView *secKillActivityView = [SeckillActivityPerSceneView new];
        secKillActivityView.backgroundColor = [UIColor clearColor];
        secKillActivityView.seckillActivityModel = self.secKillActivitys[i];
        [secKillActivityScrollViewContentView addSubview:secKillActivityView];
        secKillActivityView.tag = i + 10;
        
        WEAK_SELF
        secKillActivityView.userInteractionEnabled = YES;
        [secKillActivityView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weak_self selectActivityAtIndex:i];
        }];
        
        [secKillActivityView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(secKillActivityScrollViewContentView);
            make.bottom.mas_equalTo(-seckillActivitySceneViewToBottomGap);

            make.width.mas_equalTo(self.activityViewWidth);
            make.height.mas_equalTo(seckillActivitySceneViewHeight);
            if (!i) {
                make.left.mas_equalTo(secKillActivityScrollViewContentView);
            }else{
                make.left.mas_equalTo(leftView.mas_right);
            }
            
            if (i == self.secKillActivitys.count - 1) {
                make.right.mas_equalTo(0);
            }
        }];
        leftView = secKillActivityView;
    }
}

#pragma mark -------------------Public Method----------------------
- (void)setSelectedActivityAtIndex:(NSInteger)activityIndex {

    [self selectActivityAtIndex:activityIndex];
    
}

-(void)refreshActivityWithNewActivityModel:(SeckillActivityModel *)newActivityModel
                                  atIndex:(NSInteger)activityIndex {
    SeckillActivityPerSceneView *secKillActivityView = (SeckillActivityPerSceneView *)[self viewWithTag:activityIndex+10];
    secKillActivityView.seckillActivityModel = newActivityModel;
}



#pragma mark -------------------Private Method----------------------
- (void)_updateActivitySelectedBgViewToNewPositionIndex:(NSInteger)newPositionIndex{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction animations:^{
          [self.seckillActivityBgView mas_updateConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(newPositionIndex * self.activityViewWidth);
          }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
    [self _setSelectedActivityViewAtIndex:newPositionIndex];
}

- (void)_setSelectedActivityViewAtIndex:(NSInteger)index {
    [self.secKillActivitys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SeckillActivityPerSceneView *secKillActivityView = (SeckillActivityPerSceneView *)[self viewWithTag:idx+10];
        secKillActivityView.activitySelected = idx == index;

    }];
}

- (void)_refreshActivityViewsWithAcvityModels:(NSArray *)activityModels {
    [activityModels enumerateObjectsUsingBlock:^(SeckillActivityModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [self refreshActivityWithNewActivityModel:model atIndex:idx];
    }];
}

#pragma mark -------------------Action Method----------------------
- (void)selectActivityAtIndex:(NSInteger)activityIndex {
    if (activityIndex == _currentActivityIndex) {
        return;
    }
    _currentActivityIndex = activityIndex;
    [self _updateActivitySelectedBgViewToNewPositionIndex:activityIndex];
    emptyBlock(self.switchActivityBlock,activityIndex);
}
#pragma mark -------------------Setter/Getter Method----------------------
- (void)setSecKillActivitys:(NSArray *)secKillActivitys {
    if (isEmpty(_secKillActivitys)) {
        _secKillActivitys = secKillActivitys;
        if (!_secKillActivitys.count) {
            return;
        }
        [self _setUpUi];
    }else {
        [self _refreshActivityViewsWithAcvityModels:secKillActivitys];
        _secKillActivitys = secKillActivitys;
    }
}

- (void)setCurrentActivityIndex:(NSInteger)currentActivityIndex {
    _currentActivityIndex = currentActivityIndex;
    [self _updateActivitySelectedBgViewToNewPositionIndex:currentActivityIndex];
}

@end

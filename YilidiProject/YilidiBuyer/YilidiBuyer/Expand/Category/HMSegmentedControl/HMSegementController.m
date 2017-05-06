//
//  HMSegementController.m
//  YilidiBuyer
//
//  Created by mm on 16/12/14.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "HMSegementController.h"
#import "HMSegmentedControl.h"

@interface HMSegementController()<UIScrollViewDelegate>

@property (nonatomic,strong)HMSegmentedControl *segementControl;

@property (nonatomic,assign) CGRect segementControllerFrame;

@property (nonatomic,strong) UIScrollView *segementControllerScrollView;

#warning 这里不能用strong,控制器强引用了该类，所以该类只能弱引用控制器
@property (nonatomic,weak) UIViewController *segementParentController;

@property (nonatomic,assign) BOOL childControllerAreSameClass;

@property (nonatomic,strong) Class childSegementControllClass;

@property (nonatomic,copy) NSArray *childSegementControllerClasses;


/**
 child controllers has be added call back
 */
@property (nonatomic,copy)ChildControllersCompletedAddedBlock childControllersCompletedAddedBlock;

@end

@implementation HMSegementController

-(instancetype)initWithSegementControl:(HMSegmentedControl *)segementControl
               segementControllerFrame:(CGRect)segementControllerFrame
            childSegementControllClass:(Class)childSegementControllClass
   childControllersCompletedAddedBlock:(ChildControllersCompletedAddedBlock)childControllersCompletedAddedBlock
{
    self = [super init];
    if (self) {
        self.childControllerAreSameClass = YES;
        self.segementControl = segementControl;
        self.childSegementControllClass = childSegementControllClass;
        self.segementControllerFrame = segementControllerFrame;
        self.childControllersCompletedAddedBlock = childControllersCompletedAddedBlock;
        [self _commonInit];
    }
    return self;
}

-(instancetype)initWithSegementControl:(HMSegmentedControl *)segementControl
               segementControllerFrame:(CGRect)segementControllerFrame
          childSegementControllClasses:(NSArray *)childSegementControllClasses
   childControllersCompletedAddedBlock:(ChildControllersCompletedAddedBlock)childControllersCompletedAddedBlock
{
    self = [super init];
    if (self) {
        self.childControllerAreSameClass = NO;
        self.segementControl = segementControl;
        self.childSegementControllerClasses = childSegementControllClasses;
        self.segementControllerFrame = segementControllerFrame;
        self.childControllersCompletedAddedBlock = childControllersCompletedAddedBlock;
        [self _commonInit];
    }
    return self;
}

- (void)_commonInit {
    self.topControllWillChangeIndexWhenScrollSegementControllerScrollView = YES;
    self.segementParentController = [self segementParentController];
    [self _createControllerScrollView];
    [self _initSegeMentControll];
    [self _createChildSegementControllers];
}

- (void)_createChildSegementControllers {
    
    for (NSInteger i=0; i<self.segementControl.sectionTitles.count; i++) {
        UIViewController *childSegementController = nil;
        if (self.childControllerAreSameClass) {
            childSegementController = [[self.childSegementControllClass alloc] init];
        }else {
            childSegementController = [[self.childSegementControllerClasses[i] alloc] init];
        }
        [self.segementParentController addChildViewController:childSegementController];
        [childSegementController didMoveToParentViewController:self.segementParentController];
    }
    if (self.childControllersCompletedAddedBlock) {
        self.childControllersCompletedAddedBlock(self.segementParentController.childViewControllers);
    }
}

- (void)_initSegeMentControll {
    WEAK_SELF
    self.segementControl.indexChangeBlock = ^(NSInteger index){
        [weak_self setVCToIndex:index];
        if (weak_self.indexChangeBlock) {
            weak_self.indexChangeBlock(index,[weak_self childSegementControllerAtIndex:index]);
        }
    };
}

- (UIViewController *)childSegementControllerAtIndex:(NSInteger)index {
    return self.segementParentController.childViewControllers[index];
}

- (void)_createControllerScrollView {
    // 创建底部滚动视图
    self.segementControllerScrollView = [[UIScrollView alloc] init];
    self.segementControllerScrollView.frame = self.segementControllerFrame;
    self.segementControllerScrollView.contentSize = CGSizeMake(self.segementControllerFrame.size.width * self.segementControl.sectionTitles.count, 0);
    self.segementControllerScrollView.backgroundColor = [UIColor clearColor];
    // 开启分页
    self.segementControllerScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    self.segementControllerScrollView.bounces = NO;
    // 隐藏水平滚动条
    self.segementControllerScrollView.showsHorizontalScrollIndicator = NO;
    // 设置代理
    self.segementControllerScrollView.delegate = self;
    
    [self.segementParentController.view addSubview:self.segementControllerScrollView];

    [self.segementParentController.view insertSubview:self.segementControllerScrollView belowSubview:self.segementControl];
}

-(void)setSegementIndex:(NSInteger)index animated:(BOOL)animated {
    
    [self.segementControl setSelectedSegmentIndex:index animated:animated];
    [self setVCToIndex:index];

}

- (void)setVCToIndex:(NSInteger)vcIndex {
    // 1 计算滚动的位置
    CGFloat offsetX = vcIndex * self.segementControllerFrame.size.width;
    self.segementControllerScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 2.给对应位置添加对应子控制器
    [self showVc:vcIndex];
    
}


// 显示控制器的view
- (void)showVc:(NSInteger)index {
    
    CGFloat offsetX = index * self.segementControllerFrame.size.width;
    
    
    
    UIViewController *vc = self.segementParentController.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.segementControllerScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.segementControllerFrame.size.width, self.segementControllerFrame.size.height);
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 1.添加子控制器view
    [self showVc:index];
    if (self.topControllWillChangeIndexWhenScrollSegementControllerScrollView) {
        [self.segementControl setSelectedSegmentIndex:index animated:YES];
    }
    
}

- (UIViewController*)segementParentController {
    for (UIView* next = [self.segementControl superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)nextResponder;
            return controller;
        }
    }
    return nil;
}



@end

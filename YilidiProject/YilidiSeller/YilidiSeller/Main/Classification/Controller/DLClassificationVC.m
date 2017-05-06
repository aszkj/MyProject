//
//  DLClassificationVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/12/12.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLClassificationVC.h"
#import "HMSegmentedControl.h"
#import "GlobleConst.h"
#import "ProjectStandardUIDefineConst.h"
#import "DLGoodsClassView.h"
#import "DLBrandView.h"
#import <Masonry.h>
#import "DLSearchVC.h"
#import "SegementView.h"
#import "BrandDataManager.h"

@interface DLClassificationVC ()

@property (weak, nonatomic) IBOutlet HMSegmentedControl *topBarView;

@property (nonatomic,strong) DLGoodsClassView *goodsClassView;

@property (nonatomic,strong) DLBrandView *brandView;

@property (nonatomic, strong)SegementView *topSegementView;


@end

@implementation DLClassificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self _initSegmented];
    [self _initTopSegeMentView];
    self.showNavbarBottomLine = NO;
    self.goodsClassView.hidden = NO;
    [self.goodsClassView requestClassDataConfigure];
    [self _configureBrandDataManager];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.hidden = YES;
    self.navBarColor = KSelectedBgColor;
    self.backIconName = @"返回箭头白色";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    self.navigationController.navigationBar.hidden = NO;
    [kNotification removeObserver:self];
}

-(void)_initTopSegeMentView {
    
    self.topSegementView = [[SegementView alloc] initWithSegementFrame:CGRectMake(0, 0, 170, 28) segementTitles:@[@"分类",@"品牌"]];
    self.navigationItem.titleView = self.topSegementView;
    WEAK_SELF
    self.topSegementView.selectedSegementBlock = ^(NSInteger selectIndex){
        if (selectIndex ==0) {
            weak_self.goodsClassView.hidden = NO;
            weak_self.brandView.hidden = YES;
        }else{
            weak_self.goodsClassView.hidden = YES;
            weak_self.brandView.hidden = NO;
        }
    };
    
}


-(void)_initSegmented {
    
    NSArray *topBarTitles = nil;
    topBarTitles = @[@"分类",@"品牌"];
    self.topBarView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.topBarView.selectionIndicatorHeight = 2.0f;
    self.topBarView.font = kSystemFontSize(18);
    self.topBarView.sectionTitles = topBarTitles;
    self.topBarView.textColor = KTextColor;
    self.topBarView.selectedTextColor = KCOLOR_MAIN_TEXT;
    self.topBarView.selectionIndicatorColor = KCOLOR_PROJECT_RED;
    self.topBarView.selectedSegmentIndex=0;
    WEAK_SELF
    self.topBarView.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.topBarView.indexChangeBlock = ^(NSInteger index){
        
        if (index ==0) {
            weak_self.goodsClassView.hidden = NO;
            weak_self.brandView.hidden = YES;
        }else{
            weak_self.goodsClassView.hidden = YES;
            weak_self.brandView.hidden = NO;
        }
    };
    
}

#pragma mark ---------------------Private Method------------------------------
- (void)_configureBrandDataManager {
    [[BrandDataManager sharedManager] startDownLoadBrandData];
}

#pragma mark ---------------------PageNavigate Method------------------------------
- (void)_enterSearchPage {
    DLSearchVC *searchVC = [[DLSearchVC alloc] init];
    [self navigatePushViewController:searchVC animate:YES];
}



#pragma mark ---------------------ViewEvent Method------------------------------
- (IBAction)searchAction:(id)sender {
    
    [self _enterSearchPage];
    
}

#pragma mark ---------------------Setter/Getter Method------------------------------
-(DLGoodsClassView *)goodsClassView {

    if (!_goodsClassView) {
        _goodsClassView = BoundNibView(@"DLGoodsClassView", DLGoodsClassView);
        [self.view addSubview:_goodsClassView];
        [_goodsClassView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.mas_equalTo(44);
        }];
        _goodsClassView.ownVC = self;
    }
    return _goodsClassView;

}

-(DLBrandView *)brandView {
    
    if (!_brandView) {
        _brandView = BoundNibView(@"DLBrandView", DLBrandView);
        [self.view addSubview:_brandView];
        [_brandView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.view);
            make.top.mas_equalTo(44);
        }];
        _brandView.ownVC = self;
    }
    return _brandView;
    
}




@end

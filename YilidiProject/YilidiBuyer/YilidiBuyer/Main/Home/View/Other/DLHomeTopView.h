//
//  DLHomeTopView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/20.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectdShopBlock)(void);
typedef void(^BeginSearchBlock)(void);
typedef void(^ScanGoodsBlock)(void);


@interface DLHomeTopView : UIView

@property (nonatomic,copy)SelectdShopBlock selectdShopBlock;
@property (nonatomic,copy)BeginSearchBlock beginSearchBlock;
@property (nonatomic,copy)ScanGoodsBlock scanGoodsBlock;

@property (weak, nonatomic) IBOutlet UIView *communityNameBgView;
@property (weak, nonatomic) IBOutlet UIView *scanButtonBgView;
@property (weak, nonatomic) IBOutlet UIView *searchButtonBgView;
@property (weak, nonatomic) IBOutlet UIImageView *homeNavBgImgView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bgViewWhite;
@property (nonatomic,copy)NSString *communityName;
@property (nonatomic,strong)UIView *topSearchView;

- (void)setSearchViewAlpha:(CGFloat)searchViewAlpha;

- (void)displayCommunityUI:(BOOL)display;

@end

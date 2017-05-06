//
//  ShopCartGoodsNumberChangeView.m
//  YilidiBuyer
//
//  Created by yld on 16/5/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartGoodsNumberChangeView.h"
#import "UIButton+Block.h"
#import "ShopCartGoodsNumberChangeView+addZeroAnimation.h"
#import "ProjectRelativeKey.h"
#import "ShopCartGoodsManager.h"
#import "ShopCartGoodsNumberChangeView+shopCartRelated.h"
#import "ShopCartGoodsNumberChangeView+dealGoodsType.h"
#import <Masonry/Masonry.h>
#import "GlobleConst.h"
#import "UIButton+Design.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
#import "ShopCartGoodsManager+checkWhenAddingShopCart.h"
@interface ShopCartGoodsNumberChangeView()

@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UIButton *subButton;
@property (nonatomic, strong)UILabel *goodsCountLabel;
@property (nonatomic, strong)ShopCartGoodsManager *shopCartGoodsManager;

@end

@implementation ShopCartGoodsNumberChangeView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
        [self _setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
        [self _setUpUI];
    }
    return self;
}

#pragma mark -------------------Init Method----------------------
-(void)_init {
    self.userInteractionEnabled = YES;
    self.buyGoodsCount = 0;
    self.goodsStockCount = 100;
    self.hasSubToZeroAnimation = YES;
    self.subImgName = @"Sub";
    self.addImgName = @"Add";
    self.addEabledImgName = @"不可点击加";
    self.isSelfOperateAddOrSub = NO;
}

- (void)_setUpUI {
    
    self.addButton = [UIButton new];
    [self addSubview:self.addButton];
    [self.addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setBackgroundImage:[UIImage imageNamed:self.addImgName] forState:UIControlStateNormal];
    [self.addButton setEnlargeEdge:8];
    //不可点击加
  [self.addButton setBackgroundImage:[UIImage imageNamed:self.addEabledImgName] forState:UIControlStateDisabled];
    self.subButton = [UIButton new];
    [self addSubview:self.subButton];
    [self.subButton addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [self.subButton setBackgroundImage:[UIImage imageNamed:self.subImgName] forState:UIControlStateNormal];
    [self.subButton setEnlargeEdge:8];
    self.subButton.hidden = YES;
    
    self.goodsCountLabel = [UILabel new];
    self.goodsCountLabel.textColor = [UIColor blackColor];
    [self addSubview:self.goodsCountLabel];
    self.goodsCountLabel.font = [UIFont systemFontOfSize:14];
    self.goodsCountLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat goodsCountWidth = 20;
    if (kScreenWidth == iPhone5_width) {
        goodsCountWidth = 17;
    }
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(goodsCountWidth);
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsCountLabel.mas_right).with.offset(0);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodsCountLabel.mas_left).with.offset(0);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
}

#pragma mark -------------------Action Method----------------------
- (void)addAction{
    
    if (![self _currentCommunityStoreOnBussiness]) {
        return;
    }
    
    if ([ShopCartGoodsManager sharedManager].shopCartGoodsNumber) {
        if (![self isTheSameTypeGoodsOfAddingShopCart]) {
            [self _alertAddDifferentTypeGoods];
            return;
        }
    }
    
    [self _addGoodsLogic];
}

- (void)subAction {
    
    if (self.deleteShopCartGoodsBlock) {
        if ([self _isSubToZero]) {
            [self _alertWhetherDeleteThisGoods];
            return;
        }
    }
    
    [self _subLogic];
}


#pragma mark -------------------Setter/Getter Method----------------------
-(void)setBuyGoodsCount:(NSInteger)buyGoodsCount {
    _buyGoodsCount = buyGoodsCount;
    if (_buyGoodsCount > 0 ) {
        [self _configureUIWhenGoodsCountBiggerThanZero];
    }else {
        [self _configureUIWhenGoodsCountSmallerThanZero];
    }
    [self _setCountLabel];
}

#pragma mark -------------------Private Method----------------------
- (void)_alertAddDifferentTypeGoods {
    
    AlertViewManager *alertManager =  [[AlertViewManager alloc] init];
    NSString *alertStr = [self addDifferentGoodsTypeAlertStr];
    WEAK_SELF
    //两个action
    [alertManager showAlertViewWithControllerTitle:@"提示" message:alertStr controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        [[ShopCartGoodsManager sharedManager] clearAllShopCartData];
        [weak_self _addGoodsLogic];
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
       
    }];
}

- (void)_alertWhetherDeleteThisGoods {
    AlertViewManager *alertManager =  [[AlertViewManager alloc] init];
    WEAK_SELF
    //两个action
    [alertManager showAlertViewWithControllerTitle:@"提示" message:@"是否删除该商品" controllerStyle:UIAlertControllerStyleAlert isHaveTextField:NO actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault alertViewAction:^(UIAlertAction *action) {
        emptyBlock(weak_self.deleteShopCartGoodsBlock);
    } otherActionTitle:@"取消" otherActionStyle:UIAlertActionStyleDefault otherAlertViewAction:^(UIAlertAction *action) {
        
    }];

}

- (BOOL)_dealPennyGoods {
    if (self.goodsModel.goodsType == GoodsType_NormalPennyGoods) {
        if (self.buyGoodsCount + 1 > KDennyGoodsLimitCount) {
            [Util ShowAlertWithOnlyMessage:kAlertBuyyingPennyGoods];
            return YES;
        }else {
            return NO;
        }
    }
    return NO;
}

- (void)_addGoodsLogic {
    
    if ([self _dealPennyGoods]) {
        return;
    }
    
    if (![self _hasStock]) {
        return;
    }
    
    self.buyGoodsCount ++;
    [self _setCountLabel];
    [self _operaterShopCartIsAdd:YES];
    if (self.buyGoodsCount == 1) {
        [self _performAddSubZeroAnimationAddZero:YES];
    }
    if (_countChangedBlk) {
        _countChangedBlk(self.buyGoodsCount,YES);
    }

}

- (void)_subLogic {
    self.buyGoodsCount --;
    [self _setCountLabel];
    [self _operaterShopCartIsAdd:NO];
    if (self.buyGoodsCount == 0) {
        [self _performAddSubZeroAnimationAddZero:NO];
    }
    if (_countChangedBlk) {
        _countChangedBlk(self.buyGoodsCount,NO);
    }
    
}

- (void)_performAddSubZeroAnimationAddZero:(BOOL)isAddZero {
    if (!self.hasSubToZeroAnimation) {
        return;
    }
    //因为减号是需要执行动画的，加零减零都是减号执行，所以它开始都是显示的
    self.subButton.hidden = NO;
    self.goodsCountLabel.hidden = !isAddZero;
    [self showAddZeroAnimation:isAddZero addButton:self.addButton subButton:self.subButton];
}

- (void)_operaterShopCartIsAdd:(BOOL)isAdd {
    self.isSelfOperateAddOrSub = YES;
    [self operaterShopCartGoodsManagerGoodsChangedOfGoodsModel:self.goodsModel isAdd:isAdd];
}

- (void)_configureUIWhenGoodsCountSmallerThanZero {
    self.goodsCountLabel.hidden = YES;
    self.subButton.hidden = YES;
}

- (void)_configureUIWhenGoodsCountBiggerThanZero {
    self.goodsCountLabel.hidden = NO;
    self.subButton.hidden = NO;
}

-(void)_setCountLabel{
    _goodsCountLabel.hidden = !_buyGoodsCount;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"%ld",_buyGoodsCount];
    self.addButton.enabled = [self _goodsCanGoOnAddToShopCart];
    self.subButton.enabled = _buyGoodsCount;
}

- (BOOL)_goodsCanGoOnAddToShopCart {
    
    if (self.buyGoodsCount >= self.goodsModel.goodsStock.integerValue) {
        return NO;
    }else {
        if (!isEmpty(self.goodsModel.limitBuyNumber)) {
            NSInteger goodsLimitNumber = self.goodsModel.limitBuyNumber.integerValue;
            if (goodsLimitNumber == -1) {
                return YES;
            }else {
                if (self.buyGoodsCount >= goodsLimitNumber) {
                    return NO;
                }else {
                    return YES;
                }
            }
        }
        
    }
    return YES;
}

- (BOOL)_hasStock {
    if (self.buyGoodsCount + 1 > self.goodsModel.goodsStock.integerValue) {
        [Util ShowAlertWithOnlyMessage:@"库存不足"];
        return NO;
    }
    return YES;

}

- (BOOL)_currentCommunityStoreOnBussiness {
    if (!kCurrentCummunityStoreBusinessStatus) {
        [Util ShowAlertWithOnlyMessage:@"当前社区店铺不在营业时间"];
        return NO;
    }
    return YES;
}

- (BOOL)_isSubToZero {
    NSInteger nowShopCartCount = [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:self.goodsModel];
    return nowShopCartCount - 1 <= 0;
}

#pragma mark -------------------Goods Related Observe/Notification Method----------------------
- (void)setGoodsModel:(GoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self _registerGoodsNumberChangeNotification];
}


- (void)initUiFromShopCartGoodsId:(NSString *)goodsId{
    NSInteger goodsCountInShopCart = [self goodsCountOfGoodsModel:self.goodsModel];
    self.buyGoodsCount = goodsCountInShopCart;
}

- (void)_registerGoodsNumberChangeNotification {
    [kNotification removeObserver:self name:KGoodsIdNotificationNameWithGoodsId(self.goodsModel.goodsId) object:nil];
    [kNotification addObserver:self selector:@selector(goodsNumberChange:) name:  KGoodsIdNotificationNameWithGoodsId(self.goodsModel.goodsId) object:nil];
}

- (void)goodsNumberChange:(NSNotification *)info {
    
    if (self.isSelfOperateAddOrSub) {//自己操作的不管
        self.isSelfOperateAddOrSub = NO;
        return;
    }
    if ([info.name isEqualToString:KGoodsIdNotificationNameWithGoodsId(self.goodsModel.goodsId)]) {
        NSDictionary *userInfo = info.userInfo;
        BOOL isAdd = [userInfo[KGoodsChangeIsAddKey] boolValue];
        NSInteger goosNumber = [userInfo[KGoodsChangeGoodsNumberKey] integerValue];
        GoodsModel *notifyShopCartGoodsModel = userInfo[KGoodsModelKey];
        if (notifyShopCartGoodsModel) {
            if (![[ShopCartGoodsManager sharedManager] isRealTheSameGoodsComparingOutShopCartGoods:self.goodsModel withShopCartGoods:notifyShopCartGoodsModel]) {
                isAdd = NO;
                goosNumber = 0;
            }
        }
        if (isAdd) {
            if (goosNumber == 1) {//从0到1
                [self _configureUIWhenGoodsCountBiggerThanZero];
            }
        }else {
            if (goosNumber == 0) {//从1到0
                [self _configureUIWhenGoodsCountSmallerThanZero];
            }
        }
        self.buyGoodsCount = goosNumber;

    }
}


@end

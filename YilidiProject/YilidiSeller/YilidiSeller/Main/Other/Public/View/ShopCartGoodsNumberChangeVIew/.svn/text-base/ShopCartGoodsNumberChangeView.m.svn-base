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
#import "DispatchGoodsManager.h"
#import <Masonry/Masonry.h>
#import "ShopCartGoodsNumberChangeView+shopCartRelated.h"
#import "Util.h"
#import "UIButton+Design.h"
@interface ShopCartGoodsNumberChangeView()

@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong)UIButton *subButton;
@property (nonatomic, strong)UILabel *goodsCountLabel;
@property (nonatomic, strong)DispatchGoodsManager *shopCartGoodsManager;

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
    self.subImgName = @"减号";
    self.addImgName = @"加号";
    self.isSelfOperateAddOrSub = NO;
}

- (void)_setUpUI {
    self.addButton = [UIButton new];
    [self addSubview:self.addButton];
    [self.addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setBackgroundImage:[UIImage imageNamed:self.addImgName] forState:UIControlStateNormal];
    self.subButton = [UIButton new];
    [self addSubview:self.subButton];
    [self.subButton addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [self.subButton setBackgroundImage:[UIImage imageNamed:self.subImgName] forState:UIControlStateNormal];
    self.subButton.hidden = YES;
    self.goodsCountLabel = [UILabel new];
    self.goodsCountLabel.textColor = [UIColor blackColor];
    [self addSubview:self.goodsCountLabel];
    self.goodsCountLabel.font = [UIFont systemFontOfSize:13];
    self.goodsCountLabel.textAlignment = NSTextAlignmentCenter;
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [self.addButton setEnlargeEdge:3];
    CGFloat goodsCountLabelWidth = 18;
    if (kScreenWidth == iPhone5_width) {
        goodsCountLabelWidth = 15;
    }
    [self.goodsCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(goodsCountLabelWidth);
        make.right.mas_equalTo(self.addButton.mas_left).with.offset(-3);
        make.centerY.mas_equalTo(self);
    }];
    [self.subButton setEnlargeEdge:3];
    [self.subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.goodsCountLabel.mas_left).with.offset(-3);
        make.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
}

#pragma mark -------------------Action Method----------------------
- (void)addAction{
//#warning 暂时注释微仓库存不足提示
    if (![self _hasStock]) {
        return;
    }
    self.buyGoodsCount += self.goodsModel.basicOrderNumber.integerValue;
    [self _setCountLabel];
    [self _operaterShopCartIsAdd:YES];
    if (self.buyGoodsCount == self.goodsModel.basicOrderNumber.integerValue) {
        [self _performAddSubZeroAnimationAddZero:YES];
    }
    if (_countChangedBlk) {
        _countChangedBlk(self.buyGoodsCount,YES);
    }
}

- (void)subAction {
    self.buyGoodsCount -= self.goodsModel.basicOrderNumber.integerValue;
    [self _setCountLabel];
    [self _operaterShopCartIsAdd:NO];
    if (self.buyGoodsCount <= 0) {
        [self _performAddSubZeroAnimationAddZero:NO];
    }
    if (_countChangedBlk) {
        _countChangedBlk(self.buyGoodsCount,NO);
    }
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
    NSString *goodsCountStr = [NSString stringWithFormat:@"%ld",_buyGoodsCount];
    self.goodsCountLabel.text = goodsCountStr;
    [self _updateCountLabelWidthWithCountStr:goodsCountStr];
    self.subButton.enabled = _buyGoodsCount;
}

- (void)_updateCountLabelWidthWithCountStr:(NSString *) goodsCountStr{
    CGSize adaptSize = [goodsCountStr sizeWithFont:kSystemFontSize(13)];
    [self.goodsCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(adaptSize.width+5);
    }];
    [self layoutIfNeeded];
}

- (BOOL)_hasStock {
    if (self.buyGoodsCount + self.goodsModel.basicOrderNumber.integerValue > self.goodsModel.minuteResposityStock.integerValue) {
        [Util ShowAlertWithOnlyMessage:@"微仓库存不足"];
        return NO;
    }
    return YES;
}

#pragma mark -------------------Goods Related Observe/Notification Method----------------------
- (void)setGoodsModel:(GoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [self _registerGoodsNumberChangeNotification];
}


- (void)initUiFromShopCartGoodsId:(NSString *)goodsId{
    NSInteger goodsCountInShopCart = [self goodsCountOfGoodsId:goodsId];
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
        if (isAdd) {
            if (goosNumber == self.goodsModel.basicOrderNumber.integerValue) {//从0到1
                [self _configureUIWhenGoodsCountBiggerThanZero];
            }
        }else {
            if (goosNumber <= 0) {//从1到0
                [self _configureUIWhenGoodsCountSmallerThanZero];
            }
        }
        self.buyGoodsCount = goosNumber;

    }
}


@end

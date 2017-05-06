//
//  KJAddShoppingCarView.m
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJAddShoppingCarView.h"
#import "GlobeObject.h"
#import "KJShoppingAlertView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "GoodsSquModel.h"
#import "Util.h"
#import "KJShoppingAlertView.h"

typedef enum : NSUInteger {
    MakeSureType,
    AddshopingCartType,
    BuyNowType,
} ActionType;

@implementation KJAddShoppingCarView
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self _init];
    
    //选择属性通知
    [kNotification addObserver:self selector:@selector(observeGoodsPropertySelect:) name:selectGoodsCationPropertyNotification object:nil];
    
    //改变数量通知
    [kNotification addObserver:self selector:@selector(observeGoodsCount:) name:changeGoodsCountNotification object:nil];
    
}

+(id)showCartViewInContentView:(UIView *)contentView
{
    
    KJAddShoppingCarView *addShoppingCarView = BoundNibView(@"KJAddShoppingCarView", KJAddShoppingCarView);
    [contentView addSubview:addShoppingCarView];
    WEAK_SELF
    [addShoppingCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(contentView);
    }];
    
    return addShoppingCarView;
}

-(void)startShow {
    
    [self performSelector:@selector(beginAnimation) withObject:nil afterDelay:0.3];
}

-(void)endShowAfterSeconds:(NSInteger)seconds {
    
  [self performSelector:@selector(endAnimation) withObject:nil afterDelay:seconds];
}

-(void)beginAnimation {
    
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.shoppingCarViewToBottonContraint.constant = 0;
        [self layoutIfNeeded];

    }];
}


-(void)endAnimation {
    [UIView animateWithDuration:0.5 animations:^{
        self.shoppingCarViewToBottonContraint.constant = -self.addShoppingCarViewHeightConstraint.constant-50;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self endAnimation];
    
}


-(void)_init{
    _buyCount = 1;
    self.goodsKindSelectTableView.tableFooterView = [UIView new];
    
    self.addShoppingCarViewHeightConstraint.constant = (430.0/iPhone6_Height) * kScreenHeight;
    self.goodsImgView.layer.masksToBounds = YES;

    //初始化底部约束
    self.shoppingCarViewToBottonContraint.constant = -self.addShoppingCarViewHeightConstraint.constant - 50;
    
    if (self.ispresentedBySelectedGoodsCation) {//从选择商品属性进来
        self.addShoppingCartButton.hidden = NO;
        self.buyNowButton.hidden = NO;
    }
}

-(void)setIspresentedBySelectedGoodsCation:(BOOL)ispresentedBySelectedGoodsCation{
    _ispresentedBySelectedGoodsCation = ispresentedBySelectedGoodsCation;
    if (_ispresentedBySelectedGoodsCation) {//从选择商品属性进来
        self.addShoppingCartButton.hidden = NO;
        self.buyNowButton.hidden = NO;
    }else{
        self.addShoppingCartButton.hidden = YES;
        self.buyNowButton.hidden = YES;
    }
}


#pragma mark - setter Method
/*
-(void)setGoodsCationPropertyDic:(NSDictionary *)goodsCationPropertyDic{
    //初始化字典
    _goodsCationPropertyDic = goodsCationPropertyDic;
    self.goodsKindSelectTableView.cationPropertyDic = _goodsCationPropertyDic;
    [self.goodsKindSelectTableView reloadData];
    
    //初始化选择字典
    _selectGoodsCationPropertyDic = [NSMutableDictionary dictionaryWithCapacity:_goodsCationPropertyDic.count];
    for (NSString *key in _goodsCationPropertyDic.allKeys) {
        
        if (!_selectGoodsCationPropertyDic[key]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
            [dic setObject:@0 forKey:@"open"];
            [_selectGoodsCationPropertyDic setObject:dic forKey:key];
        }
        
    }
    
    
}
*/
#pragma mark - MD
-(void)setDataHander:(AddShoppingCartViewDataInoutHander *)dataHander{
    _dataHander = dataHander;
    
    //初始化字典
    _goodsCationPropertyDic = dataHander.cationPropertyMutableDic;
    self.goodsKindSelectTableView.cationPropertyDic = _goodsCationPropertyDic;
    [self.goodsKindSelectTableView reloadData];
    
    //给UI赋值
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",     dataHander.goodsDetailModel.actualPrice];
#pragma mark - 2*2
    NSString *newStr = TwiceImgUrlStr(dataHander.goodsDetailModel.goodsMainPhotoPath, 143, 137);
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:newStr]];
    //goodsInventory
    self.goodsStockLabel.text = [NSString stringWithFormat:@"库存%ld",dataHander.goodsDetailModel.goodsInventory.integerValue];
    //发送库存通知
//    [kNotification postNotificationName:goodsStockChangeNotification object:dataHander.goodsDetailModel.goodsInventory];
    self.goodsKindSelectTableView.goodsStockCount = dataHander.goodsDetailModel.goodsInventory.integerValue;
    NSString *cationNameStr = self.dataHander.goodsDetailModel.cationNameStr;
    if (![cationNameStr isEqualToString:@""]) {
        self.displaySelectedPropertyLabel.text = [NSString stringWithFormat:@"请选择 %@",cationNameStr];
    }
     
    //初始化选择字典
    _selectGoodsCationPropertyDic = [NSMutableDictionary dictionaryWithCapacity:_goodsCationPropertyDic.count];
    for (NSString *key in _goodsCationPropertyDic.allKeys) {
        
        if (!_selectGoodsCationPropertyDic[key]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
            [dic setObject:@0 forKey:@"open"];
            [_selectGoodsCationPropertyDic setObject:dic forKey:key];
        }
        
    }
}



#pragma mark - Notification Observer
-(void)observeGoodsPropertySelect:(NSNotification *)notiInfo{
    
    NSLog(@" dic %@",(NSDictionary *)notiInfo.object);
    NSDictionary *dic = (NSDictionary *)notiInfo.object;
    //取出规格名字
    NSString *cationName = [dic[@"spec"] objectForKey:@"name"];
    //取出是否点击或者取消
    if ([dic[@"open"] integerValue]) {//点击
        NSMutableDictionary *mutableDic = self.selectGoodsCationPropertyDic[cationName];
        [mutableDic setObject:@1 forKey:@"open"];
        [mutableDic setObject:dic forKey:cationName];
    }else{//取消点击
        [self.selectGoodsCationPropertyDic[cationName] setObject:@0 forKey:@"open"];
    }
    //寻找没有选中的规格
    NSString *unselecteStr = [self _findUnselectedCation];
    NSLog(@"unselected str %@",unselecteStr);
    NSLog(@"---1----");
    if (unselecteStr) {
        self.displaySelectedPropertyLabel.text = [NSString stringWithFormat:@"请选择 %@",unselecteStr];
    }else{
        //属性选完之后的一些处理
        self.selectedPropertyStr= [self _findAllselectedCationValue];
        self.displaySelectedPropertyLabel.text = [NSString stringWithFormat:@"已选择 %@",_selectedPropertyStr];
        //给数据处理者赋值
        _dataHander.selectedPropertyIdArr = [self _getSelectedPropertyIdArr];
        //变化squ价格
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",_dataHander.squPrice];
        //变化squ库存
        NSInteger goodsStoreCount = _dataHander.goodsSquModel.count.integerValue;
        self.goodsStockLabel.text = [NSString stringWithFormat:@"库存%ld",goodsStoreCount];
        _dataHander.selectedPropertyStr = self.selectedPropertyStr;
        _dataHander.goodsSquModel.selectGoodsSquStr = self.selectedPropertyStr;
        
        //给控制器发送squ改变通知，传squ模型
        [kNotification postNotificationName:changeGoodsSquNotification object:_dataHander.goodsSquModel];
        
        //发送库存改变的通知
        NSNumber* stockCount = _dataHander.goodsSquModel.count;
        [kNotification postNotificationName:goodsStockChangeNotification object:stockCount];
    }
}


-(void)observeGoodsCount:(NSNotification *)notInfo{
    NSInteger count = [notInfo.object integerValue];
    NSLog(@"数量----%ld",count);
    _buyCount = count;

}



#pragma mark - 找到没有选择的规格
-(NSString *)_findUnselectedCation{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSString *key in self.selectGoodsCationPropertyDic.allKeys) {
        NSInteger isSelected = [self.selectGoodsCationPropertyDic[key][@"open"] integerValue];
        if (!isSelected) {
            [arr addObject:key];
        }
    }
    
    NSLog(@"规格keys %@",self.selectGoodsCationPropertyDic.allKeys);
    NSLog(@"未选的规格 %@",arr);
    
    if (arr.count > 0) {
        NSString *unselectedStr = [arr componentsJoinedByString:@" "];
        NSLog(@"%@",unselectedStr);
        return unselectedStr;
    }else{
        return nil;
    }
}



#pragma mark - 找到选择的规格值
-(NSString *)_findAllselectedCationValue{
    
    NSLog(@"diccc ------ %@",self.selectGoodsCationPropertyDic);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSString *key in self.selectGoodsCationPropertyDic.allKeys) {
        NSInteger isSelected = [self.selectGoodsCationPropertyDic[key][@"open"] integerValue];
        if (isSelected) {
            NSString *cationValue =  self.selectGoodsCationPropertyDic[key][key][@"value"];
            [arr addObject:cationValue];
        }
    }
    
    NSString *selectedValueStr = [arr componentsJoinedByString:@" "];
    return selectedValueStr;
}

- (IBAction)cancelAction:(id)sender {
    
    [self endAnimation];
    
}//取消

#pragma mark - 确定
- (IBAction)makeSureAction:(id)sender {
//    if ([self _hasGoodsStock]) {//有库存
        [self _dealWithActionType:MakeSureType];
//    }
}




-(NSArray *)_getSelectedPropertyIdArr{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    for (NSString *key in self.selectGoodsCationPropertyDic.allKeys) {
        NSInteger isSelected = [self.selectGoodsCationPropertyDic[key][@"open"] integerValue];
        if (isSelected) {
            NSNumber *selectedPropertyID =  self.selectGoodsCationPropertyDic[key][key][@"id"];
            [arr addObject:selectedPropertyID];
        }
    }
    
    return (NSArray *)arr;
}


#pragma mark - 加入购物车
- (IBAction)addShoppingCartAction:(id)sender {
//    if ([self _hasGoodsStock]) {//有库存
        [self _dealWithActionType:AddshopingCartType];
//    }
    
}


#pragma mark - 立即购买
- (IBAction)buyNowAction:(id)sender {
//    if ([self _hasGoodsStock]) {
        [self _dealWithActionType:BuyNowType];
//    }
}

#pragma mark - 判断squ对应的有没有库存
-(BOOL)_hasGoodsStock{

    if (!_buyCount) {//购买数量为0，说明，库存为0,购买数量不会超过库存
        [KJShoppingAlertView showAlertTitle:@"商品库存不足" inContentView:self];
        return NO;
    }
    return YES;
}

-(void)_dealWithActionType:(ActionType)type{
    
    NSString *checkSelectResultStr = [self _findUnselectedCation];
    NSString *alertStr = [NSString stringWithFormat:@"请选择%@",checkSelectResultStr];
    if (checkSelectResultStr) {//还有没选的
        [KJShoppingAlertView showAlertTitle:alertStr inContentView:self];
    }else{//选完了,回调
        //检查库存
        if (![self _hasGoodsStock]) {
            return;
        }
        
        //得到选中的规格属性ID数组
        NSArray *propertyIdArr = [self _getSelectedPropertyIdArr];
        switch (type) {
            case MakeSureType:
                if (self.makeSureBlock) {
                    self.makeSureBlock(@(_buyCount),propertyIdArr,self.dataHander.selectedPropertyStr,self.dataHander.squPrice);
                }
                break;
            case AddshopingCartType:
                if (self.AddShopingCartOrBuyNowBlock) {
                    self.AddShopingCartOrBuyNowBlock(@(_buyCount),propertyIdArr,NO);
                }
                break;
            case BuyNowType:
                if (self.AddShopingCartOrBuyNowBlock) {
                    self.AddShopingCartOrBuyNowBlock(@(_buyCount),propertyIdArr,YES);
                }
                break;
                
            default:
                break;
        }
    }
    
}

- (void)dealloc
{
    [kNotification removeObserver:self];
}


@end

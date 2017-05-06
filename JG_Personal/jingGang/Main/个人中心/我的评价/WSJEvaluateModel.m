//
//  WSJEvaluateModel.m
//  jingGang
//
//  Created by thinker on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJEvaluateModel.h"
#import "PublicInfo.h"

@implementation WSJEvaluateModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataImageArray = [NSMutableArray array];
        self.height = 120;
        _O2OHeight = 70;
    }
    return  self;
}

- (void)setEvaluateContent:(NSString *)evaluateContent
{
    _evaluateContent = evaluateContent;
    if (evaluateContent.length > 0)
    {
        CGRect rect = [evaluateContent boundingRectWithSize:CGSizeMake(__MainScreen_Width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        self.evaluateHeight = rect.size.height;
        _height = _height - 21 + rect.size.height ;
        _O2OHeight = _O2OHeight + rect.size.height;
    }
    else
    {
        _height -= 21;
    }
    
    
}
- (void)setDate:(NSString *)date
{
    _date = date;
    if (date.length <= 0)
    {
        _height -= 20;
    }
}
- (void)setShopkeeper:(NSString *)shopkeeper
{
    _shopkeeper = shopkeeper;
    CGRect rect = [shopkeeper boundingRectWithSize:CGSizeMake(__MainScreen_Width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.shopkeeperHeight = rect.size.height ? rect.size.height + 5:0;
    _O2OHeight = _O2OHeight + rect.size.height + 15;
    self.height = _height + rect.size.height + 5;
}
- (void)setSupplement:(NSString *)supplement
{
    _supplement = supplement;
    CGRect rect = [supplement boundingRectWithSize:CGSizeMake(__MainScreen_Width - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.supplementHeight = rect.size.height;
    self.height = _height + rect.size.height + 5;
}

- (float)height
{
    if (self.dataImageArray.count)
    {
        return _height + 75;
    }
    return  _height;
}
- (void)setIsMeEvaluate:(BOOL)isMeEvaluate
{
    _isMeEvaluate = isMeEvaluate;
    _height += 20;
}
- (float)O2OHeight
{
    if (self.dataImageArray.count)
    {
        return _O2OHeight + 110;
    }
    return _O2OHeight;
}
@end

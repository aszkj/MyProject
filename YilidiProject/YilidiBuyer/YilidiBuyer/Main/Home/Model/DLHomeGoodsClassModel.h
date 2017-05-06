//
//  DLHomeGoodsClassModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/24.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "BaseModel.h"
#import "ProjectRelativEmerator.h"

@interface DLHomeGoodsClassModel : BaseModel

@property (nonatomic,copy)NSString *classId;

@property (nonatomic,copy)NSString *className;

@property (nonatomic,strong)NSString *classImageUrl;
/**
 *  分类广告的url
 */
@property (nonatomic,copy)NSString *classAdImgUrl;

/**
 *  分类广告链接类型
 */
@property (nonatomic,strong)NSNumber *classAdLinkTypeNumber;
/**
 *  分类更多类型
 */
@property (nonatomic,strong)NSNumber *classMoreTypeNumber;

@property (nonatomic,assign)LinkType classAdLinkType;

@property (nonatomic,assign)LinkType classMoreLinkType;
/**
 *  分类更多code
 */
@property (nonatomic,copy)NSString *classMoreCode;
/**
 *  分类广告链接code
 */
@property (nonatomic,copy)NSString *classAdLinkCode;


/**
 *  分类下的商品
 */
@property (nonatomic,copy)NSArray *classGoods;

@property (nonatomic,assign)CGFloat classAdPartHeight;


@end

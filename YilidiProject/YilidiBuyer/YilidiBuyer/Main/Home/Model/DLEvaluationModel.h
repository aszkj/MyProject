//
//  DLEvaluationModel.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "BaseModel.h"

@interface DLEvaluationModel : BaseModel
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *userImageUrl;
@property (nonatomic,strong)NSString *createTime;
@property (nonatomic,strong)NSString *evaluateContent;
@property (nonatomic,strong)NSMutableAttributedString *attributeEvaluateContent;

@property (nonatomic,strong)NSNumber *saleProductScore;
@property (nonatomic,strong)NSMutableArray *originalImages;
@property (nonatomic,strong)NSMutableArray *thumbnailImages;
@property (nonatomic,assign)CGFloat evaluteImgPartHeight;

@property (nonatomic,assign)CGFloat cellTotalHeight;
@property (nonatomic,strong)NSArray *frontArr;
@property (nonatomic,strong)NSMutableArray *floorGoodsList;
@end


@interface DLEvaluationModel (setEvaluationModel)

+ (NSArray *)ObjectEvaluationModelArr:(NSArray *)valuesArr;

@end

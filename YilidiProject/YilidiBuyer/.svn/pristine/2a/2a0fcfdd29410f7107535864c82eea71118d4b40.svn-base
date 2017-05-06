//
//  DLEvaluationModel.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLEvaluationModel.h"
#import "NSDictionary+SUISafeAccess.h"
#import "NSString+Teshuzifu.h"

//每行列数高
#define CellMargin  10
#define ImageMargin 10
#define ContentLabelY  40
#define LabelAndImageMargin  5
#define LabelUpAnddown 5
#define ImageHeight 60
#define KFixedEvaluatePartHeight 57.5f
@implementation DLEvaluationModel
-(instancetype)initWithDefaultDataDic:(NSDictionary *)dic {
    
    self = [super initWithDefaultDataDic:dic];
    if (self) {
        
        self.evaluateContent = dic[@"evaluateContent"];
        [self _setAttributeEvaluatedContent];
        self.userName = dic[@"userName"];
        self.userImageUrl = dic[@"userImageUrl"];
        self.createTime = dic[@"createTime"];
        self.saleProductScore = dic[@"saleProductScore"];
        
        self.originalImages = [NSMutableArray array];
        self.thumbnailImages = [NSMutableArray array];
        for (NSDictionary *data in dic[@"evaluateImages"]) {
            
            [self.thumbnailImages addObject:data[@"imageUrl"]];
            NSLog(@"imageUrls:%@",data[@"imageUrl"]);
            
            if ([data[@"imageUrl"]rangeOfString:@"30_"].location != NSNotFound) {
               
                NSString *originalImgUrl = data[@"imageUrl"];
                NSString *originalStr=[originalImgUrl getOriginalImgUrl];
                [self.originalImages addObject:originalStr];
//                NSLog(@"str222:  %@",originalStr);
            }else{
                [self.originalImages addObject:@""];
                
                              
            }
           
            
            
        }
        
        
              
    }
    return self;
}


- (void)_setAttributeEvaluatedContent {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.evaluateContent];
    NSRange range =  NSMakeRange(0,[self.evaluateContent length]);
    [attributedString addAttribute:NSFontAttributeName value:kSystemFontSize(14) range:range];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributeEvaluateContent = attributedString;

}
 

-(CGFloat)cellTotalHeight{
    
    // 文字的最大尺寸

    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 9999);
//    // 计算文字的高度
//    CGFloat textH = [self.evaluateContent boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
//    JLog(@"textH:%f",textH);
    CGFloat textH = [self.attributeEvaluateContent boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, 9999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    
    //一行最多5个。
    int maxCols = 5;
    //宽度、高度
    CGFloat TotalWidth = kScreenWidth - 2*CellMargin - (maxCols-1)*ImageMargin;
    CGFloat imageheight = TotalWidth / maxCols;
    NSLog(@"imageheightCell=%f",imageheight);
    
    
    
    if (self.thumbnailImages.count==0) {
        self.evaluteImgPartHeight = 0;
        //文字部分的高度
  
    }
    
    if (self.thumbnailImages.count>=1) {
        self.evaluteImgPartHeight = imageheight;

    }
    
    if (self.thumbnailImages.count>5){
   
        self.evaluteImgPartHeight = imageheight  * 2 + ImageMargin;
        
    }
    
    _cellTotalHeight = KFixedEvaluatePartHeight + textH + self.evaluteImgPartHeight;
    JLog(@"gaodu%f",_cellTotalHeight);
    return _cellTotalHeight;
    
}

@end

@implementation DLEvaluationModel (setEvaluationModel)
+ (NSArray *)ObjectEvaluationModelArr:(NSArray *)valuesArr{

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:valuesArr.count];
    for (NSDictionary *dic in valuesArr ) {
        DLEvaluationModel *model = [[DLEvaluationModel alloc]initWithDefaultDataDic:dic];
        [array addObject:model];

    }
    return [array mutableCopy];
}
@end

//
//  CellCalculateModel.h
//  YilidiBuyer
//
//  Created by yld on 16/5/10.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellCalculateNeedModel : NSObject

-(instancetype)initWithHorizontalDisplayCount:(NSInteger)horizontalDisplayCount
                   horizontalDisplayAreaWidth:(CGFloat)horizontalDisplayAreaWidth
                            cellImgToSideEdge:(CGFloat)cellImgToSideEdge
                    cellImgWidthToHeightScale:(CGFloat)cellImgWidthToHeightScale
                  cellOterPartHeightBesideImg:(CGFloat)cellOterPartHeightBesideImg
                       edgeBetweenCellAndCell:(CGFloat)edgeBetweenCellAndCell
                       edgeBetweenCellAndSide:(CGFloat)edgeBetweenCellAndSide;
/**
 *  cell水平方向显示的个数
 */
@property (nonatomic,assign)NSInteger horizontalDisplayCount;
/**
 *  cell横向显示的区域宽度，默认屏幕
 */
@property (nonatomic,assign)CGFloat horizontalDisplayAreaWidth;
/**
 *  cell中图片到两边的距离
 */
@property (nonatomic,assign)CGFloat cellImgToSideEdge;
/**
 *  cell中图片宽高比
 */
@property (nonatomic,assign)CGFloat cellImgWidthToHeightScale;
/**
 *  cell中除图片之外其他部分高度
 */
@property (nonatomic,assign)CGFloat cellOterPartHeightBesideImg;
/**
 *  cell之间的间距
 */
@property (nonatomic,assign)CGFloat edgeBetweenCellAndCell;
/**
 *  cell到显示区域两边之间的距离
 */
@property (nonatomic,assign)CGFloat edgeBetweenCellAndSide;



@end
/**
 *  计算cell的模型
 */
@interface CellCalculateModel : NSObject

-(instancetype)initWithCalculateNeedModel:(CellCalculateNeedModel *)model;

@property (nonatomic,strong)CellCalculateNeedModel *calculateNeedModel;

@property (nonatomic,assign)CGFloat cellWidth;

@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,assign)CGFloat cellImgWidth;

@property (nonatomic,assign)CGFloat cellImgHeight;

@end


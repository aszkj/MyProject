//
//  CellCalculateModel.m
//  YilidiSeller
//
//  Created by yld on 16/5/10.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CellCalculateModel.h"

@implementation CellCalculateModel

-(instancetype)initWithCalculateNeedModel:(CellCalculateNeedModel *)model {
    
    self = [super init];
    if (self) {
        _calculateNeedModel = model;
        self.cellWidth = (model.horizontalDisplayAreaWidth - 2 * model.edgeBetweenCellAndSide - model.edgeBetweenCellAndCell * (model.horizontalDisplayCount-1)) /  model.horizontalDisplayCount;
        self.cellImgWidth = self.cellWidth - 2 * model.cellImgToSideEdge;
        self.cellImgHeight = self.cellImgWidth / model.cellImgWidthToHeightScale;
        self.cellHeight = self.cellImgHeight + model.cellOterPartHeightBesideImg;
    }
    return self;
}

@end

@implementation CellCalculateNeedModel

-(instancetype)initWithHorizontalDisplayCount:(NSInteger)horizontalDisplayCount
                   horizontalDisplayAreaWidth:(CGFloat)horizontalDisplayAreaWidth
                            cellImgToSideEdge:(CGFloat)cellImgToSideEdge
                    cellImgWidthToHeightScale:(CGFloat)cellImgWidthToHeightScale
                  cellOterPartHeightBesideImg:(CGFloat)cellOterPartHeightBesideImg
                       edgeBetweenCellAndCell:(CGFloat)edgeBetweenCellAndCell
                       edgeBetweenCellAndSide:(CGFloat)edgeBetweenCellAndSide
{
    
    self = [super init];
    if (self) {
        _horizontalDisplayCount = horizontalDisplayCount;
        _horizontalDisplayAreaWidth = horizontalDisplayAreaWidth;
        _cellImgToSideEdge = cellImgToSideEdge;
        _cellImgWidthToHeightScale = cellImgWidthToHeightScale;
        _cellOterPartHeightBesideImg = cellOterPartHeightBesideImg;
        _edgeBetweenCellAndCell = edgeBetweenCellAndCell;
        _edgeBetweenCellAndSide = edgeBetweenCellAndSide;
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.horizontalDisplayAreaWidth = kScreenWidth;
    }
    return self;
}


@end
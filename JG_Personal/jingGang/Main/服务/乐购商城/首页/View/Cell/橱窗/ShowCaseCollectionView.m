//
//  ShowCaseCollectionView.m
//  橱窗collectionView测试
//
//  Created by 张康健 on 15/8/13.
//  Copyright (c) 2015年 com.organazation. All rights reserved.
//

#import "ShowCaseCollectionView.h"
#import "ShowCaseFirstLevelCollectionCell.h"
#import "ShowCaseSecondCollectionCell.h"
#import "GoodsDetailModel.h"
#import "GlobeObject.h"

@interface ShowCaseCollectionView(){

    NSMutableArray *_caseIsSelecedArr;
    NSInteger         _secondShowCaseOnceWidth;

}

@end

@implementation ShowCaseCollectionView

static NSString *ShowCaseFirstLevelCollectionCellID = @"ShowCaseFirstLevelCollectionCellID";
static NSString *ShowCaseSecondCollectionCellID = @"ShowCaseSecondCollectionCellID";


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
        //第二级橱窗每滑动一页的宽度
        _secondShowCaseOnceWidth = ((kScreenWidth-5*4)/3 + 5) * 3;
        
    }
    return self;
}

-(void)setShowCaseData:(NSArray *)showCaseData{
    _showCaseData = showCaseData;
    _caseIsSelecedArr = [NSMutableArray arrayWithCapacity:_showCaseData.count];
    for (int i=0; i<_showCaseData.count; i++) {
        BOOL isSeleted = i ? NO : YES;
        [_caseIsSelecedArr addObject:@(isSeleted)];
    }
}



-(void)setCollectionViewType:(ShowCaseCollectionViewType)collectionViewType{
    
    _collectionViewType = collectionViewType;
    
    if (_collectionViewType == FirstLevelCollectionViewType ) {//一级
        
        [self registerNib:[UINib nibWithNibName:@"ShowCaseFirstLevelCollectionCell" bundle:nil] forCellWithReuseIdentifier:ShowCaseFirstLevelCollectionCellID];
        
    }else{//二级
        
        [self registerNib:[UINib nibWithNibName:@"ShowCaseSecondCollectionCell" bundle:nil] forCellWithReuseIdentifier:ShowCaseSecondCollectionCellID];
        
    }
    
}


-(void)_init{
    
    self.dataSource = self;
    self.delegate = self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.collectionViewType == FirstLevelCollectionViewType) {//橱窗列表
        return self.showCaseData.count;
    }else{//橱窗商品列表
        return self.showCaseGoodsData.count;
    }
//    return 20;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_collectionViewType == FirstLevelCollectionViewType ) {//一级
        ShowCaseFirstLevelCollectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:ShowCaseFirstLevelCollectionCellID forIndexPath:indexPath];
        NSDictionary *dic = self.showCaseData[indexPath.row];
        [cell.showCaseTitleButton setTitle:dic[@"caseName"] forState:UIControlStateNormal];
        BOOL isSelected = [_caseIsSelecedArr[indexPath.row] boolValue];
        cell.showCaseTitleButton.selected = isSelected;
        return cell;
        
    }else{//二级
        ShowCaseSecondCollectionCell *cell = [self dequeueReusableCellWithReuseIdentifier:ShowCaseSecondCollectionCellID forIndexPath:indexPath];
        cell.model = self.showCaseGoodsData[indexPath.row];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSLog(@"did select cell");
    if (self.collectionViewType == FirstLevelCollectionViewType) {//橱窗
        BOOL isSelcted = [_caseIsSelecedArr[indexPath.row] boolValue];
        if (!isSelcted) {
            
            NSInteger lastSelectIndex = [self _getLastSelectIndex];
            if (lastSelectIndex == indexPath.row) {
                return;
            }
            if (lastSelectIndex != -1) {
                _caseIsSelecedArr[lastSelectIndex] = @(NO);
                _caseIsSelecedArr[indexPath.row] = @(YES);
                NSArray *reloadIndexPaths = @[[NSIndexPath indexPathForRow:lastSelectIndex inSection:0],indexPath];
                [self reloadItemsAtIndexPaths:reloadIndexPaths];
            }

            if (self.clickCaseCellBlock) {
                self.clickCaseCellBlock((NSDictionary *)self.showCaseData[indexPath.row]);
            }
        }
    }else{//橱窗商品
        GoodsDetailModel *model = self.showCaseGoodsData[indexPath.row];
        if (self.clickCaseGoodsCellBlock) {
            self.clickCaseGoodsCellBlock(model);
        }
    
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.collectionViewType == FirstLevelCollectionViewType) {//橱窗
        
        NSDictionary *dic = self.showCaseData[indexPath.row];
//        dic[@"caseName"]
        //5相当于button的title到button两边的总间隙
        CGFloat width = kStringSize(dic[@"caseName"], 14, 1000, 25).width;
        return CGSizeMake(width+5*2+5, 27);
    }else{//橱窗商品
        return CGSizeMake((kScreenWidth-5*4)/3, 112);
        
    }
}

-(NSInteger)_getLastSelectIndex{
    for (int i=0; i<_caseIsSelecedArr.count; i++) {
        if ([_caseIsSelecedArr[i] boolValue]) {
            return i;
            break;
        }
    }
    return -1;
}


#pragma mark - scrollView delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

//    NSLog(@"content offset %.1f",scrollView.contentOffset.x);
    if (self.collectionViewType == SecondLevelCollectionViewType) {
        //将要滑动的距离
        NSInteger willMoveDistance = targetContentOffset->x;
        //不管怎么滑动，将要滑动的距离肯定是一页距离的(n,n+1)页距离之间
        //那我就取，n,n+1中心点为基准点，，小于这个基准点，，就往n偏，大于这个基准点，就往n+1偏
        
        NSInteger n = willMoveDistance / _secondShowCaseOnceWidth;
        
        //基准点
        NSInteger middlePointx = n * _secondShowCaseOnceWidth + _secondShowCaseOnceWidth/2;
        //将要往第几页偏向
        NSInteger willMoveToThePage = 0;
        //大于基准点，，往n+1偏，否则往，n方向偏
        if (willMoveDistance > middlePointx) {
            willMoveToThePage = n + 1;
        }else{
            willMoveToThePage = n;
        }
        if (scrollView.decelerating) {
            targetContentOffset->x = willMoveToThePage * _secondShowCaseOnceWidth;
        }
        if (self.currentSecondCasePageBlock) {
            self.currentSecondCasePageBlock(willMoveToThePage);
        }
    }
}




@end

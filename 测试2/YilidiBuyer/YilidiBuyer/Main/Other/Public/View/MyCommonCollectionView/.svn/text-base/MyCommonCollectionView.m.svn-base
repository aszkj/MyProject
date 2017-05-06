//
//  MyCommonCollectionView.m
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "MyCommonCollectionView.h"

@interface MyCommonCollectionView()


@end

@implementation MyCommonCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init {
    
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataLogicModule.currentDataModelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(self.cellIdentifer != nil, @"cell标识符不能为空");
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:self.cellIdentifer forIndexPath:indexPath];
    id model = self.dataLogicModule.currentDataModelArr[indexPath.row];
    NSAssert(self.configureCollectionCellBlock != nil, @"配置cell的block不能为空");
    self.configureCollectionCellBlock(collectionView,model,cell);

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (self.firstSectionHeaderIdentifer) {
        
        if (kind == UICollectionElementKindSectionHeader) {
            UICollectionReusableView *firstSectionView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.firstSectionHeaderIdentifer forIndexPath:indexPath];
            if (self.configurefirstSectionHeaderBlock) {
                self.configurefirstSectionHeaderBlock(collectionView,nil,firstSectionView);
            }
            return firstSectionView;
        }
    }
    
    return nil;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:self.cellIdentifer forIndexPath:indexPath];
    id model = self.dataLogicModule.currentDataModelArr[indexPath.row];
    if (self.clickCellBlock) {
        self.clickCellBlock(collectionView,model,cell,indexPath);
    }
}


#pragma mark -------------------ScrollView Delegate Method----------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.listenCollectionScrollOffsetBlock) {
        self.listenCollectionScrollOffsetBlock(scrollView.contentOffset.y);
    }
}

#pragma mark -------------------Private Method----------------------
- (void)_registerFirstSectionHeaderForNibName:(NSString *)firstSectionHeaderNibName {
    
    self.firstSectionHeaderIdentifer = [firstSectionHeaderNibName stringByAppendingString:@"ID"];
    [self registerNib:[UINib nibWithNibName:firstSectionHeaderNibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.firstSectionHeaderIdentifer];
}

- (void)_registerCellForNibName:(NSString *)cellNibName {
    self.cellIdentifer = [cellNibName stringByAppendingString:@"ID"];
    [self registerNib:[UINib nibWithNibName:cellNibName bundle:nil] forCellWithReuseIdentifier:self.cellIdentifer];
}



#pragma mark -------------------Getter/Setter Method----------------------
-(void)setFirstSectionHeaderNibName:(NSString *)firstSectionHeaderNibName {
    
    _firstSectionHeaderNibName = firstSectionHeaderNibName;
    [self _registerFirstSectionHeaderForNibName:firstSectionHeaderNibName];

}

-(void)setCellNibName:(NSString *)cellNibName {

    _cellNibName = cellNibName;
    [self _registerCellForNibName:cellNibName];
}


-(UICollectionViewFlowLayout *)commonFlowLayout {
    if (!_commonFlowLayout) {
        _commonFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _commonFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _commonFlowLayout.minimumInteritemSpacing = 0;
        _commonFlowLayout.minimumLineSpacing = 0;
        self.collectionViewLayout = _commonFlowLayout;
    }
    return _commonFlowLayout;
}

#pragma mark -------------------ConfigureCell Method----------------------
-(void)configureCollectionCellNibName:(NSString *)collectionCellNibName
          configureCollectionCellData:(ConfigureCollectionCellBlock)configureCollectionCellBlock
{
    
    [self configureCollectionCellNibName:collectionCellNibName cellDataSource:nil configureCollectionCellData:configureCollectionCellBlock clickCell:nil];
}

-(void)configureCollectionCellNibName:(NSString *)collectionCellNibName
          configureCollectionCellData:(ConfigureCollectionCellBlock)configureCollectionCellBlock
                            clickCell:(ClickCellBlock)clickCellBlock
{
  [self configureCollectionCellNibName:collectionCellNibName cellDataSource:nil configureCollectionCellData:configureCollectionCellBlock clickCell:clickCellBlock];

}

-(void)configureCollectionCellNibName:(NSString *)collectionCellNibName
                       cellDataSource:(NSArray *)cellDataSource
          configureCollectionCellData:(ConfigureCollectionCellBlock)configureCollectionCellBlock
                            clickCell:(ClickCellBlock)clickCellBlock
{
    
    [self _registerCellForNibName:collectionCellNibName];
    self.dataLogicModule.currentDataModelArr = [cellDataSource mutableCopy];
    self.configureCollectionCellBlock = configureCollectionCellBlock;
    self.clickCellBlock = clickCellBlock;
}

#pragma mark - 配置firstSectionHeader
- (void)configureFirstSectioHeaderNibName:(NSString *)firstSectionHeaderNibName
         configureFirstSectionHeaderBlock:(ConfigurefirstSectionHeaderBlock)configurefirstSectionHeaderBlock
{
    
    self.configurefirstSectionHeaderBlock = configurefirstSectionHeaderBlock;
    [self _registerFirstSectionHeaderForNibName:firstSectionHeaderNibName];

}




@end

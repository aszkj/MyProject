//
//  JCTagListView.m
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCTagListView.h"
#import "JCTagCell.h"
#import "CommonCategaryModel.h"
#import "JCCollectionViewTagFlowLayout.h"

@interface JCTagListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) JCTagListViewBlock selectedBlock;

@end

@implementation JCTagListView

static NSString * const reuseIdentifier = @"tagListViewItemId";

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.bounds;
}

- (void)setup
{
    _selectedTags = [NSMutableArray array];
    _tags = [NSMutableArray array];
    
    _tagStrokeColor = [UIColor lightGrayColor];
    _tagBackgroundColor = [UIColor clearColor];
    _tagTextColor = [UIColor darkGrayColor];
    _tagSelectedBackgroundColor = [UIColor colorWithRed:217/255.0f green:217/255.0f blue:217/255.0f alpha:1];
    _canSelectMutialTags = YES;
    _canSelectTags = YES;
    _canCancelSelectedTag = YES;
    _tagCornerRadius = 10.0f;
    
    JCCollectionViewTagFlowLayout *layout = [[JCCollectionViewTagFlowLayout alloc] init];

    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[JCTagCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:_collectionView];
}


#pragma mark -------------------Getter/Setter Method----------------------
- (void)setCompletionBlockWithSelected:(JCTagListViewBlock)completionBlock
{
    self.selectedBlock = completionBlock;
}

- (void)setMinuHorizonalSpace:(CGFloat)minuHorizonalSpace {
    _minuHorizonalSpace = minuHorizonalSpace;
    JCCollectionViewTagFlowLayout *layout = (JCCollectionViewTagFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = _minuHorizonalSpace;
}

- (void)setContentSectionInset:(UIEdgeInsets)contentSectionInset {
    _contentSectionInset = contentSectionInset;
    JCCollectionViewTagFlowLayout *layout = (JCCollectionViewTagFlowLayout *)self.collectionView.collectionViewLayout;
    layout.sectionInset = contentSectionInset;
}
- (void)setMinuVerticalSpace:(CGFloat)minuVerticalSpace {
    _minuVerticalSpace = minuVerticalSpace;
    JCCollectionViewTagFlowLayout *layout = (JCCollectionViewTagFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumLineSpacing = _minuHorizonalSpace;

}

-(CGFloat)contentHeight {

    return self.collectionView.contentSize.height;
}

-(void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    [self.selectedTags addObjectsFromArray:[self getSelectedArrInTags]];
}


-(NSArray *)getSelectedArrInTags {
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.tags.count];
    for (CommonCategaryModel *model in self.tags) {
        if (model.selected) {
            [tempArr addObject:model];
        }
    }
    return [tempArr copy];
}

#pragma mark -------------------Public Method----------------------
- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark -------------------Private Method----------------------
- (void)_selectedCell:(JCTagCell *)cell{
    cell.backgroundColor = self.tagSelectedBackgroundColor;
    cell.titleLabel.textColor = self.tagSelectedTextColor;
}

- (void)_deselectedCell:(JCTagCell *)cell{
    cell.backgroundColor = self.tagBackgroundColor;
    cell.titleLabel.textColor = self.tagTextColor;
}

- (void)_deselectSelectedCellInCollectionView:(UICollectionView *)collectionView {
    
    for (CommonCategaryModel *model in self.selectedTags) {
        JCTagCell *cell = (JCTagCell *)[collectionView cellForItemAtIndexPath:model.modelAtIndexPath];
        [self _deselectedCell:cell];
    }
}

- (void)_deselectSelectedModelInTags {
    
    for (CommonCategaryModel *model in self.tags) {
        if (model.selected) {
            model.selected = NO;
        }
    }
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JCCollectionViewTagFlowLayout *layout = (JCCollectionViewTagFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    CommonCategaryModel *model = self.tags[indexPath.item];
    NSString *categaryName = model.categaryName;
    CGRect frame = [categaryName boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    
    return CGSizeMake(frame.size.width + 20.0f, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JCTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.borderColor = self.tagStrokeColor.CGColor;
    cell.layer.cornerRadius = self.tagCornerRadius;
    CommonCategaryModel *model = self.tags[indexPath.item];
    NSString *categaryName = model.categaryName;
    cell.titleLabel.text = categaryName;
    if (model.selected) {
        [self _selectedCell:cell];
    }else {
        [self _deselectedCell:cell];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.canSelectTags) {
        JCTagCell *cell = (JCTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
        CommonCategaryModel *model = self.tags[indexPath.item];
        if (model.selected) {
            if (self.canCancelSelectedTag) {
                [self _deselectedCell:cell];
                model.selected = NO;
                [self.selectedTags removeObject:model];
            }
        }
        else {
            [self _selectedCell:cell];
            if (!self.canSelectMutialTags) {
                [self _deselectSelectedCellInCollectionView:collectionView];
                [self _deselectSelectedModelInTags];
                [self.selectedTags removeAllObjects];
            }
            model.selected = YES;
            [self.selectedTags addObject:model];
        }
    }
    
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.item,self.selectedTags,self.tags);
    }
}


@end

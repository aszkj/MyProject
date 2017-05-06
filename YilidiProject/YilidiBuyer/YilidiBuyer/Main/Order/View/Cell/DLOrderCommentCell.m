//
//  DLOrderCommentCell.m
//  YilidiBuyer
//
//  Created by mm on 17/2/7.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLOrderCommentCell.h"
#import "MyCommonCollectionView.h"
#import "UIImageView+sd_SetImg.h"
#import "UITextView+Placeholder.h"
#import "CWStarRateView.h"
#import "DLOrderGoodsCommentImgCell.h"
#import "UploadPhotoManager.h"

@interface DLOrderCommentCell()<CWStarRateViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *commentPhotoCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentPhotoCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *commentGoodsImgView;
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *testCollectionView;
@property (nonatomic,strong) UploadPhotoManager *uploadPhotoManager;

@property (weak, nonatomic) IBOutlet CWStarRateView *startRateView;
@end

@implementation DLOrderCommentCell

#pragma mark ----- init
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self _initCommentPhotoCollectionView];
    self.commentContentTextView.placeholder = @"说点什么呢..";
    self.commentPhotoCollectionViewHeightConstraint.constant = DefaultCommentPhotoPartHeight;
    self.startRateView.delegate = self;
    self.commentContentTextView.delegate = self;
}

- (void)setOrderCommentModel:(OrderCommentModel *)orderCommentModel {
    _orderCommentModel = orderCommentModel;
//    [self _updateCell];
}

- (void)_initCommentPhotoCollectionView {
//    WEAK_SELF
//    [self.commentPhotoCollectionView configureCollectionCellNibName:@"DLOrderGoodsCommentImgCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
//        DLOrderGoodsCommentImgCell *cell = (DLOrderGoodsCommentImgCell *)collectionCell;
//        CommentPhotoModel *model = (CommentPhotoModel *)collectionModel;
//        cell.deleteCommentPhotoBlock = ^(CommentPhotoModel *commentModel){
//            [weak_self _deleteCommentPhoto:commentModel];
//        };
//        cell.commentPhotoModel = model;
//    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
//        CommentPhotoModel *model = (CommentPhotoModel *)collectionModel;
//        if (!model.commentPhotoImg) {
//            [weak_self _addCommentPhoto];
//        }
//    }];
//    
//    
//    
//    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:OneScreenDisplayMaxPhotoCount horizontalDisplayAreaWidth:kScreenWidth cellImgToSideEdge:CommentPhotoImgToSideEdge cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:CommentPhotoImgToSideEdge*2 edgeBetweenCellAndCell:0 edgeBetweenCellAndSide:0];
//    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
//    self.commentPhotoCollectionView.cellCalculateModel = cellCaculateModel;
//    self.commentPhotoCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
//    self.commentPhotoCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
////    self.commentPhotoCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(CommentPhotoImgToSideEdge, CommentPhotoImgToSideEdge, CommentPhotoImgToSideEdge, CommentPhotoImgToSideEdge);
//    
//    [self performSelector:@selector(testReloadCollectionView) withObject:nil afterDelay:0.8];
    WEAK_SELF
    [self.testCollectionView configureCollectionCellNibName:@"DLOrderGoodsCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
//        DLOrderGoodsCell *cell = (DLOrderGoodsCell *)collectionCell;
//        GoodsModel *model = (GoodsModel *)collectionModel;
//        cell.imgWidthConstraint.constant = weak_self.goodsCollectionView.cellCalculateModel.cellImgWidth;
//        cell.imgHeightConstraint.constant = weak_self.goodsCollectionView.cellCalculateModel.cellImgHeight;
//        [cell setCellModel:model];
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        
    }];
    
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:OneScreenDisplayMaxPhotoCount horizontalDisplayAreaWidth:kScreenWidth-70 cellImgToSideEdge:10 cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:16 edgeBetweenCellAndCell:0 edgeBetweenCellAndSide:0];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.commentPhotoCollectionView.cellCalculateModel = cellCaculateModel;
    
    self.commentPhotoCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, 70);
    self.commentPhotoCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.commentPhotoCollectionView.dataLogicModule.currentDataModelArr = [@[@"",@""] mutableCopy];
    [self.commentPhotoCollectionView reloadData];


}

- (void)testReloadCollectionView {
    self.commentPhotoCollectionView.dataLogicModule.currentDataModelArr = [@[@"",@""] mutableCopy];
    [self.commentPhotoCollectionView reloadData];

}

#pragma mark -------- add & delete photo
- (void)_deleteCommentPhoto:(CommentPhotoModel *)model {
    [self.orderCommentModel.commentImages removeObject:model];
    [self setNeedsLayout];
    
    [self _checkWhetherNeedUpdateHeightAfterAddCommentPhoto:NO];
}

- (void)_checkWhetherNeedUpdateHeightAfterAddCommentPhoto:(BOOL)addCommentPhoto {
    if ([self.orderCommentModel needToUpdateHeightWhenAddCommentPhoto:addCommentPhoto]) {
        [self.orderCommentModel updateCommentTotalHeight];
//        emptyBlock(self.needToUpdateCellHeightBlock);
    }
}

- (void)_addCommentPhoto {
    CommentPhotoModel *model = [[CommentPhotoModel alloc] init];
    WEAK_SELF
    [self.uploadPhotoManager uploadPhoto:^(UIImagePickerController *picker, UIImage *image, NSDictionary *editingDic) {
        model.commentPhotoImg = image;
        [weak_self.orderCommentModel.commentImages addObject:model];
        [weak_self setNeedsLayout];
        [weak_self _checkWhetherNeedUpdateHeightAfterAddCommentPhoto:YES];
    } upDateImg:^(NSString *updateImgUrl, NSError *updateImgError) {
        if (updateImgError.code == 1) {
            model.commentPhotoImageUrl = updateImgUrl;
        }
    }];
}

#pragma mark -------- update cell
- (void)layoutSubviews {
    [super layoutSubviews];
    [self _updateCell];
}

- (void)_updateCell {
    [self.commentGoodsImgView sd_SetImgWithUrlStr:self.orderCommentModel.commentGoodsImgUrl placeHolderImgName:nil];
    self.commentContentTextView.text = self.orderCommentModel.commentContent;
    [self _updateStartView];
    [self _updateCommentPhotoCollectionView];
}

- (void)_updateStartView {
    self.startRateView.frame = CGRectMake(138, (50-17)/2, 145, 17);
    self.startRateView.originalImgName = @"starMakeCommentNormal";
    self.startRateView.hilightedImgName = @"starMakeCommentHilight";
    self.startRateView.isCanbeTouch = YES;
    self.startRateView.scorePercent = self.orderCommentModel.saleProductScore;
}

- (void)_updateCommentPhotoCollectionView {
    self.commentPhotoCollectionViewHeightConstraint.constant = self.orderCommentModel.commentPhotoPartHeight;
//    self.commentPhotoCollectionView.dataLogicModule.currentDataModelArr = self.orderCommentModel.commentImages;
//    [self.commentPhotoCollectionView reloadData];
  
}

- (UploadPhotoManager *)uploadPhotoManager {
    if (!_uploadPhotoManager) {
        _uploadPhotoManager = [[UploadPhotoManager alloc] init];
    }
    return _uploadPhotoManager;
}

#pragma mark ----------- textViewdelegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    self.orderCommentModel.saleProductScore = newScorePercent;
}

#pragma mark ----------- textViewdelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    self.orderCommentModel.commentContent = textView.text;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length > 0 && [text isEqualToString:@""]) {
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self.commentContentTextView resignFirstResponder];
    }

    if (range.location > 300 || textView.text.length > 300){
         return FALSE;
    }
    return TRUE;
}


@end

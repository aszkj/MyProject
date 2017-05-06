//
//  DLTestCell.m
//  YilidiBuyer
//
//  Created by mm on 17/2/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLOrderMakeCommentCell.h"
#import "MyCommonCollectionView.h"
#import "MyCommonCollectionView.h"
#import "UIImageView+sd_SetImg.h"
#import "UITextView+Placeholder.h"
#import "CWStarRateView.h"
#import "DLOrderGoodsCommentImgCell.h"
#import "UploadPhotoManager.h"
#import "ProjectRelativeDefineNotification.h"
#import "WSPhotosBroseVC.h"
#import "NSArray+SUIAdditions.h"
#import "NSString+Teshuzifu.h"
#import "NSString+SUIRegex.h"


@interface DLOrderMakeCommentCell ()<CWStarRateViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet MyCommonCollectionView *commentPhotoCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentPhotoCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *commentGoodsImgView;
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;
@property (nonatomic,strong) UploadPhotoManager *uploadPhotoManager;
@property (nonatomic,strong) UIViewController *currentVC;
@property (weak, nonatomic) IBOutlet CWStarRateView *startRateView;

@end

@implementation DLOrderMakeCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self _initCommentPhotoCollectionView];
    self.commentContentTextView.placeholder = @"说点什么呢..";
    self.commentPhotoCollectionViewHeightConstraint.constant = DefaultCommentPhotoPartHeight;
    self.startRateView.delegate = self;
    self.commentContentTextView.delegate = self;
}

- (void)_initCommentPhotoCollectionView {
    WEAK_SELF
    [self.commentPhotoCollectionView configureCollectionCellNibName:@"DLOrderGoodsCommentImgCell" configureCollectionCellData:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell,NSIndexPath *clickIndexPath) {
        DLOrderGoodsCommentImgCell *cell = (DLOrderGoodsCommentImgCell *)collectionCell;
        CommentPhotoModel *model = (CommentPhotoModel *)collectionModel;
        cell.deleteCommentPhotoBlock = ^(CommentPhotoModel *commentModel){
            [weak_self _deleteCommentPhoto:commentModel];
        };
        cell.commentPhotoModel = model;
    } clickCell:^(UICollectionView *collectionView,id collectionModel, UICollectionViewCell *collectionCell, NSIndexPath *clickIndexPath) {
        CommentPhotoModel *model = (CommentPhotoModel *)collectionModel;
        if (model.isAddPhoto) {//添加图片，isAddPhoto属性只有第一次赋值了
            [weak_self _addCommentPhoto];
        }else {//查看
            [weak_self browseCommentPhotoAtRow:clickIndexPath.row photoModel:model];
        }
    }];
    
    
    
    CellCalculateNeedModel *cellCaculateNeedModel = [[CellCalculateNeedModel alloc] initWithHorizontalDisplayCount:OneScreenDisplayMaxPhotoCount horizontalDisplayAreaWidth:kScreenWidth-CommentCollectionToSideEdges*2 cellImgToSideEdge:CommentPhotoImgToSideEdge cellImgWidthToHeightScale:1.0 cellOterPartHeightBesideImg:CommentPhotoImgToSideEdge*2 edgeBetweenCellAndCell:0 edgeBetweenCellAndSide:CommentPhotoImgToSideEdge];
    CellCalculateModel *cellCaculateModel = [[CellCalculateModel alloc] initWithCalculateNeedModel:cellCaculateNeedModel];
    self.commentPhotoCollectionView.cellCalculateModel = cellCaculateModel;
    self.commentPhotoCollectionView.commonFlowLayout.itemSize = CGSizeMake(cellCaculateModel.cellWidth, cellCaculateModel.cellHeight);
    self.commentPhotoCollectionView.commonFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.commentPhotoCollectionView.commonFlowLayout.sectionInset = UIEdgeInsetsMake(CommentPhotoImgToSideEdge, CommentPhotoImgToSideEdge, CommentPhotoImgToSideEdge, CommentPhotoImgToSideEdge);
    
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
        emptyBlock(self.needToUpdateCellHeightBlock);
    }
}

- (void)_addCommentPhoto {
    
    @autoreleasepool {
        CommentPhotoModel *model = [[CommentPhotoModel alloc] init];
        BLOCK_OBJ(model)
        WEAK_OBJ(model)
        WEAK_SELF
        self.uploadPhotoManager.uploadServerUlr = kUrl_PostMakeCommentPhotoImage;
        [self.uploadPhotoManager uploadPhoto:^UploadPhotoImgHandler *(UIImagePickerController *picker, UIImage *image,NSDictionary *editingDic) {
            @autoreleasepool {
            
                UploadPhotoImgHandler *uploadPhotoImgHandler = [[UploadPhotoImgHandler alloc] init];
                if ([uploadPhotoImgHandler isToBigOfCommentPhoto:image]) {
                    [Util ShowAlertWithOnlyMessage:@"图片不符合规格，请重新选择图片"];
                    return uploadPhotoImgHandler;
                }else {
//                    //只得到评论列表显示的图片
//                      block_model.commentPhotoImg =  [uploadPhotoImgHandler getMakeCommentListShowPhoto:image];
                   [uploadPhotoImgHandler getMakeCommentListShowPhoto:image];
                    return uploadPhotoImgHandler;
                }
            }
    
        } upDateImg:^(NSString *updateImgUrl, NSError *updateImgError) {
            if (updateImgError.code == 1) {
                block_model.commentPhotoImageUrl = updateImgUrl;
                [weak_self.orderCommentModel.commentImages insertObject:weak_model atIndex:weak_self.orderCommentModel.commentImages.count-1];
                [weak_self setNeedsLayout];
                [weak_self _checkWhetherNeedUpdateHeightAfterAddCommentPhoto:YES];
            }else {
                [Util ShowAlertWithOnlyMessage:updateImgError.localizedDescription];
            }
        }];
    }
}

#pragma mark - comment photo browse
- (void)browseCommentPhotoAtRow:(NSInteger)row photoModel:(CommentPhotoModel *)model{
    WSPhotosBroseVC *vc = [WSPhotosBroseVC new];
    vc.imageArray = [[[self.orderCommentModel commentImgs] sui_map:^WSImageModel *(CommentPhotoModel *commentImageModel, NSUInteger index) {
        WSImageModel *photoModel = [WSImageModel new];
//        photoModel.image = commentImage;
        photoModel.imageUrl = [commentImageModel.commentPhotoImageUrl getOriginalImgUrl];
        return photoModel;
    }] mutableCopy];
    vc.showIndex = row;
    WEAK_SELF
    vc.deletePhotoBlock = ^(NSInteger deleteRow,UIImage *deleteImage){
        CommentPhotoModel *deleteModel = [weak_self.orderCommentModel.commentImages objectAtIndex:deleteRow];
        [weak_self _deleteCommentPhoto:deleteModel];
    };
    [self.currentVC.navigationController pushViewController:vc animated:YES];
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
    self.startRateView.frame = CGRectMake(121, (44-17)/2, 145, 17);
    self.startRateView.originalImgName = @"starMakeCommentNormal";
    self.startRateView.hilightedImgName = @"starMakeCommentHilight";
    self.startRateView.isCanbeTouch = YES;
    self.startRateView.scorePercent = self.orderCommentModel.saleProductScore;
}

- (void)_updateCommentPhotoCollectionView {
    self.commentPhotoCollectionViewHeightConstraint.constant = self.orderCommentModel.commentPhotoPartHeight;
    self.commentPhotoCollectionView.dataLogicModule.currentDataModelArr = self.orderCommentModel.commentImages;
    [self.commentPhotoCollectionView reloadData];
    
}

- (UploadPhotoManager *)uploadPhotoManager {
    if (!_uploadPhotoManager) {
        _uploadPhotoManager = [[UploadPhotoManager alloc] init];
    }
    return _uploadPhotoManager;
}

- (UIViewController *)currentVC {
    if (!_currentVC) {
        _currentVC = [Util currentViewController];
    }
    return _currentVC;
}

#pragma mark ----------- StartViewdelegate
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    self.orderCommentModel.saleProductScore = newScorePercent;
    [kNotification postNotificationName:KNotificationHasCommentStarNotification object:nil];
}

#pragma mark ----------- textViewdelegate
- (void)textViewDidChange:(UITextView *)textView {
    
    self.orderCommentModel.commentContent = self.commentContentTextView.text;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length > 0 && [text isEqualToString:@""]) {
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {
        [self.commentContentTextView resignFirstResponder];
    }
    

    if (![text sui_validateCommonInputOne]) {
        return FALSE;
    }
    
   
    if (range.location > 300 || textView.text.length > 300){
        return FALSE;
    }
    return TRUE;
}


@end

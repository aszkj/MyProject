//
//  DLOrderGoodsCommentImgCell.h
//  YilidiBuyer
//
//  Created by mm on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentPhotoModel;
typedef void(^DeleteCommentPhotoBlock)(CommentPhotoModel *);

@interface DLOrderGoodsCommentImgCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *commentImgView;
@property (weak, nonatomic) IBOutlet UIButton *commentImgDeleteButton;

@property (nonatomic,strong)CommentPhotoModel *commentPhotoModel;
@property (nonatomic,copy)DeleteCommentPhotoBlock deleteCommentPhotoBlock;


@end


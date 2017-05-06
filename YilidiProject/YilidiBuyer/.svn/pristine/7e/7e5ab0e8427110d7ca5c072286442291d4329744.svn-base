//
//  DLOrderGoodsCommentImgCell.m
//  YilidiBuyer
//
//  Created by mm on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLOrderGoodsCommentImgCell.h"
#import "CommentPhotoModel.h"
#import "UIImageView+sd_SetImg.h"



@implementation DLOrderGoodsCommentImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)deletePhotoAction:(id)sender {
    emptyBlock(self.deleteCommentPhotoBlock,self.commentPhotoModel);
}

- (void)setCommentPhotoModel:(CommentPhotoModel *)commentPhotoModel {
    _commentPhotoModel = commentPhotoModel;
    [self setCellModel:commentPhotoModel];
}

- (void)setCellModel:(CommentPhotoModel *)model {
    
    if (!model.isAddPhoto) {
//        self.commentImgView.image = model.commentPhotoImg;
        [self.commentImgView sd_SetImgWithUrlStr:model.commentPhotoImageUrl placeHolderImgName:nil];
    }else {
        self.commentImgView.image = IMAGE(@"添加图片");
    }
    
}


@end


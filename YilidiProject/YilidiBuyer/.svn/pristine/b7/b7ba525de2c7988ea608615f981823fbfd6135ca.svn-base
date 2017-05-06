//
//  OrderCommentModel.m
//  YilidiBuyer
//
//  Created by mm on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "OrderCommentModel.h"
#import "GlobeMaco.h"

@interface OrderCommentModel ()

@end

@implementation OrderCommentModel


- (instancetype)initWithDefaultDataDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.saleProductScore = 5.0f;
        [self _initCommentImages];
        self.commentTotalHeight = DefaultCommentTotalHeight;
        self.commentPhotoPartHeight = DefaultCommentPhotoPartHeight;
    }
    return self;
}

- (void)_initCommentImages {
    self.commentImages = [NSMutableArray arrayWithCapacity:1];
    CommentPhotoModel *commentPhotoModel = [[CommentPhotoModel alloc] init];
    commentPhotoModel.commentPhotoImg = nil;
    commentPhotoModel.isAddPhoto = YES;
    [self.commentImages addObject:commentPhotoModel];

}

-(BOOL)needToUpdateHeightWhenAddCommentPhoto:(BOOL)addCommentPhoto {
    NSInteger photoArrCount = self.commentImages.count;
    if (addCommentPhoto) {
        if (photoArrCount % (OneScreenDisplayMaxPhotoCount) == 1) {
            return YES;
        }
    }else {
        if (photoArrCount % (OneScreenDisplayMaxPhotoCount) == 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)commentImgUrls {

    NSMutableArray *realCommentImgArr = [NSMutableArray arrayWithCapacity:self.commentImages.count];
    if (self.commentImages.count > 1) {
        for (NSInteger i=0; i<self.commentImages.count-1; i++) {
            CommentPhotoModel *commentPhotoModel = self.commentImages[i];
            if (commentPhotoModel.commentPhotoImageUrl) {
                NSDictionary *photoUrlDic = @{@"imageUrl":commentPhotoModel.commentPhotoImageUrl};
                [realCommentImgArr addObject:photoUrlDic];
            }
        }
    }else {
        return @[];
    }
    return [realCommentImgArr copy];
}

- (NSArray *)commentImgs {
    NSMutableArray *realCommentImgs = [NSMutableArray arrayWithCapacity:self.commentImages.count];
    if (self.commentImages.count > 1) {
        for (NSInteger i=0; i<self.commentImages.count-1; i++) {
            CommentPhotoModel *commentPhotoModel = self.commentImages[i];
            [realCommentImgs addObject:commentPhotoModel];
        }
    }else {
        return @[];
    }
    return [realCommentImgs copy];


}



-(void)updateCommentTotalHeight {
    
    NSInteger commentRows = CalculateItemsRow(self.commentImages.count, OneScreenDisplayMaxPhotoCount);
    const NSInteger MaxCommentRows = 2;
    if (commentRows >= MaxCommentRows) {
        commentRows = MaxCommentRows;
    }
    CGFloat cellHeight = DefaultCommentPhotoPartHeight - 2 * CommentPhotoImgToSideEdge;
    self.commentPhotoPartHeight = commentRows * cellHeight + 2 * CommentPhotoImgToSideEdge;
    self.commentTotalHeight = self.commentPhotoPartHeight + CommentFixedPartHeight;
    
}


@end



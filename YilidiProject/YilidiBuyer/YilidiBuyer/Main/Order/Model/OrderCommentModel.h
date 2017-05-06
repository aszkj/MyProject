//
//  OrderCommentModel.h
//  YilidiBuyer
//
//  Created by mm on 17/2/8.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "BaseModel.h"
#import "CommentPhotoModel.h"

#define CommentPhotoImgToSideEdge 5
#define OneScreenDisplayMaxPhotoCount 5
#define MaxCommentPhotoCount 10
#define CommentFixedPartHeight 141
#define CommentCollectionToSideEdges 7
#define DefaultCommentPhotoPartHeight ((kScreenWidth - CommentCollectionToSideEdges * 2 - CommentPhotoImgToSideEdge * 2 * (OneScreenDisplayMaxPhotoCount + 1)) / OneScreenDisplayMaxPhotoCount + CommentPhotoImgToSideEdge * 2 * 2)
#define DefaultCommentTotalHeight (DefaultCommentPhotoPartHeight + CommentFixedPartHeight)

@interface OrderCommentModel : BaseModel

@property (nonatomic,copy)NSString *commentGoodsImgUrl;

@property (nonatomic,copy)NSString *commentGoodsId;

@property (nonatomic,copy)NSString *commentContent;

@property (nonatomic,assign)CGFloat saleProductScore;

@property (nonatomic,strong)NSMutableArray *commentImages;

@property (nonatomic,assign)CGFloat commentTotalHeight;

@property (nonatomic,assign)CGFloat commentPhotoPartHeight;

- (NSArray *)commentImgUrls;
- (NSArray *)commentImgs;


-(void)updateCommentTotalHeight;

-(BOOL)needToUpdateHeightWhenAddCommentPhoto:(BOOL)addCommentPhoto;

@end



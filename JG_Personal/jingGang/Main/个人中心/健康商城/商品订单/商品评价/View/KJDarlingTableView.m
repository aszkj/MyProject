//
//  KJDarlingTableView.m
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJDarlingTableView.h"
#import "KJDarlingCommentCell.h"
#import "GlobeObject.h"
#import "DarlingCommentModel.h"
#import "GoodsInfoModel.h"

@interface KJDarlingTableView(){

    NSMutableArray *_isAddedPhotoArr; //标志每个cell是否新增了图片，如果新增加，则高度不同
    
    NSMutableArray *_commentModelArr;//放置评论操作模型的数组
}

@end

@implementation KJDarlingTableView


static NSString *KJDarlingCommentCellID = @"KJDarlingCommentCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"KJDarlingCommentCell" bundle:nil]  forCellReuseIdentifier:KJDarlingCommentCellID];
        
//        _isAddedPhotoArr = [NSMutableArray arrayWithCapacity:5];
        _commentModelArr = [NSMutableArray arrayWithCapacity:5];
        
        for (int i=0; i<5; i++) {
            DarlingCommentModel *model = [[DarlingCommentModel alloc] init];
            [_commentModelArr addObject:model];
            
        }
    }
    
    return self;
}

-(void)setGoodsArr:(NSArray *)goodsArr{
    _goodsArr = goodsArr;
    _commentModelArr = [NSMutableArray arrayWithCapacity:_goodsArr.count];
    for (int i=0; i<_goodsArr.count; i++) {
        DarlingCommentModel *model = [[DarlingCommentModel alloc] init];
        model.descriptionStars = 5;
        model.serviceAltitudeStars = 5;
        model.deliveryServiceStars = 5;
        [_commentModelArr addObject:model];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _goodsArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KJDarlingCommentCell *cell = [self dequeueReusableCellWithIdentifier:KJDarlingCommentCellID forIndexPath:indexPath];
    //从评论表中编辑产生的模型
    DarlingCommentModel *model = _commentModelArr[indexPath.row];
    cell.model = model;
    //网络中的商品模型
    cell.goodsInfoModel = self.goodsArr[indexPath.row];
    
    WEAK_SELF
    cell.photoEditCauseHeightChangeBlock = ^(BOOL isAddHeight){
    
        [weak_self reloadData];
    };
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DarlingCommentModel *model = _commentModelArr[indexPath.row];
    CGFloat height = model.isAddedPhoto ? (cellOriginalHeight + addHeight) : cellOriginalHeight;
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}






@end

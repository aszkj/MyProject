//
//  XKJHCommentManageMentTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/8.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHCommentManageMentTableView.h"
#import "XKJHCommentManageMentCell.h"

@implementation XKJHCommentManageMentTableView


static NSString *XKJHCommentManageMentCellID = @"XKJHCommentManageMentCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
        
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _init];
    }
    return self;
}



-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"XKJHCommentManageMentCell" bundle:nil]  forCellReuseIdentifier:XKJHCommentManageMentCellID];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return self.dataLogicModule.currentDataModelArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHCommentManageMentCell *cell = [tableView dequeueReusableCellWithIdentifier:XKJHCommentManageMentCellID forIndexPath:indexPath];
//    cell.dic = self.dataLogicModule.currentDataModelArr[indexPath.row];
    cell.groupEvaluatesModel = self.dataLogicModule.currentDataModelArr[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GroupEvaluates *model = self.dataLogicModule.currentDataModelArr[indexPath.row];
    //评论部分高度
    CGFloat commentTextHeight = kStringSize(model.content, 14, kScreenWidth-38, 1000).height;
    CGFloat commentPartHeight = commentTextHeight + 14;
    NSInteger imgUrlMinLength = 5;
//    NSArray *commentPhotoArr = [model.photoUrls componentsSeparatedByString:@";"];
    if (model.photoUrls.length > imgUrlMinLength) {//有评论相片
        commentPartHeight = commentTextHeight + 89;
    }
    
    //回复部分高度
    CGFloat repyPartHeight = 0.0;
    if (!model.replyContent) {//无回复
        //那就是回复按钮的高度
        repyPartHeight = 24 + 5;
    }else{//否则，回复内容的高度
        NSString *newRepyContent = [NSString stringWithFormat:@"[掌柜回复]我来说说。%@",model.replyContent];
        repyPartHeight = kStringSize(newRepyContent, 14, kScreenWidth-44, 1000).height + 20;
    }


    //总高度 = 评论部分 + 回复部分 + 其他部分（98）
    return commentPartHeight + repyPartHeight + 105;
}


@end

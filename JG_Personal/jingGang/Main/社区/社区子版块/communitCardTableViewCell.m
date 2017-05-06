//
//  communitCardTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/11/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "communitCardTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PublicInfo.h"
#import "VApiManager.h"
#import "GlobeObject.h"


#import "MJExtension.h"

@interface communitCardTableViewCell ()
{
    VApiManager *_vapiManager;
    NSDictionary *_dict;
}

@end

@implementation communitCardTableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _vapiManager = [[VApiManager alloc] init];
}
- (IBAction)shareAction:(id)sender {
    UNLOGIN_HANDLE
    if (self.shareBlock) {
        self.shareBlock();
    }
}
- (IBAction)fallowAction:(id)sender {
    UNLOGIN_HANDLE
    if (self.fallowBlock) {
        self.fallowBlock();
    }
}
- (IBAction)numAction:(id)sender {
    UNLOGIN_HANDLE
    if (self.numWithBlock)
    {
        if (self.isNum)
        {
            [self dissmissPraise];
        }
        else
        {
            [self praiseClickChange];
        }
    }
}
- (IBAction)likeAction:(id)sender {
    UNLOGIN_HANDLE
    if (self.likeWithBlock) {
        if (self.isLike)
        {
            [self UsersfavioritesCancle];
        }
        else
        {
            [self FavoriteUser];
        }
    }
}


- (void)customCellWithDict:(NSDictionary *)dict withCircle:(BOOL)cricle withTimePast:(NSString *)comStr
{
    _dict = dict;
    CircleInvitation *data = [CircleInvitation objectWithKeyValues:dict];
    [self  setData:data withComStr:comStr];
    if (cricle) {
        self.head_img.layer.cornerRadius = CGRectGetHeight(self.head_img.frame) / 2;
        self.head_img.clipsToBounds = YES;
    }
    else
    {
        self.head_img.layer.cornerRadius = 0;
        self.head_img.clipsToBounds = NO;
    }
}
#pragma mark - 对cell数据的赋值
-(void)setData:(CircleInvitation *)data withComStr:(NSString *)comStr
{
    NSString *url = [NSString stringWithFormat:@"%@_%ix%i",data.headImgPath ? data.headImgPath:data.thumbnail,(int)self.head_img.frame.size.width*2,(int)self.head_img.frame.size.height*2];
    [self.head_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"home_head"]];
    self.main_lab.text = data.title;
    BOOL strType = [comStr isEqualToString:@"发"];
    if (!data.userName) {
        self.time_lab.text = [NSString stringWithFormat:@"匿名用户发表于%@",data.publicTime];
    }
    else
    {
        self.time_lab.text = [NSString stringWithFormat:@"%@%@%@%@",data.userName, strType ? @"发表于":@"在",data.publicTime,strType ? @"":@"发布"];
    }
    [self fuwenbenLabel:self.time_lab FontNumber:[UIFont systemFontOfSize:15] withStr:comStr AndColor:communit_color_1];
    self.num_lab.text = [NSString stringWithFormat:@"%@",data.praiseCount];
    NSNumber *replyC = data.replyCount;
    if ([replyC intValue] == 0) {
        self.fallow_lab.text = @"跟帖";
    }
    else{
        self.fallow_lab.text = [NSString stringWithFormat:@"跟帖(%@)",replyC];
    }
    //判断是否点赞过和收藏
    self.isNum = [data.isPraise boolValue];
    self.isLike = [data.isFavo boolValue];
}


- (void)setIsLike:(BOOL)isLike
{
    _isLike = isLike;
    if (isLike) //收藏
    {
        [self.like_btn setBackgroundImage:[UIImage imageNamed:@"com_collect_pressed"] forState:UIControlStateNormal];
        self.like_lab.textColor = [UIColor redColor];
    }
    else
    {
        [self.like_btn setBackgroundImage:[UIImage imageNamed:@"com_collect"] forState:UIControlStateNormal];
        self.like_lab.textColor = [UIColor lightGrayColor];
    }
    
}
- (void)setIsNum:(BOOL)isNum
{
    _isNum = isNum;
    if (isNum) //点赞
    {
        [self.num_btn setBackgroundImage:[UIImage imageNamed:@"com_zambia_pressed"] forState:UIControlStateNormal];
        self.num_lab.textColor = [UIColor redColor];
    }
    else
    {
        [self.num_btn setBackgroundImage:[UIImage imageNamed:@"com_zambia"] forState:UIControlStateNormal];
        self.num_lab.textColor = [UIColor lightGrayColor];
    }
    
}
- (void)setIsShare:(BOOL)isShare
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.share_btn setBackgroundImage:[UIImage imageNamed:@"com_share_pressed"] forState:UIControlStateNormal];
        self.share_lab.textColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        [self.share_btn setBackgroundImage:[UIImage imageNamed:@"com_share"] forState:UIControlStateNormal];
        self.share_lab.textColor = [UIColor lightGrayColor];
    }];
}

-(void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font withStr:(NSString *)comStr AndColor:(UIColor *)vaColor
{
    NSString * str = [NSString stringWithFormat:@"%@",labell.text];
    NSArray * array = [str componentsSeparatedByString:comStr];
    NSString * name_str = [array firstObject];
    NSInteger a = name_str.length;
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:str attributes:nil];
    
    //设置字号
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,a)];
    
    //设置文字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:vaColor range:NSMakeRange(0,a)];
    
    labell.attributedText = attributedString;
}

#pragma mark - ==========================网络请求数据=========点赞和收藏=======================

#pragma mark - 取消点赞
-(void)dissmissPraise
{
    WEAK_SELF
    UsersCanclePraiseRequest *usersCanclePraiseRequest = [[UsersCanclePraiseRequest alloc] init:GetToken];
    usersCanclePraiseRequest.api_fid = _dict[@"id"];
    [_vapiManager usersCanclePraise:usersCanclePraiseRequest success:^(AFHTTPRequestOperation *operation, UsersCanclePraiseResponse *response) {
        NSLog(@"取消点赞成功＝＝＝");
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:_dict];
        [mutableDict setObject:@(0) forKey:@"isPraise"];
        [mutableDict setObject:@([_dict[@"praiseCount"] intValue] - 1) forKey:@"praiseCount"];
        weak_self.numWithBlock(mutableDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"取消点赞失败");
        [Util ShowAlertWithOnlyMessage:@"取消点赞失败"];
    }];
}
#pragma mark - 点赞
-(void)praiseClickChange
{
    WEAK_SELF
    UsersPraiseRequest *usersPraiseRequest = [[UsersPraiseRequest alloc] init:GetToken];
    usersPraiseRequest.api_fid = _dict[@"id"];
    [_vapiManager usersPraise:usersPraiseRequest success:^(AFHTTPRequestOperation *operation, UsersPraiseResponse *response) {
        NSLog(@"---点赞成功");
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:_dict];
        [mutableDict setObject:@(1) forKey:@"isPraise"];
        [mutableDict setObject:@([_dict[@"praiseCount"] intValue] + 1) forKey:@"praiseCount"];
        weak_self.numWithBlock(mutableDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:@"点赞失败"];
    }];
}

#pragma mark - 收藏
-(void)FavoriteUser
{
    WEAK_SELF
    UsersFavoritesRequest *usersFavorites = [[UsersFavoritesRequest alloc] init:GetToken];
    usersFavorites.api_fid = _dict[@"id"];
    usersFavorites.api_type = @"1";
    [_vapiManager usersFavorites:usersFavorites success:^(AFHTTPRequestOperation *operation, UsersFavoritesResponse *response) {
        
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:_dict];
        [mutableDict setObject:@(1) forKey:@"isFavo"];
        weak_self.likeWithBlock(mutableDict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:@"收藏失败"];
    }];
}
#pragma mark - 取消收藏成功
-(void)UsersfavioritesCancle
{
    WEAK_SELF
    UsersFavoritesCancleRequest *usersFavoritesCancleRequest = [[UsersFavoritesCancleRequest alloc] init:GetToken];
    usersFavoritesCancleRequest.api_fid = _dict[@"id"];
    [_vapiManager usersFavoritesCancle:usersFavoritesCancleRequest success:^(AFHTTPRequestOperation *operation, UsersFavoritesCancleResponse *response) {
        NSLog(@"取消收藏成功");
        NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc] initWithDictionary:_dict];
        [mutableDict setObject:@(0) forKey:@"isFavo"];
        weak_self.likeWithBlock(mutableDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [Util ShowAlertWithOnlyMessage:@"取消收藏失败"];
    }];
    
}

@end

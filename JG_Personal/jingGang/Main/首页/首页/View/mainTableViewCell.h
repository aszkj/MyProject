//
//  mainTableViewCell.h
//  jingGang
//
//  Created by yi jiehuang on 15/5/15.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainTableViewCell : UITableViewCell

//xib1
@property (nonatomic, retain)IBOutlet UIImageView  *left_img;//图片
@property (nonatomic, retain)IBOutlet UILabel      *name_lab;//标题
@property (nonatomic, retain)IBOutlet UILabel      *sub_lab;//内容
@property (nonatomic, retain)IBOutlet UIImageView  *bg_img;

//xib2
@property (nonatomic, retain)IBOutlet UIImageView  *left_img2;
@property (nonatomic, retain)IBOutlet UIImageView  *right_img2;
@property (nonatomic, retain)IBOutlet UILabel      *sub_left_lab;//左边商品详情
@property (nonatomic, retain)IBOutlet UILabel      *sub_right_lab;//右边商品详情
@property (nonatomic, retain)IBOutlet UILabel      *prise_left_lab;//左价格
@property (nonatomic, retain)IBOutlet UILabel      *prise_reight_lab;//右价格
@property (nonatomic, retain)IBOutlet UILabel      *line_lab;

//xib3
@property (nonatomic, retain)IBOutlet UIImageView  *left_img3;
@property (nonatomic, retain)IBOutlet UILabel      *name_lab3;//商家名
@property (nonatomic, retain)IBOutlet UILabel      *sever_lab3;//提供服务
@property (nonatomic, retain)IBOutlet UILabel      *address_lab3;//地址
@property (nonatomic, retain)IBOutlet UILabel      *distance_lab3;//距离
@property (nonatomic, retain)IBOutlet UILabel      *statu_lab3;//是否认证


@end

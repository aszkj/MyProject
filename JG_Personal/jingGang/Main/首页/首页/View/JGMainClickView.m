//
//  JGMainClickView.m
//  jingGang
//
//  Created by Ai song on 16/1/18.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGMainClickView.h"
//#import "PublicInfo.h"
#define __MainScreen_Width  [[UIScreen mainScreen] bounds].size.width
#define Rgb(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];

@interface JGMainClickView ()
@property (nonatomic,strong)UIImageView *imageView;
@end
@implementation JGMainClickView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}
- (void)initView{
//    健康自测
   
    NSArray *healthArr = @[@"健康自测",@"健康助手"];
    NSArray *btnArr = @[@[@"症状自测",@"综合征",@"心理自测",@"医学美容"],@[@"体检工具",@"智能穿戴",@"食物计算器",@"膳食建议"]];
    NSArray *iconImageArr = @[@"userTest",@"tool"];
    NSArray *imageArr = @[@[@"oneBtn",@"twoBtn",@"threeBtn",@"fourBtn"],@[@"fiveBtn",@"sixBtn",@"sevenBtn",@"eightBtn"]];
    UILabel *sep2Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 3+120, __MainScreen_Width, 1)];
    sep2Label.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.1];
    [self addSubview:sep2Label];
    
    
    for(int i=0;i<2;i++){
        
        UILabel *healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,i*130,__MainScreen_Width, 25)];
//
        healthLabel.backgroundColor = Rgb(255, 255, 255);
        [self addSubview:healthLabel];
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 17+130*i, 16, 16)];
        iconImage.image = [UIImage imageNamed:iconImageArr[i]];
        //        iconImage.backgroundColor = [UIColor redColor];
        [self addSubview:iconImage];
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame)+6, 15+130*i, 120, 20)];
        tagLabel.text = healthArr[i];
//        if(i == 0){
            tagLabel.textColor =COMMONTOPICCOLOR;
//        }
//        else{
//            tagLabel.textColor = Rgb(255,127,23);
//        }
        tagLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:tagLabel];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(healthLabel.frame)+1, __MainScreen_Width, 1)];
        lineLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:lineLabel];
        
        for(int j=0;j<4;j++){
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(35+j*((__MainScreen_Width-70-4*40)/3+40),CGRectGetMaxY(lineLabel.frame)+15, 40, 40);
            button.layer.cornerRadius = 40/2.0;
//            button.backgroundColor = Rgb(1, 176, 136);
            button.tag = 12306+4*i+j;
            [button setImage:[[UIImage imageNamed:imageArr[i][j]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            UILabel *tagLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 95, 25)];
            tagLabel.font = [UIFont systemFontOfSize:13];
            tagLabel.text = btnArr[i][j];
            tagLabel.textAlignment = NSTextAlignmentCenter;
            tagLabel.center = CGPointMake(button.center.x, button.center.y+40/2.0+15);
            [self addSubview:tagLabel];
        }
        
    }
    UILabel *sepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 252, __MainScreen_Width,8)];
    sepLabel.backgroundColor = [UIColor colorWithRed:10/255.0 green:10/255.0 blue:10/255.0 alpha:0.1];
    [self addSubview:sepLabel];
//    今日运动步数（广告图）
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 260, __MainScreen_Width, 85)];
    self.imageView.image = [UIImage imageNamed:@"run"];
    NSArray *numaberArr = @[@"今日运动步数",@"0"];
    
    self.numberlabel = [[UILabel alloc] initWithFrame:CGRectMake(100+100, 15, 100, 35)];
    self.numberlabel.text = numaberArr[1];
    self.numberlabel.font = [UIFont systemFontOfSize:35];
    self.numberlabel.textColor = [UIColor whiteColor];
    self.numberlabel.textAlignment = NSTextAlignmentLeft;
    [self.imageView addSubview:self.numberlabel];
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 15, 100, 35)];
    nameLabel.text = numaberArr[0];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentNatural;
    [self.imageView addSubview:nameLabel];
//    imageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.imageView];
//    km button
    self.kmButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.kmButton.frame = CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame)+5, 80, 20);
    [self.kmButton setImage:[[UIImage imageNamed:@"kmBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.kmButton.tintColor = [UIColor whiteColor];
    self.kmButton.tag = 123321;
    [self.kmButton setTitle:@"0km" forState:UIControlStateNormal];
    [self.kmButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self.kmButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.kmButton addTarget:self action:@selector(kmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:self.kmButton];
//    卡路里button
   self.calButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.calButton.frame = CGRectMake(CGRectGetMinX(self.numberlabel.frame), CGRectGetMaxY(self.numberlabel.frame)+5, 80, 20);
    [self.calButton setImage:[[UIImage imageNamed:@"kcalBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.calButton setTitle:@"0kcal" forState:UIControlStateNormal];
    self.calButton.tag = 123322;
    self.calButton.tintColor = [UIColor whiteColor];
    [self.calButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self.calButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [self.calButton addTarget:self action:@selector(kmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:self.calButton];
}
- (void)kmButtonClick:(UIButton *)sender{
//    self.delegate 
}
- (void)btnClick:(UIButton *)sender{
    [self.delegate SelectButtonClick:sender.tag];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(self.imageView.frame, point)){
        [self.delegate push];
    }
}
@end

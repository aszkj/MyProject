//
//  WSJSelectCityTableHeaderView.m
//  jingGang
//
//  Created by thinker on 15/9/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSelectCityTableHeaderView.h"
#import "PublicInfo.h"
#import "GlobeObject.h"
#import "VApiManager.h"
#import "mapObject.h"
#import "GlobeObject.h"

@interface WSJSelectCityTableHeaderView ()
{
    NSNumber *_positionID;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xian1Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xian2Height;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation WSJSelectCityTableHeaderView
- (IBAction)positionAction:(id)sender
{
    if (self.headerAction)
    {
        self.headerAction(self.positionLabel.text,_positionID);
    }
}

-(void)awakeFromNib
{
    self.xian1Height.constant = self.xian2Height.constant = 0.3;
//    self.positionLabel.text = [[mapObject sharedMap] baiduCity];
//    _positionID = [[mapObject sharedMap] baiduCityID];
    WEAK_SELF
    [[mapObject sharedMap] BaiduPositionReusltAddID:^(NSString *addressCity, CLLocationCoordinate2D location, NSNumber *cityID) {
        weak_self.positionLabel.text = addressCity;
        _positionID = cityID;
        if (weak_self.locationCity) {
            weak_self.locationCity(addressCity);
        }
    }];
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self initButton];
}
#pragma mark - 实例化按钮控件
- (void)initButton
{
    NSInteger rowNum = self.dataArray.count / 3 + ((self.dataArray.count % 3 == 0) ? 0 : 1);
    CGRect frame = self.frame;
    frame.size.height = 71 + 42 + 45 *rowNum + 10;
    self.frame = frame;
    for (NSInteger row = 0 ; row < rowNum; row ++)
    {
        for (NSInteger list = 0 ; list < 3; list ++)
        {
            if (self.dataArray.count > row * 3 + list)
            {
                UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
                btn.frame = CGRectMake(((__MainScreen_Width - 55) / 3 + 10) *list + 10, 81 + row * 45, (__MainScreen_Width - 55) / 3, 35);
                [btn setTitleColor:UIColorFromRGB(0X666666) forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.backgroundColor = [UIColor whiteColor];
                [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = row * 3 + list;
                [btn setTitle:self.dataArray[row *3 + list][@"areaName"] forState:UIControlStateNormal];
                [self addSubview:btn];
            }
        }
    }
}
#pragma mark - 按钮控件点击触发事件
- (void)buttonAction:(UIButton *)btn
{
//    NSLog(@"cheshi ---- %@",self.dataArray[btn.tag]);
    if (self.headerAction)
    {
        self.headerAction(self.dataArray[btn.tag][@"areaName"],self.dataArray[btn.tag][@"id"]);
    }
}

@end

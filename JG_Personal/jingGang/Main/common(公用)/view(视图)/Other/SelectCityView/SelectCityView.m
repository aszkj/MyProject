//
//  SelectCityView.m
//  jingGang
//
//  Created by 张康健 on 15/9/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SelectCityView.h"

@interface SelectCityView() {


}

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

@end

@implementation SelectCityView

- (IBAction)selectCityAction:(id)sender {
    
    if (self.selectCityActionBlock) {
        self.selectCityActionBlock();
    }
}


-(void)setCityName:(NSString *)cityName {
    
    //截取前三个字符
    if (cityName.length >= 3) {
        cityName = [cityName substringToIndex:2];
    }

    _cityName = cityName;
    self.cityLabel.text = _cityName;
}

@end

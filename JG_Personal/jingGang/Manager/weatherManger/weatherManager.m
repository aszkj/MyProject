//
//  weatherManager.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/13.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "weatherManager.h"

@interface weatherManager ()
{
    NSString *_cityID;//获取城市天气代码
}

@property (nonatomic, strong) NSMutableArray *cityNumData;//城市代码所有数据


@end

@implementation weatherManager
@synthesize delegate = m_delegate;

-(id)init
{
    self = [super init];
    if (self) {
        m_delegate = nil;
    }
    return self;
}
- (void)setLocationWithCity:(NSString *)city
{
    for (NSDictionary *dict in self.cityNumData) {
        if ([city rangeOfString:dict[@"cityName" ]].length > 0) {
            _cityID = dict[@"id"];
            return;
        }
    }
}

- (void)startRequestWithDelegate:(id)delegate
{
    
    NSString * cityNum = @"101280601";//北京－－101010100//贵阳－－101260101
    NSString *path = @"http://weather.123.duba.net/static/weather_info/cityNumber.html";
    //将城市代码替换到天气解析网址cityNumber 部分！
    if (_cityID) {
        path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:_cityID];
    }
    
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];

    __block weather * m_weather = [[weather alloc]init];
    m_delegate = delegate;

    WEAK_OBJECT(weak_m_delegate, m_delegate);

    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            if (weak_m_delegate && [weak_m_delegate respondsToSelector:@selector(DidFailWithError:)]) {
                [weak_m_delegate DidFailWithError:connectionError];
            }
        }else {
            NSString *jsonValue = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *array = [jsonValue componentsSeparatedByString:@"_callback"];
            NSString * jsonStr = [array lastObject];
            NSArray *array1 = [jsonStr componentsSeparatedByString:@"("];
            NSString * jsonStr1 = [array1 lastObject];
            NSArray *array2 = [jsonStr1 componentsSeparatedByString:@")"];
            NSString * jsonStr2 = [array2 firstObject];
            NSData *jsonData = [jsonStr2 dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:nil];
            m_weather.city = [[dic objectForKey:@"weatherinfo"] objectForKey:@"city"];
            
            NSString * temp = [[dic objectForKey:@"weatherinfo"] objectForKey:@"temp1"];
            NSArray  * max = [temp componentsSeparatedByString:@"℃~"];
            //        NSString * maxstr = [max firstObject];
            //        NSArray * array = [maxstr componentsSeparatedByString:@"℃"];
            m_weather.maxWeather = [max firstObject];
            m_weather.minWeather = [max lastObject];
            m_weather.weather    = [[dic objectForKey:@"weatherinfo"] objectForKey:@"weather1"];
            m_weather.pm     = [[dic objectForKey:@"weatherinfo"] objectForKey:@"pm"];
            m_weather.sd_num     = [[dic objectForKey:@"weatherinfo"] objectForKey:@"sd"];
            m_weather.pm_lev     = [[dic objectForKey:@"weatherinfo"] objectForKey:@"pm-level"];
            m_weather.wind       = [[dic objectForKey:@"weatherinfo"] objectForKey:@"wd"];
            m_weather.wind_lev   = [[dic objectForKey:@"weatherinfo"] objectForKey:@"wind1"];
            m_weather.st1        = dic[@"weatherinfo"][@"st1"];
            m_weather.pm_num     = dic[@"weatherinfo"][@"pm-num"];
            m_weather.pm_pubtime = dic[@"weatherinfo"][@"pm-pubtime"];
            if (weak_m_delegate && [weak_m_delegate respondsToSelector:@selector(DidFinishLoadingWithWeather:)])
            {
                [weak_m_delegate DidFinishLoadingWithWeather:m_weather];
            }
            
            RELEASE(jsonValue);

        }
    }];
    
}

- (NSMutableArray *)cityNumData
{
    if (_cityNumData == nil) {
        _cityNumData = [NSMutableArray array];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"weather" ofType:@"json"];
        NSData *weatherData = [NSData dataWithContentsOfFile:plistPath];
        NSDictionary *weatherDict = [NSJSONSerialization JSONObjectWithData:weatherData options:NSJSONReadingMutableLeaves error:nil];
        for (NSDictionary *dict in weatherDict[@"cityCode"]) {
            for (NSDictionary *dict1 in dict[@"city"]) {
                [_cityNumData addObject:dict1];
            }
        }
    }
    return  _cityNumData;
}


@end

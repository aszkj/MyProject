//
//  clockViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "clockViewController.h"
#import "PublicInfo.h"
#import "clockChildViewController.h"
#import "mydevieseViewController.h"
#import "LongTimeSeatingReminderVC.h"
#import "JGBlueToothManager.h"
#import "TMCache.h"
#import "GlobeObject.h"

@interface clockViewController ()
{
    UIScrollView   *_myScrollView;
    UILabel        * btn_lab;
    JGBlueToothManager *_jgBlueToothManager;
    
    TMCache         *_cache;
    
    NSMutableArray *drinkWaterArr;
    NSMutableArray *getAwakerArr;
    
}

@end

@implementation clockViewController

- (void)dealloc
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _cache = [TMCache sharedCache] ;
    
    [self _initDataCache];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myScrollView = [[UIScrollView alloc]init];
    _myScrollView.frame = self.view.frame;
    _myScrollView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self.view addSubview:_myScrollView];
    
    _jgBlueToothManager = [JGBlueToothManager shareInstances];
    

    
    float spase_x = 10;
    float spase_y = 10;
#pragma mark - 修改的
//    float weight = 300;
    float weight = kScreenWidth - spase_x * 2;
    float height = 115;
    UIColor * color1 = [UIColor colorWithRed:57.f/255.0f green:217.f/255.0f blue:174.f/255.0f alpha:1.0f];
    UIColor * color2 = [UIColor colorWithRed:90.f/255.0f green:196.f/255.0f blue:240.f/255.0f alpha:1.0f];
    UIColor * color3 = [UIColor colorWithRed:234.f/255.0f green:145.f/255.0f blue:145.f/255.0f alpha:1.0f];
    NSArray * color_array = [NSArray arrayWithObjects:color1,color2,color3, nil];
    NSArray * bg_img_array = [NSArray arrayWithObjects:@"home_water",@"home_up",@"home_sit", nil];
    NSArray * name_lab_array = [NSArray arrayWithObjects:@"喝水提醒",@"起床提醒",@"久坐提醒", nil];
    for (int i = 0; i < 3; i ++) {
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(spase_x, spase_y+i*(height+spase_y), weight, height);
        view.backgroundColor = [color_array objectAtIndex:i];
        view.layer.cornerRadius = 5;
        view.clipsToBounds = YES;
        [_myScrollView addSubview:view];

        UIImageView * bg_img = [[UIImageView alloc]init];
        if (i == 0) {
            bg_img.frame = CGRectMake(view.frame.size.width/2-19, view.frame.size.height/2-31, 38, 42);
        }else if (i == 1){
            bg_img.frame = CGRectMake(view.frame.size.width/2-28, view.frame.size.height/2-25, 56, 31);
        }else{
            bg_img.frame = CGRectMake(view.frame.size.width/2-21, view.frame.size.height/2-31, 42, 42);
        }
        bg_img.image = [UIImage imageNamed:[bg_img_array objectAtIndex:i]];
        [view addSubview:bg_img];

        
        UILabel * name_lab = [[UILabel alloc]init];
        name_lab.frame = CGRectMake(0, bg_img.frame.size.height+bg_img.frame.origin.y+15, view.frame.size.width, 20);
        name_lab.textColor = [UIColor whiteColor];
        name_lab.textAlignment = NSTextAlignmentCenter;
        name_lab.font = [UIFont systemFontOfSize:18];
        name_lab.text = [name_lab_array objectAtIndex:i];
        [view addSubview:name_lab];

        
        
        UIButton * btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        btn.tag = i+100;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];

        
        if (i == 2) {
            btn_lab = [[UILabel alloc]init];
            btn_lab.frame = CGRectMake(0, view.frame.size.height+view.frame.origin.y + 40, __MainScreen_Width, 30);
            if (_jgBlueToothManager.bangedPerialUUID && _jgBlueToothManager.bangedPerialID) {
                btn_lab.text = _jgBlueToothManager.bangedPerialID;
            }else{
            
                btn_lab.text = @"您还没有绑定设备，点击绑定";
                UIButton * binding_btn = [[UIButton alloc]initWithFrame:btn_lab.frame];
                binding_btn.tag = 500;
                binding_btn.backgroundColor = [UIColor clearColor];
                [binding_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_myScrollView addSubview:binding_btn];

            }
            
            
            btn_lab.textAlignment = NSTextAlignmentCenter;
            btn_lab.textColor = [UIColor lightGrayColor];
            [_myScrollView addSubview:btn_lab];

        }
    }
    
    if (__MainScreen_Height == 480) {
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height+100);
    }else{
        _myScrollView.contentSize = CGSizeMake(__MainScreen_Width, __MainScreen_Height);
    }
    
    

}




-(void)_initDataCache{
    
    //查询数据库
    drinkWaterArr = (NSMutableArray *)[_cache objectForKey:@"DrinKWater_Cache_key"];
    
    if (drinkWaterArr.count == 0) {
        drinkWaterArr = [NSMutableArray arrayWithCapacity:0] ;
    }

    getAwakerArr = (NSMutableArray *)[_cache objectForKey:@"GetAwake_Cache_key"];
    if (getAwakerArr.count == 0) {
        getAwakerArr = [NSMutableArray arrayWithCapacity:0] ;
    }

}



- (void)btnClick:(UIButton *)btn
{
    NSLog(@"btn.tag =－－－－ %ld",(long)btn.tag);
    if (btn.tag<200) {
        
        if (btn.tag == 100) {
            clockChildViewController * clockVc = [clockChildViewController instance];
            clockVc.name_str = @"喝水提醒";
//            if (drinkWaterArr.count == 0) {
//                
////                clockVc.clock_num_array = [NSMutableArray arrayWithObjects:@"12:30",@"14:30", nil];
//                clockVc.clock_num_array = [NSMutableArray arrayWithCapacity:0];
//            }else{
//            
//                clockVc.clock_num_array = drinkWaterArr;
//            }
            
            clockVc.clock_num_array = drinkWaterArr;
            
            
            [self.navigationController pushViewController:clockVc animated:YES];
        }else if (btn.tag == 101){
            clockChildViewController * clockVc = [clockChildViewController instance];
            clockVc.name_str = @"起床提醒";
//            if (getAwakerArr.count == 0) {
//                
////                clockVc.clock_num_array = [NSMutableArray arrayWithObjects:@"07:30",@"14:00",@"18:30", nil];
//                clockVc.clock_num_array = [NSMutableArray arrayWithCapacity:0];
//            }else{
//            
//                clockVc.clock_num_array = getAwakerArr;
//            }
            clockVc.clock_num_array = getAwakerArr;
            [self.navigationController pushViewController:clockVc animated:YES];
            
        }else if (btn.tag == 102){
            //久坐提醒
            LongTimeSeatingReminderVC *longTimeRMVC = [[LongTimeSeatingReminderVC alloc] init];
            [self.navigationController pushViewController:longTimeRMVC animated:YES];

            
        }
    }else{
        NSLog(@"正在绑定设备");
        mydevieseViewController * vc = [[mydevieseViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

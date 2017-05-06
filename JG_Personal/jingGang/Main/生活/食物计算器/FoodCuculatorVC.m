//
//  FoodCuculatorVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "FoodCuculatorVC.h"
#import "UIButton+Block.h"
#import "GlobeObject.h"

@interface FoodCuculatorVC ()
@property (weak, nonatomic) IBOutlet UILabel *kaluoLiLabel;

@end

@implementation FoodCuculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self _init];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
}


#pragma mark - private Method
-(void)_init{
    
    //self.zhengzhuangAllTableWidthConstraint.constant = __MainScreen_Width * 0.32;
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    NSInteger kaluoLiValue = [self.foodDic[@"calories"] integerValue];
    self.kaluoLiLabel.text = [NSString stringWithFormat:@"%ld卡",kaluoLiValue];
}




-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
       WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        [weak_self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
       RELEASE(navLeftButton);
    RELEASE(item);
}



-(void)_loadTitleView{
   
    
        self.title = @"食物计算器";
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                          NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
    
}




@end

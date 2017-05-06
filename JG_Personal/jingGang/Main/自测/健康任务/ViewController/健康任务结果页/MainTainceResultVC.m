//
//  MainTainceResultVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/16.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "MainTainceResultVC.h"
#import "UIButton+Block.h"
#import "VApiManager.h"
#import "GlobeObject.h"

@interface MainTainceResultVC ()
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@end

@implementation MainTainceResultVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self _loadNavLeft];
    
    [self _loadTitleView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
 
    //调用增加积分接口
    [self _addIntegralRequest];
}


#pragma mark - 调用增加积分接口
-(void)_addIntegralRequest {

    //调用增加积分接口
    VApiManager *vapManager = [[VApiManager alloc] init];
    SnsHealthTaskSaveRequest *request = [[SnsHealthTaskSaveRequest alloc] init:GetToken];
    request.api_integralType = @1;
    [vapManager snsHealthTaskSave:request success:^(AFHTTPRequestOperation *operation, SnsHealthTaskSaveResponse *response) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
        NSInteger integral = [dic[@"integral"] integerValue];
        self.integralLabel.text = [NSString stringWithFormat:@"%ld",integral];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
    }];
}

#pragma mark - 结束
- (IBAction)endAction:(id)sender {
    
    [self _comToTestHomePage];
    
}

- (IBAction)nextItem:(id)sender {
    

    [self _comToTestHomePage];
    //发送下一个任务的通知
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"K_next_task_Notification" object:@(self.smallTaskNum+1)];
    
}

-(void)_comToTestHomePage {
    
    if (self.navigationController.viewControllers.count >=2 ) {
        UIViewController *seconVC = (UIViewController *)self.navigationController.viewControllers[1];
        [self.navigationController popToViewController:seconVC animated:YES];
    }
}


-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        [weak_self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    RELEASE(navLeftButton);
    RELEASE(item);
}


-(void)_loadTitleView{
    
    //    [Util setTitleViewWithTitle:@"面部模型" andNav:self.navigationController];
    //    self.title = self.mainTainceTitle;
    self.title = @"任务完成";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
}




@end

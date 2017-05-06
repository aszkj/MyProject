//
//  SelftestDetailVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "SelftestDetailVC.h"
#import "UIButton+Block.h"
#import "H5page_URL.h"
#import "Util.h"
#import "SelfTestResultVC.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "GlobeObject.h"
#define BeginTest_relative_url @"/check/question"
#define TestDetail_relative_url @"/check/detail"


@interface SelftestDetailVC (){

    NSString *urlStr;

}
@property (retain, nonatomic) IBOutlet UIWebView *st_DetailWebView;

@property (retain, nonatomic) IBOutlet UIButton *beginTestBottonView;
@property (weak, nonatomic) IBOutlet UILabel *selfTestTitleLabel;

@end

@implementation SelftestDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
    [self _loadRequest];
    
    [self _initBottonView];
}


-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {

            [weak_self.navigationController popViewControllerAnimated:YES];
    }];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;
    
    RELEASE(navLeftButton);
    RELEASE(item);
}

-(void)_initBottonView{

    if (self.testDetailType == BeginTest_Type) {
        
        self.beginTestBottonView.hidden = YES;

    }else{
        self.beginTestBottonView.hidden = NO;
    }

    
}

-(void)_loadTitleView{
    
    NSString *title = nil;
    if (self.testDetailType == BeginTest_Type) {
        title = @"自测题";
    }else{
        title = @"自测题详情";
    }
    
    [Util setNavTitleWithTitle:title ofVC:self];
    self.selfTestTitleLabel.text = self.selfTestTitle;

}

-(void)_loadRequest{
    
//    NSString *urlStr = nil;
    if (self.testDetailType == BeginTest_Type) {//开始测试
        urlStr = [NSString stringWithFormat:@"%@%@?groupId=%ld",Base_URL,BeginTest_relative_url,self.self_Test_DetailID];
    }else{//测试详情
        urlStr = [NSString stringWithFormat:@"%@%@?groupId=%ld",Base_URL,TestDetail_relative_url,self.self_Test_DetailID];
    }
    

    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        
        [self.st_DetailWebView loadRequest:request];
    });
    
   
    if (self.testDetailType == BeginTest_Type) {//如果是测试页
        [self makeJSEvironment];
    }
    
}


-(void)makeJSEvironment{

    JSContext *context = [self.st_DetailWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"requstResult"] = ^() {
        
        NSLog(@"task completed");
        NSArray *args = [JSContext currentArguments];
        //传了两个参数，一个groupID,一个分数
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
#warning 注意，这里必须要切换到主线程进行切换UI,否则会崩溃，，因为这里是处于webThread环境
        dispatch_async(dispatch_get_main_queue(), ^{

            long test_mark = [[args[1] toNumber] longValue];
            long test_ID = [[args[0] toNumber] longValue];
            SelfTestResultVC *resultVC = [[SelfTestResultVC alloc] init];
            resultVC.test_Mark = test_mark;
            resultVC.test_GroupID = test_ID;
            resultVC.testUrl = urlStr;
            resultVC.retestBlock = ^(long groupID){
                //推出该控制器
                [self.navigationController popViewControllerAnimated:YES];
                
                //重新加载该控制器
                SelftestDetailVC *selfVC = [[SelftestDetailVC alloc] init];
                selfVC.self_Test_DetailID = groupID;
                
                [self.navigationController pushViewController:selfVC animated:NO];

                
            
            };//重新测试块
            
            resultVC.iknowBlock = ^{
            
                [self.navigationController popViewControllerAnimated:NO];
            
            };//回到自测题列表块
            
            [self.navigationController pushViewController:resultVC animated:YES];

        });
        
    };
    
}//创建js环境


- (IBAction)beginTest:(id)sender {
    UNLOGIN_HANDLE
    SelftestDetailVC *selfDeltaiVC = [[SelftestDetailVC alloc] init];
    selfDeltaiVC.self_Test_DetailID = self.self_Test_DetailID;
    selfDeltaiVC.testDetailType = BeginTest_Type;
    [self.navigationController pushViewController:selfDeltaiVC animated:YES];


}


@end

//
//  sucsessViewController.m
//  jingGang
//
//  Created by yi jiehuang on 15/6/24.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "sucsessViewController.h"
#import "PublicInfo.h"
#import "SVProgressHUD.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "questionViewController.h"
#import "GlobeObject.h"
#import "H5page_URL.h"

@interface sucsessViewController ()
{
    UIWebView   *  _myWeb_View;
}

@end

@implementation sucsessViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
    [self greatNav];
    [self greatUI];
//    [self makeJSEvironment];
}

- (void)greatNav
{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_title"] forBarMetrics:UIBarMetricsDefault];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, 44)];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"咨询";
    if (self.is_answer.length !=0) {
        titleLabel.text = @"问答详情";
    }
    self.navigationItem.titleView = titleLabel;
  
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backToMain) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
   
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0.0f, 16.0f, 40.0f, 25.0f)];
//    [rightBtn setTitle:@"回复" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightButton;
  

}

- (void)greatUI
{
    _myWeb_View = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreen_Height-4*__Other_Height-__StatusScreen_Height-44)];
    _myWeb_View.delegate = self;
    _myWeb_View.backgroundColor = [UIColor orangeColor];
    _myWeb_View.contentMode = UIViewContentModeCenter;
    _myWeb_View.backgroundColor = [UIColor clearColor];
    _myWeb_View.autoresizesSubviews = YES;
    _myWeb_View.userInteractionEnabled = YES;
    
    [self.view addSubview:_myWeb_View];
    
    UIButton * repayBtn = [[UIButton alloc]init];
    repayBtn.frame = CGRectMake(0, __MainScreen_Height-44-5.5*__Other_Height, __MainScreen_Width, 44);
    [repayBtn setBackgroundImage:[UIImage imageNamed:@"home_title"] forState:UIControlStateNormal];
    [repayBtn setTitle:@"立刻回复" forState:UIControlStateNormal];
    [repayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [repayBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repayBtn];

    
    NSLog(@"web 页面网址  －－－－－%@ ",self.Web_URL);
    NSURL *fileURL = [NSURL URLWithString:self.Web_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [_myWeb_View loadRequest:request];
    [self makeJSEvironment];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"正在加载web");
    [SVProgressHUD showInView:self.view status:@"努力加载中，请稍后..." networkIndicator:NO posY:-1 maskType:1];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showAlertViewWithStr:[NSString stringWithFormat:@"%@",error]];
    [SVProgressHUD dismiss];
}

static int tz_id;
-(void)makeJSEvironment{
    
    JSContext *context = [_myWeb_View valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"requestMoidfy"] = ^() {
        
        NSArray *args = [JSContext currentArguments];
        //传了两个参数，一个groupID,一个分数
        NSString * title_id = nil;
        for (JSValue *jsVal in args) {
            NSLog(@"zixun%@", jsVal);
            title_id = [NSString stringWithFormat:@"%@",jsVal];
            tz_id = [title_id intValue];
            NSLog(@"咨询帖子的id－－%d",tz_id);
        }
#warning 注意，这里必须要切换到主线程进行切换UI,否则会崩溃，，因为这里是处于webThread环境
        dispatch_async(dispatch_get_main_queue(), ^{
            questionViewController * questionVc = [[questionViewController alloc]init];
            questionVc.bar_title = @"修改提问";
            questionVc.title_ID = [NSString stringWithFormat:@"%@",title_id];
            questionVc.web_id = self.web_id;//继续传值给问题界面()
            NSLog(@"web_id == %@",self.web_id);
            questionVc.experts_id = self.experts_id;//专家id
            [self.navigationController pushViewController:questionVc animated:YES];

//            [self backToMain];
        });
        
    };
    
}//创建js环境

- (void)backToMain
{
    if (self.is_answer.length == 0) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }else{
        if (self.vc_str.length==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)rightBtnClick{
    questionViewController * questionVc = [[questionViewController alloc]init];
    questionVc.bar_title = @"新增回复";
    questionVc.is_answer = @"isAnswer";
    questionVc.title_ID = [NSString stringWithFormat:@"%@",self.web_id];
    [self.navigationController pushViewController:questionVc animated:YES];

}

-(void)showAlertViewWithStr:(NSString *)string
{
    UIAlertView * alertVc = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
    [alertVc show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

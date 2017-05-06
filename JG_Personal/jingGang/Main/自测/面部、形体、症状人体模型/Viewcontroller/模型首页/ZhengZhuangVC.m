//
//  ZhengZhuangVC.m
//  jingGang
//
//  Created by 张康健 on 15/6/4.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ZhengZhuangVC.h"
#import "H5page_URL.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIButton+Block.h"
#import "AppDelegate.h"
#import "GlobeObject.h"
#import "PublicInfo.h"
#import "Util.h"
#import "ZhengZhuangListVC.h"
#import "ZongHeZhengVC.h"
#import "LeftRightView.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "testchildViewController.h"
#import "JGFaceClickWebController.h"
#import "JGFaceManViewController.h"

typedef enum : NSUInteger {
    Gender_Man_type,
    Gener_Women_type,
}CurrentGenderType;//当前的模型性别

typedef void(^PushFaceBlock)(void);

@interface ZhengZhuangVC ()<UIWebViewDelegate>{
    
    BOOL _showList;

}
@property (retain, nonatomic) IBOutlet UIButton *girlButton;
@property (retain, nonatomic) IBOutlet UIButton *manButton;
@property (retain, nonatomic) IBOutlet NSLayoutConstraint *sliderToleftConstraint;
@property (retain, nonatomic) IBOutlet UIView *sliderBar;
@property (nonatomic,strong)NSArray *tabbuttonArr;

//当前性别模型
@property (nonatomic,assign)CurrentGenderType zz_currentGenderType;
@property (retain, nonatomic) IBOutlet UIWebView *zz_Man_Model_WebView;
@property (retain, nonatomic) IBOutlet UIWebView *zz_Women_Model_WebView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *topBarView;

@property (nonatomic,assign)BOOL zz_women_webView_is_load;

@property (nonatomic, strong)LeftRightView *listView;

@property (copy , nonatomic) PushFaceBlock pushFaceBlock;

@property (assign,nonatomic) NSInteger tag;


@end

@implementation ZhengZhuangVC

- (instancetype)initWithFaceWebPush:(void (^)())pushFace {
    if (self = [super init]) {
        self.pushFaceBlock = pushFace;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tabbuttonArr = @[self.girlButton,self.manButton] ;
    
    [self _init];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
    //初始化webView 与js 的桥接
    [self _initWithWebviewJsBridge:self.zz_Man_Model_WebView];
    [self _initWithWebviewJsBridge:self.zz_Women_Model_WebView];
    
    //设置开始默认加载模型url,默认女生
    self.zz_currentGenderType = Gener_Women_type;
    if (self.zz_ModelType == Face_Model_type) {//面部模型
        self.zz_ModelHtmlUrl = Face_Women_H5;
    }else if (self.zz_ModelType == Body_Model_Type){//身体模型
        self.zz_ModelHtmlUrl = Body_Women_H5;
    }else if (self.zz_ModelType == Figure_Model_type){//形体模型
        self.zz_ModelHtmlUrl = Figure_Women_H5;
    }
    //加载默认请求,男性
    [self _loadRequestWiithWebView:self.zz_Man_Model_WebView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self _init];
    
    [self _loadNavLeft];
    
    [self _loadTitleView];
    
    //初始化webView 与js 的桥接
    [self _initWithWebviewJsBridge:self.zz_Man_Model_WebView];
    [self _initWithWebviewJsBridge:self.zz_Women_Model_WebView];
    
    //设置开始默认加载模型url,默认女生
    self.zz_currentGenderType = Gener_Women_type;
    if (self.zz_ModelType == Face_Model_type) {//面部模型
        self.zz_ModelHtmlUrl = Face_Women_H5;
    }else if (self.zz_ModelType == Body_Model_Type){//身体模型
        self.zz_ModelHtmlUrl = Body_Women_H5;
    }else if (self.zz_ModelType == Figure_Model_type){//形体模型
        self.zz_ModelHtmlUrl = Figure_Women_H5;
    }
    //加载默认请求,男性
    if(self.tag == 1){
         [self _loadRequestWiithWebView:self.zz_Women_Model_WebView];
    }
    else if (self.tag ==2){
        [self _loadRequestWiithWebView:self.zz_Man_Model_WebView];
    }
}
-(UIButton *)getSeletedButton{
    
    for (UIButton *button in _tabbuttonArr) {
        if (button.selected) {
            return button;
            break;
        }
    }
    return nil;
}//得到之前选中的tabbutton

-(void)_loadNavLeft{
    
    UIButton *navLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    [navLeftButton setBackgroundImage:[UIImage imageNamed:@"navigationBarBack"] forState:UIControlStateNormal];
    WEAK_SELF;
    [navLeftButton addActionHandler:^(NSInteger tag) {
        
//        [weak_self dismissViewControllerAnimated:YES completion:nil];
        [weak_self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:navLeftButton];
    self.navigationItem.leftBarButtonItem = item;

    
}
- (void) leftClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)_init{

    self.zz_women_webView_is_load = NO;
    self.navigationController.navigationBar.barTintColor = kGetColor(94, 180, 231);
    _showList = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
#pragma mark - FOURTH
    if (self.zz_ModelType == Body_Model_Type || self.zz_ModelType == Figure_Model_type) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"列表" titleColor:[UIColor whiteColor] target:self action:@selector(qiehuan)];
    }
}

-(void)_initWithWebviewJsBridge:(UIWebView *)webView{
 
    webView.delegate = self;
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    NSString *methodNameStr = nil;
    if ( self.zz_ModelType == Figure_Model_type||self.zz_ModelType == Face_Model_type) {
        methodNameStr = @"requestCategory";
    }else if (self.zz_ModelType == Body_Model_Type ){
        methodNameStr = @"requestCategoryBody";
    }
    
    context[@"requestFace"] = ^(){
        NSArray *args = [JSContext currentArguments];
        JSValue *value = args[0];
        long longValue = value.toNumber.longLongValue;
        
//        [self.navigationController popViewControllerAnimated:YES];
//        BLOCK_EXEC(self.pushFaceBlock);
        if(longValue == 1){
            JGFaceClickWebController *web = [[JGFaceClickWebController alloc] initWithType:longValue];
            self.tag = 1;
            [self.navigationController pushViewController:web animated:NO];
        }
        else {
            JGFaceManViewController *faceMan = [[JGFaceManViewController alloc] initWithType:longValue];
            self.tag = 2;
            [self.navigationController pushViewController:faceMan animated:NO];
        }
//        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.jgyes.cn/static/app/faceLady.jsp"]]];
    };

    
    
    JGLog(@"methodNameStr:%@",methodNameStr);
    context[methodNameStr] = ^() {
        NSLog(@"face Click");
        NSArray *args = [JSContext currentArguments];
        JSValue *value = args[0];
        NSLog(@"value : %ld",value.toNumber.longValue);
        [self clickToDefentVCWithID:[value toNumber]];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
    };
    
    context[@"figureCalculater"] = ^() {
        
        NSLog(@"点击形体");
        testchildViewController * testChildVc = [[testchildViewController alloc]init];
        [self.navigationController pushViewController:testChildVc animated:YES];
    };
//    context[@"requestFace"] = ^(){
//        NSArray *args = [JSContext currentArguments];
//        JSValue *value = args[0];
//         self.zz_ModelType = Face_Model_type;
//        if([[value toNumber] isEqual:@1]){
//            self.zz_currentGenderType = Gener_Women_type;
//            [self _loadRequestWiithWebView:self.zz_Women_Model_WebView];
//        }
//        else {
//            self.zz_currentGenderType = Gender_Man_type;
//            [self _loadRequestWiithWebView:self.zz_Man_Model_WebView];
//        }
//        
////       [self _leiXinDeal];
//        
//        
//    };
    context[@"requestSkin"] = ^(){
        ZongHeZhengVC *zongheZhenVC =  [[ZongHeZhengVC alloc] init];
        //皮肤
        zongheZhenVC.selfTestTiID = @4000;
        zongheZhenVC.comminType = Commin_From_Skin;
        [self.navigationController pushViewController:zongheZhenVC animated:YES];
    };
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"request %@",request.URL.absoluteString);

    return YES;

}


-(void)_loadTitleView{
    

    if (self.zz_ModelType == Body_Model_Type) {

        [Util setNavTitleWithTitle:@"症状" ofVC:self];
        
    }else if (self.zz_ModelType == Face_Model_type){
        
        [Util setNavTitleWithTitle:@"面部模型" ofVC:self];
        
    }else if (self.zz_ModelType == Figure_Model_type) {
    
        [Util setNavTitleWithTitle:@"形体" ofVC:self];
    }

}

- (void)qiehuan {
    
    if (!_showList) {//点之前显示的是model,隐藏模型,显示list
        if (!self.listView.hasShow) {
            [self.listView show];
        }else {
            self.listView.hidden = NO;

        }
        [self showHiddenModelSubViewIsHidden:YES];
        
    }else {//和上相反,显示模型,隐藏list
        self.listView.hidden = YES;
        [self showHiddenModelSubViewIsHidden:NO];
        //当前状态，隐藏相应模型
        [self hiddenTheWebAccordingTheState];
    }
    _showList = !_showList;
}

-(void)hiddenTheWebAccordingTheState{

    //这里是反的，manwebview用到了女士类型，
    if (self.zz_currentGenderType == Gener_Women_type) {
        self.zz_Women_Model_WebView.hidden = YES;
    }else {
        self.zz_Man_Model_WebView.hidden = YES;
    }
    
}


-(void)showHiddenModelSubViewIsHidden:(BOOL)isHidden {

    self.topView.hidden = isHidden;
    self.topBarView.hidden = isHidden;
    self.zz_Man_Model_WebView.hidden = isHidden;
    self.zz_Women_Model_WebView.hidden = isHidden;
    
}


#pragma mark - 推到不同页面
-(void)clickToDefentVCWithID:(NSNumber *)ID{
    
    if (self.zz_ModelType == Face_Model_type || self.zz_ModelType == Figure_Model_type) {
        //推到面部症状列表
        ZhengZhuangListVC *zhengZhuangListVC = [[ZhengZhuangListVC alloc] init];
        zhengZhuangListVC.fen_lie_ID = [ID longValue];
        
        if (self.zz_ModelType == Face_Model_type) {
            zhengZhuangListVC.comminType  = FACE_CLICK_COMIN;
        }else if (self.zz_ModelType == Figure_Model_type) {
            zhengZhuangListVC.comminType  = FIGURE_CLICK_COMIN;
        }
        
        if ( self.zz_Man_Model_WebView.hidden) {
            zhengZhuangListVC.faceClickType = FACE_CLICK_MAN;
        }else{
            zhengZhuangListVC.faceClickType = FACE_CLICK_WOMEN;
        }
        [self.navigationController pushViewController:zhengZhuangListVC animated:YES];
        

    }else if (self.zz_ModelType == Body_Model_Type){
        //推到自测题，综合征
        ZongHeZhengVC *zongHeZhengVC = [[ZongHeZhengVC alloc] init];
        zongHeZhengVC.selfTestTiID = ID;
        zongHeZhengVC.comminType = Commin_From_Body;
        [self.navigationController pushViewController:zongHeZhengVC animated:YES];

        
    }
    
}



- (IBAction)buttonClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    UIButton *lastSeletedButton = [self getSeletedButton];
    if (button.selected) {//如果本身选中，返回
        return;
    }
    button.selected = YES;
    lastSeletedButton.selected = NO;
    
    
    //重新请求
    if (!self.zz_women_webView_is_load) {//第一次加载女的
        
        //第一次点击，配置模型类型，url类型
        [self _leiXinDeal];
    
        [self _loadRequestWiithWebView:self.zz_Women_Model_WebView];
        self.zz_women_webView_is_load = YES;
        self.zz_Women_Model_WebView.hidden = NO;
        self.zz_Man_Model_WebView.hidden = YES;
        //这里本身是womenType,后来两个webview对调了，所以反的
        self.zz_currentGenderType = Gender_Man_type;
        
    }else{
        
        if (self.zz_Man_Model_WebView.hidden == NO) {
            self.zz_Man_Model_WebView.hidden = YES;
            self.zz_Women_Model_WebView.hidden = NO;
            self.zz_currentGenderType = Gender_Man_type;
        }else{
            self.zz_Man_Model_WebView.hidden = NO;
            self.zz_Women_Model_WebView.hidden = YES;
            self.zz_currentGenderType = Gener_Women_type;
        }
        
    }

    
    [UIView animateWithDuration:0.2 animations:^{
        //sliderBar移动
        self.sliderToleftConstraint.constant = button.frame.origin.x;
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - 第一次点击，配置模型类型，url类型
-(void)_leiXinDeal{
    
    if (self.zz_currentGenderType == Gender_Man_type) {//男的
        self.zz_currentGenderType = Gener_Women_type;
        if (self.zz_ModelType == Face_Model_type) {//面部
            self.zz_ModelHtmlUrl = Face_Women_H5;
        }else if (self.zz_ModelType == Body_Model_Type){//身体
            self.zz_ModelHtmlUrl = Body_Women_H5;
        }else if (self.zz_ModelType == Figure_Model_type){
            self.zz_ModelHtmlUrl = Figure_Women_H5;
        }
        
    }else{//女的
        self.zz_currentGenderType = Gender_Man_type;
        if (self.zz_ModelType == Face_Model_type) {//面部
            self.zz_ModelHtmlUrl = Face_Man_H5;
        }else if (self.zz_ModelType == Body_Model_Type){//身体
            self.zz_ModelHtmlUrl = Body_Man_H5;
        }else if (self.zz_ModelType == Figure_Model_type){
            self.zz_ModelHtmlUrl = Figure_Man_H5;
        }
        
    }

}


-(void)_loadRequestWiithWebView:(UIWebView *)webView{
    
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://static.jgyes.com/static/app/face.jsp"]];
    
//    self.zz_ModelHtmlUrl = @"http://static.jgyes.cn/static/app/faceLady.jsp";
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.zz_ModelHtmlUrl]];
    [webView loadRequest:request];
    
}

#pragma mark - getter Method
-(LeftRightView *)listView {

    if (!_listView) {
        _listView = [[LeftRightView alloc] initWithFenlieID:5 frame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _listView.listType = self.listType;
        [self.view addSubview:_listView];
    }
    return _listView;
}



@end

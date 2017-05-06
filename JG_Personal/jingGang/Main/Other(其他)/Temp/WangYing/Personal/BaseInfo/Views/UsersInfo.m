//
//  UsersInfo.m
//  jingGang
//
//  Created by wangying on 15/6/2.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UsersInfo.h"
#import "VApiManager.h"
#import "userDefaultManager.h"
#import "PublicInfo.h"
#import "CalenderView.h"
#import "UIViewExt.h"
#import "Util.h"
#import "UIView+BlockGesture.h"
@interface UsersInfo ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate, UIScrollViewDelegate,UIActionSheetDelegate>
{
    VApiManager *_VApManager;
    NSMutableArray *arr;
    NSArray *arr_dataBlool;
    
    NSMutableArray *arr1;
    NSMutableArray *arr2;
    NSMutableArray *arr0;
    
    NSString *str;
    NSString *str2;
    NSString *str3;
    
    UIView *viewss;
    UIPickerView  *_year ;
    
    UIView *bloodView;
    BOOL isclick;
    UITextField *blood_text;
   // UITextField *data_text;
    UIButton *btnClicks;
    
    NSDictionary *dictss;//数据
    
    CalenderView *_calenderView; //日历视图
    BOOL _isSelectBirth; //是否选择
    UIView *_maskView;
    
    UILabel *sex_n;//性别label

}

//@property(nonatomic,strong)UIPickerView *year;
@end
@implementation UsersInfo


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.1];
        arr = [[NSMutableArray alloc]init];
        
       
        arr0 = [[NSMutableArray alloc]init];
        arr1 = [[NSMutableArray alloc]init];
        arr2 = [[NSMutableArray alloc]init];
        
        dictss = [[NSUserDefaults standardUserDefaults]objectForKey:@"arr_list"];
        
//        [self loadCalenderView];
        
    }
    return self;
}


//-(void)requestUsersInfo

//血型选择
-(void)bloodSelect
{
    arr_dataBlool = @[@"A",@"B",@"AB",@"O"];
    bloodView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 440, 40, 120)];
    [_scroll_other addSubview:bloodView];
    CGFloat widthss = 40;
    CGFloat heightss = 30;
    for (int i = 0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*heightss, widthss, heightss)];
        [btn setTitle:arr_dataBlool[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i;
       // btn.backgroundColor =[UIColor yellowColor];
        [btn addTarget:self action:@selector(btnssClcik:) forControlEvents:UIControlEventTouchUpInside];
        [bloodView addSubview:btn];
    }
   //bloodView.hidden = NO;
    bloodView.backgroundColor = [UIColor whiteColor];
}


-(void)SelectDarthCalender
{

    _isSelectBirth = NO;
    
    //遮罩视图
    [self loadMaskView];
    //日历视图
    [self loadCalenderView];
}

-(void)loadCalenderView{
    
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"CalenderView" owner:nil options:nil];
    _calenderView = (CalenderView *)[nibs lastObject];
    _calenderView.backgroundColor = [UIColor redColor];
    _calenderView.selectBirthBlock = ^(NSString *year,NSString *month,NSString *day){

        NSString *strBirth = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
//      
//        if ([strBirth containsString:@"00"]) {
//            strBirth = @"1915-1-1";
//        }
        
        [btnClicks setTitle:strBirth forState:UIControlStateNormal];
        self.birthDayStr = strBirth;
       
       [[NSUserDefaults standardUserDefaults] setValue:strBirth  forKey:@"birthdate"];
        
        bloodView.hidden = YES;
    //    [[NSUserDefaults standardUserDefaults]synchronize];
        
      //  NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"birthDate"]);
        [self downCalenderView];
    };
    //-200
    _calenderView.frame = CGRectMake(0,self.frame.size.height,self.frame.size.width, 292);//292
    [self addSubview:_calenderView];
    
    [self _setCalenderDefaulSelectedRow];
}

-(void)_setCalenderDefaulSelectedRow{
    NSArray *birthArr = [self.birthDayStr componentsSeparatedByString:@"-"];
//    NSLog(@"birth Arr - %@",birthArr);
    NSInteger yearNum = [birthArr[0] integerValue];
    NSInteger monthNum = [birthArr[1] integerValue];
    NSInteger dayNum = [birthArr[2] integerValue];
    
//    NSLog(@"year : %ld month : %ld day : %ld",yearNum,monthNum,dayNum);
    
    [_calenderView setSelectedRowWithYearNum:yearNum monthNum:monthNum dayNum:dayNum];
}

-(void)loadMaskView{
    
    _maskView = [[UIView alloc] initWithFrame:self.bounds];
    _maskView.alpha = 0.3;
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.hidden = YES;
    WEAK_SELF
    [_maskView addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
      
        [weak_self downCalenderView];
        
    }];
    [self addSubview:_maskView];
}

-(void)downCalenderView{
    
    [UIView animateWithDuration:0.2 animations:^{
        _maskView.hidden = YES;
        _calenderView.top = self.frame.size.height;
        _isSelectBirth = NO;
        //self.frame.size.height
    }];
}

-(void)upCalenderView{
    
    [UIView animateWithDuration:0.2 animations:^{
        _calenderView.bottom = self.frame.size.height-60;
        _maskView.hidden = NO;
        _isSelectBirth = YES;
    }];
    
}//往上


-(void)creatUI
{
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"nickName"] forKey:@"nickname"];
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"name"] forKey:@"name"];
    
    [[NSUserDefaults standardUserDefaults]setObject:[dictss objectForKey:@"weight"] forKey:@"weight"];
     [[NSUserDefaults standardUserDefaults]setValue:[dictss objectForKey:@"sex"] forKey:@"sex"];
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"height"] forKey:@"height"];
   // [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"birthDate"] forKey:@"birthDate"];
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"allergicHistory"] forKey:@"allergHistory"];
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"transHistory"] forKey:@"transHistory"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"transGenetic"] forKey:@"transGenetic"];
    [[NSUserDefaults standardUserDefaults] setValue:[dictss objectForKey:@"email"] forKey:@"email"];
    [[NSUserDefaults standardUserDefaults]setObject:[dictss objectForKey:@"blood"] forKey:@"blood"];
   
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _scroll_other = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scroll_other.contentSize = CGSizeMake(_scroll_other.frame.size.width, _scroll_other.frame.size.height+320 +40);
    _scroll_other.userInteractionEnabled = YES;
    _scroll_other.delegate = self;
    
    
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endediteText)];
    [_scroll_other addGestureRecognizer:taps];
    [self addSubview:_scroll_other];
    
    //邀请码
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, 44)];
    view0.backgroundColor = [UIColor whiteColor];
    UILabel *yaoqing = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 53, 44)];
    yaoqing.text = @"邀请码:";
    yaoqing.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    yaoqing.font = [UIFont systemFontOfSize:14];
    UITextField *yaoqingText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yaoqing.frame) +3, 0, 150, 44)];
    yaoqingText.text = [dictss objectForKey:@"invitationCode"] ? [dictss objectForKey:@"invitationCode"]:@"无";
    yaoqingText.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    yaoqingText.enabled = NO;
    yaoqingText.font = [UIFont systemFontOfSize:14];
    [view0 addSubview:yaoqing];
    [view0 addSubview:yaoqingText];
    [_scroll_other addSubview:view0];
    
    
    //手机号码 邮箱
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view0.frame) + 12, self.frame.size.width, 44)];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 62, 44)];
    phone.text = @"手机号码:";
    phone.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    phone.font = [UIFont systemFontOfSize:14];
    UITextField *PhText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phone.frame) +3, 0, 150, 44)];
    PhText.text = [dictss objectForKey:@"mobile"];
    PhText.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    PhText.enabled = NO;
    PhText.font = [UIFont systemFontOfSize:14];
    [view1 addSubview:phone];
    [view1 addSubview:PhText];
    [_scroll_other addSubview:view1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame) + 1, self.frame.size.width, 44)];
    view2.backgroundColor = [UIColor whiteColor];
    UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 33, 44)];
    email.text = @"邮箱:";
    email.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    email.font = [UIFont systemFontOfSize:14];
    UITextField *emText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(email.frame)+3, 0, 150, 44)];
    emText.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    emText.text = [dictss objectForKey:@"email"];
    self.emailStr = emText.text;
  //  emText.enabled = NO;
    emText.tag = 1023;
//    [emText addTarget:self action:@selector(textEditing:) forControlEvents:UIControlEventEditingChanged];
    emText.delegate = self;
    emText.font = [UIFont systemFontOfSize:14];
    [view2 addSubview:email];
    [view2 addSubview:emText];
    [_scroll_other addSubview:view2];
    
    
    
    UIView *n_name_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame) + 1, self.frame.size.width, 44)];
    n_name_view.backgroundColor = [UIColor whiteColor];
    UILabel *n_name_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
    n_name_l.text = @"昵称:";
    n_name_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    n_name_l.font = [UIFont systemFontOfSize:14];
    UITextField *n_name_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(n_name_l.frame) +3, 0, 150, 44)];
   // n_name_text.text = @"1342033333";
    n_name_text.text = [dictss objectForKey:@"nickName"];
    self.nickName = n_name_text.text;
    n_name_text.tag = 200;
//    [n_name_text addTarget:self action:@selector(textEditing:) forControlEvents:UIControlEventEditingChanged];
    n_name_text.delegate = self;
    n_name_text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
   // n_name_text.enabled = NO;
    n_name_text.font = [UIFont systemFontOfSize:14];
    [n_name_view addSubview:n_name_l];
    [n_name_view addSubview:n_name_text];
    [_scroll_other addSubview:n_name_view];
    
    
    
    UIView *name_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(n_name_view.frame)+ 1, self.frame.size.width, 44)];
    name_view.backgroundColor = [UIColor whiteColor];
    UILabel *name_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
    name_l.text = @"姓名:";
    name_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    name_l.font = [UIFont systemFontOfSize:14];
    UITextField *name_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(name_l.frame) +3, 0, 150, 44)];
    name_text.placeholder = @"请输入姓名";

    name_text.text = [dictss objectForKey:@"name"];
    self.name = name_text.text;
   // }
    name_text.delegate = self;
    name_text.tag = 201;
//    [name_text addTarget:self action:@selector(textEditing:) forControlEvents:UIControlEventEditingChanged];
   
    name_text.font = [UIFont systemFontOfSize:14];
    [name_view addSubview:name_l];
    [name_view addSubview:name_text];
    [_scroll_other addSubview:name_view];
    
      NSNumber *sexs = [dictss objectForKey:@"sex"];
    UIView *sex_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(name_view.frame) + 1, self.frame.size.width, 44)];
    sex_view.backgroundColor = [UIColor whiteColor];
    UILabel *sex_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 42)];
    sex_l.text = @"性别:";
    sex_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    sex_l.font = [UIFont systemFontOfSize:14];
    [sex_view addSubview:sex_l];

    sex_n = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sex_l.frame)+8, 0, 40, 42)];
    sex_n.text = @"男";
    sex_n.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    sex_n.font = [UIFont systemFontOfSize:14];
    [sex_view addSubview:sex_n];
    
    
    WEAK_SELF
    [sex_view addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
       
        UIActionSheet *sexSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weak_self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",nil];
        sexSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        sexSheet.tag = 1;
        [weak_self addSubview:sexSheet];
        [sexSheet showInView:weak_self];

        
    }];
    
    
    if ([sexs intValue] == 1) {//man
        sex_n.text = @"男";
    }
    else{
        sex_n.text = @"女";
        
    }
    
    [_scroll_other addSubview:sex_view];
    
    //手机号码 邮箱
    UIView *hegiht_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(sex_view.frame) +1 , self.frame.size.width, 44)];
    hegiht_view.backgroundColor = [UIColor whiteColor];
    UILabel *height_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
    height_l.text = @"身高:";
    height_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    height_l.font = [UIFont systemFontOfSize:14];
    UITextField *hegiht_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(height_l.frame) +3, 0, 150, 42)];
    hegiht_text.tag = 203;
    hegiht_text.keyboardType = UIKeyboardTypeNumberPad;
    if ([dictss objectForKey:@"height"]) {
        
        hegiht_text.text = [NSString stringWithFormat:@"%@",[dictss objectForKey:@"height"]];
        self.heightStr = hegiht_text.text;
    }
    
    hegiht_text.delegate = self;
    hegiht_text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hegiht_text.font = [UIFont systemFontOfSize:14];
    [hegiht_view addSubview:height_l];
    [hegiht_view addSubview:hegiht_text];
    [_scroll_other addSubview:hegiht_view];
    
    
    UIView *weight_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hegiht_view.frame) +1, self.frame.size.width, 44)];
    weight_view.backgroundColor = [UIColor whiteColor];
    UILabel *weight_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
    weight_l.text = @"体重:";
    weight_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    weight_l.font = [UIFont systemFontOfSize:14];
    UITextField *weight_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(weight_l.frame) +3, 0, 150, 42)];
    weight_text.keyboardType = UIKeyboardTypeDecimalPad;
    if ([dictss objectForKey:@"weight"]) {
        
          weight_text.text = [NSString stringWithFormat:@"%@",[dictss objectForKey:@"weight"]];
          self.weightStr = weight_text.text;
    }
    
    weight_text.delegate = self;
    weight_text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    weight_text.tag  = 204;
    weight_text.font = [UIFont systemFontOfSize:14];
    [weight_view addSubview:weight_l];
    [weight_view addSubview:weight_text];

    [_scroll_other addSubview:weight_view];
    
    UIView *data_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(weight_view.frame) +1, self.frame.size.width, 44)];
    data_view.backgroundColor = [UIColor whiteColor];
    UILabel *data_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
    
    data_l.text = @"生日:";
    data_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    data_l.font = [UIFont systemFontOfSize:14];
    btnClicks = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(data_l.frame) +3, 0, 150, 42)];
    btnClicks.titleLabel.textAlignment = NSTextAlignmentLeft;
    btnClicks.titleLabel.font = [UIFont systemFontOfSize:14];
    [btnClicks setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.7] forState:UIControlStateNormal];
    [btnClicks setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:@"birthdate"] forState:UIControlStateNormal];
    self.birthDayStr = btnClicks.titleLabel.text;
    
    [btnClicks addTarget:self action:@selector(BtnCLicksss) forControlEvents:UIControlEventTouchUpInside];
    
    [data_view addSubview:data_l];
   
   [data_view addSubview:btnClicks];
    
    [_scroll_other addSubview:data_view];
    
    
    UIView *blood_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(data_view.frame) +1, self.frame.size.width, 44)];
    blood_view.backgroundColor = [UIColor whiteColor];
    UILabel *blood_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 44)];
    blood_l.text = @"血型:";
    blood_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    blood_l.font = [UIFont systemFontOfSize:14];
    blood_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blood_l.frame) +3, 0, 100, 42)];
    blood_text.text = [dictss objectForKey:@"blood"];
    blood_text.tag = 900;
    blood_text.delegate = self;
    blood_text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    blood_text.enabled = NO;
    blood_text.delegate = self;
    blood_text.font = [UIFont systemFontOfSize:14];
    [blood_view addSubview:blood_l];
    [blood_view addSubview:blood_text];
    blood_view.userInteractionEnabled = YES;
    [blood_view addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        UIActionSheet *bloodSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weak_self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"A",@"B",@"AB",@"O",nil];
        bloodSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        bloodSheet.tag = 2;
        [weak_self addSubview:bloodSheet];
        [bloodSheet showInView:weak_self];
        
    }];
    
    
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-30, 15, 10, 10)];
    img.image = [UIImage imageNamed:@"per_arr_down"];
    img.userInteractionEnabled  = YES;

    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-80,0 , 80, 40)];
    imageView.center = img.center;
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelect)];
    [imageView addGestureRecognizer:tap];
    [blood_view addSubview:imageView];
    [_scroll_other addSubview:blood_view];
    
    
    //TODO:我的注册人
    UIView *zhuceView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(blood_view.frame)+1, self.frame.size.width, 44)];
    zhuceView.backgroundColor = [UIColor whiteColor];
    [_scroll_other addSubview:zhuceView];
    UILabel *zhuce_label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 188, 44)];
    zhuce_label.text = [NSString stringWithFormat:@"您的注册人: %@",[dictss objectForKey:@"referee"] ? [dictss objectForKey:@"referee"]:@"无"];
    zhuce_label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    zhuce_label.font = [UIFont systemFontOfSize:14];
    [zhuceView addSubview:zhuce_label];
    
    
    //TODO:隶属商户
    UIView *lishuView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(zhuceView.frame)+1, self.frame.size.width, 44)];
    lishuView.backgroundColor = [UIColor whiteColor];
    [_scroll_other addSubview:lishuView];
    UILabel *lishu_label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 188, 44)];
    lishu_label.text = [NSString stringWithFormat:@"隶属商户: %@",[dictss objectForKey:@"merchant"] ? [dictss objectForKey:@"merchant"]:@"无"];
    lishu_label.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    lishu_label.font = [UIFont systemFontOfSize:14];
    [lishuView addSubview:lishu_label];
    
    
    
    UIView *med_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lishuView.frame) + 12, self.frame.size.width, 44)];
    med_view.backgroundColor = [UIColor whiteColor];
    UILabel *med_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 88, 44)];
    med_l.text = @"药物过敏史:";
    med_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    med_l.font = [UIFont systemFontOfSize:14];
    UITextField *med_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(med_l.frame) +3, 0, 200, 42)];
     med_text.text = [dictss objectForKey:@"allergicHistory"];
    med_text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    med_text.tag = 206;
//    [med_text addTarget:self action:@selector(textEditing:) forControlEvents:UIControlEventEditingChanged];
//    

    // med_text.enabled = NO;
    med_text.delegate = self;
    med_text.font = [UIFont systemFontOfSize:14];
    [med_view addSubview:med_l];
    [med_view addSubview:med_text];
    [_scroll_other addSubview:med_view];
    
    
    
    UIView *hom_view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(med_view.frame) + 1, self.frame.size.width, 44)];
    hom_view.backgroundColor = [UIColor whiteColor];
    UILabel *hom_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 110, 44)];
    hom_l.text = @"家族药物过敏史:";
    hom_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hom_l.font = [UIFont systemFontOfSize:14];
    UITextField *hom_text = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hom_l.frame) +3, 0, 150, 42)];
     hom_text.text = [dictss objectForKey:@"transHistory"];
    hom_text.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hom_text.tag = 207;
//    [hom_text addTarget:self action:@selector(textEditing:) forControlEvents:UIControlEventEditingChanged];
    //hom_text.enabled = NO;
    hom_text.delegate = self;
    hom_text.font = [UIFont systemFontOfSize:14];
    [hom_view addSubview:hom_l];
    [hom_view addSubview:hom_text];
    [_scroll_other addSubview:hom_view];
    
    
    
    UIView *gen_v = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(hom_view.frame) + 1, self.frame.size.width, 44)];
    gen_v.backgroundColor = [UIColor whiteColor];
    UILabel *gen_l = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 90, 44)];
    gen_l.text = @"家族遗传病史:";
    gen_l.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    gen_l.font = [UIFont systemFontOfSize:14];
    UITextField *gen_t = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(gen_l.frame) +3, 0, 200, 42)];
    gen_t.text = [dictss objectForKey:@"transGenetic"];
    gen_t.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    // gen_t.enabled = NO;
    gen_t.delegate = self;
    gen_t.tag = 208;
//   [gen_t addTarget:self action:@selector(textEditing:) forControlEvents:UIControlEventEditingChanged];
    gen_t.font = [UIFont systemFontOfSize:14];
    [gen_v addSubview:gen_l];
    [gen_v addSubview:gen_t];
    [_scroll_other addSubview:gen_v];

    RELEASE(phone);
    RELEASE(PhText);
    RELEASE(view1);
    RELEASE(email);
    RELEASE(emText);
    RELEASE(view2);
    RELEASE(n_name_l);
    RELEASE(n_name_text);
    RELEASE(n_name_view);
    RELEASE(name_l);
    RELEASE(name_text);
    RELEASE(name_view);
    RELEASE(sex_l);
    RELEASE(btn_sex);
    RELEASE(sex_n);
    RELEASE(btn2_sex);
    RELEASE(sex_ns);
    RELEASE(sex_view);
    RELEASE(height_l);
    RELEASE(hegiht_text);
    RELEASE(hegiht_view);
    RELEASE(weight_l);
    RELEASE(weight_text);
    RELEASE(weight_view);
    RELEASE(data_l);
    RELEASE(data_view);
    RELEASE(blood_l);
    RELEASE(blood_view);
    RELEASE(med_l);
    RELEASE(med_text);
    RELEASE(med_view);
    RELEASE(hom_l);
    RELEASE(hom_text);
    RELEASE(hom_view);
    RELEASE(gen_l);
    RELEASE(gen_t);
    RELEASE(gen_v);
    
    RELEASE(img);
    RELEASE(imageView);
}


#pragma mark - 为解决bug加的
/*
 200 nickname
 201 name
 203 height
 204 weight
 206 allergHistory
 207 transHistory
 208 transGenetic
 1023 email
 */
/*
#pragma mark - 编辑监听
-(void)textEditing:(UITextField *)textField{

    NSLog(@"height : %@",textField.text);
    NSInteger textFiledTag = textField.tag;
    switch (textFiledTag) {
        case 200:
            //nickName
            self.nickName = textField.text;
            break;
        case 201:
            //name
            self.name = textField.text;
            break;
        case 203:
            //height
            self.height = textField.text;
            break;
        case 204:
            //weight
            self.weight = textField.text;
            break;
        case 206:
            //allergHistory
            self.allergicHistory = textField.text;
            break;
        case 207:
            //transHistory
            self.transHistory = textField.text;
            break;
        case 208:
            //transGenetic
            self.transGentic = textField.text;
            break;
        case 1023:
            //email
            self.email = textField.text;
            break;
        default:
            break;
    }
    
}
*/





-(void)btnssClcik:(UIButton *)sender
{
    NSString *sr;
    sr = sender.titleLabel.text;
    blood_text.text = sr;
    bloodView.hidden = YES;
    [[NSUserDefaults standardUserDefaults]setObject:sr forKey:@"blood"];
}


-(void)tapSelect
{
   
    if (!bloodView) {
         [self bloodSelect];
    }
   
    isclick = !isclick;
    if (isclick) {
        bloodView.hidden = NO;
    }
    else
    {
      bloodView.hidden = YES;
    }
    
}
-(void)ChangeSex2:(UIButton *)sender
{
    if (sender.tag - 100 == 0)  { // 100 nan  101 nv
        [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithLong:1] forKey:@"sex"];
    }
    else{
        
    [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithLong:2] forKey:@"sex"];
    }
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"sex"]);
    
    sender.backgroundColor = [UIColor colorWithRed:74.0/255 green:182.0/255 blue:236.0/255 alpha:1];
    
    if (sender.tag  == 101) {
        
        UIButton *bt = (UIButton *)[self viewWithTag:100];
        bt.backgroundColor = [UIColor grayColor];
    }
    else
    {
        
        UIButton *bt = (UIButton *)[self viewWithTag:101];
        bt.backgroundColor = [UIColor grayColor];
    
    }
}
-(void)BtnCLicksss
{
    [self endEditing:YES];
    if (!_calenderView) {
        [self SelectDarthCalender];
    }
    if (!_isSelectBirth) {
        [self upCalenderView];
    }else{
        [self downCalenderView];
    }
    _isSelectBirth = !_isSelectBirth;

}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //_scroll_other.scrollEnabled = YES;
    if(textField.tag == 205)
     {
        // [self resignFirstResponder];
        // [textField resignFirstResponder];

//
//         [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
//         
          //[self endEditing:YES];
//         for (id ui in self.subviews) {
//             if ([ui isKindOfClass:[UITextField class]]) {
//                 [ui resignFirstResponder];
//             }
//         }
         if (!_calenderView) {
             [self SelectDarthCalender];
         }
         if (!_isSelectBirth) {
             [self upCalenderView];
         }else{
             [self downCalenderView];
         }
         _isSelectBirth = !_isSelectBirth;
          [textField resignFirstResponder];
    }
}




-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    [textField resignFirstResponder];
    
    if (textField.tag == 200) {
        self.nickName = textField.text;
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"nickname"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    if (textField.tag == 201) {
        self.name = textField.text;
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"name"];
    }
    
    if (textField.tag == 203) {
        int wig = [textField.text  intValue];
        NSNumber *nubs = [NSNumber numberWithInt:wig];
        
//        //身高限制判断
//        NSInteger height = [nubs integerValue];
//        if (height <= 99 || height >= 240 ) {
//            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"身高填写不合理，请重新填写"];
//        }
        [[NSUserDefaults standardUserDefaults]setValue:nubs forKey:@"height"];
        self.heightStr = textField.text;
    }
    
    if (textField.tag == 204) {
        int wights = [textField.text  intValue];
        NSNumber *nub = [NSNumber numberWithInt:wights];
//        //体重限制判断
//        NSInteger weight = [nub integerValue];
//        if (weight <= 44 || weight >= 99 ) {
//            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"体重填写不合理，请重新填写"];
//        }

        [[NSUserDefaults standardUserDefaults] setValue:nub forKey:@"weight"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.weightStr = textField.text;
    }
    if (textField.tag == 205) {
        
//        NSLog(@"birthDate%@",textField.text);
//        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"birthDate"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if (textField.tag == 206) {
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"allergHistory"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    if (textField.tag == 207) {
        [[NSUserDefaults standardUserDefaults]setValue:textField.text forKey:@"transHistory"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if (textField.tag == 208) {
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"transGenetic"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }if (textField.tag == 1023) {
        [[NSUserDefaults standardUserDefaults]
         setValue:textField.text forKey:@"email"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        self.emailStr = textField.text;
    }if (textField.tag == 900) {
        
    }

}


#pragma mark - UI ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 2) {//血型
        NSString *bloodTypeStr = blood_text.text;
        switch (buttonIndex) {
            case 0:
                bloodTypeStr = @"A";
                break;
            case 1:
                bloodTypeStr = @"B";
                break;
            case 2:
                bloodTypeStr = @"AB";
                break;
            case 3:
                bloodTypeStr = @"O";
                break;
                
            default:
                break;
        }
        blood_text.text = bloodTypeStr;
        [[NSUserDefaults standardUserDefaults]setObject:bloodTypeStr forKey:@"blood"];
    }else{
    
        if (buttonIndex == 0) {//男
            [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithLong:1] forKey:@"sex"];
            sex_n.text = @"男";
        }else if(buttonIndex == 1){//女
            sex_n.text = @"女";
            [[NSUserDefaults standardUserDefaults]setValue:[NSNumber numberWithLong:2] forKey:@"sex"];
        }
        
    }

}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    bloodView.hidden = YES;
}


-(void)endediteText
{
 
    [self endEditing:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self endEditing:YES];
}
@end

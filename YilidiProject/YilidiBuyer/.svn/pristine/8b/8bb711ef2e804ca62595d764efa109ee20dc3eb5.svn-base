//
//  DLPersonalrDataVC.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 17/2/15.
//  Copyright © 2017年 yld. All rights reserved.
//

#import "DLPersonalrDataVC.h"
#import "ZFActionSheet.h"
#import "HMDatePickView.h"
#import "UIView+BlockGesture.h"
#import "GlobleConst.h"
#import "AFNHttpRequestOPManager+DLUnNomalApi.h"
#import "DLModifyNickNameVC.h"
#import "UserDataManager.h"
#import "UploadPhotoManager.h"
#import "NSString+Teshuzifu.h"
@interface DLPersonalrDataVC ()

@property(nonatomic,strong)ZFActionSheet *actionSheet;
@property(nonatomic,strong)HMDatePickView *datePickVC;
@property (nonatomic,strong)UploadPhotoManager *uploadPhotoManager;
@end

@implementation DLPersonalrDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _init];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self  _getUserInfo];
    
}

 



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------------Init---------------------------------
-(void)_init {
    self.pageTitle = @"个人资料";
    WEAK_SELF
    [self.userHeaderImage  addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        [weak_self _loadPhoto];
        
    }];
    
    
    
}

#pragma mark ------------------------Private-------------------------
- (void)_loadPhoto{
    WEAK_SELF
    self.uploadPhotoManager.uploadServerUlr = kUrl_PostUserHeaderUrl;
    self.uploadPhotoManager.allowPhotoEditing = YES;
    [self.uploadPhotoManager uploadPhoto:^UploadPhotoImgHandler *(UIImagePickerController *picker, UIImage *image, NSDictionary *editingDic) {
        UploadPhotoImgHandler *uploadPhotoImgHandler = [[UploadPhotoImgHandler alloc] init];
        if ([uploadPhotoImgHandler isToBigOfUserHeaderPhoto:image]) {
            [Util ShowAlertWithOnlyMessage:@"图片太大，请重新选择图片"];
            return uploadPhotoImgHandler;
        }else {
           [uploadPhotoImgHandler handleUserHeaderPhoto:image];
            return uploadPhotoImgHandler;
        }
    } upDateImg:^(NSString *updateImgUrl, NSError *updateImgError) {
        if (updateImgError.code == 1) {
            [weak_self _updataUserImage:updateImgUrl];
            
           
            
        }else {
            [Util ShowAlertWithOnlyMessage:updateImgError.localizedDescription];
        }
    }];
    
}

- (void)_updataUserImage:(NSString *)imageUrl {
    
    WEAK_SELF
    [AFNHttpRequestOPManager postWithParameters:@{@"userImageUrl":imageUrl} subUrl:kUrl_modifyuserinfo block:^(NSDictionary *resultDic, NSError *error) {
        if (error.code==1) {
            DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
            userModel.userImageUrl = (NSString *)[resultDic[EntityKey][@"userImageUrl"] getOriginalImgUrl];
            [[UserDataManager sharedManager]saveUserModel:userModel];
            [weak_self _getUserInfo];
            
        }else{
            
            [Util ShowAlertWithOnlyMessage:@"头像更新失败"];
        }
        
    }];
    
}

#pragma mark ------------------------Api----------------------------------
- (void)_getUserInfo {
     DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
    if (isEmpty(userModel.nickName)) {
        [_nameButton setTitle:@"暂无昵称" forState:UIControlStateNormal];
        [_nameButton setTitleColor:KWeakTextColor  forState:UIControlStateNormal];
    }else{
        [_nameButton setTitle:userModel.nickName forState:UIControlStateNormal];
        [_nameButton setTitleColor:KCOLOR_MAIN_TEXT  forState:UIControlStateNormal];
    }
    
    [self.userHeaderImage sd_setImageWithURL:[NSURL URLWithString:userModel.userImageUrl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
    switch ([userModel.memberType intValue]) {
        case 0:
            
            _isVipLabel.text =@"普通用户";
            _isVipLabel.textColor = KCOLOR_MAIN_TEXT;
            break;
            
        case 1:
            
            _isVipLabel.text =@"VIP用户";
            _isVipLabel.textColor = KCOLOR_PROJECT_RED;
            break;
            
        default:
            break;
    }
    
    NSString *userSex;
    if ([userModel.userSex integerValue]==1) {
        userSex = @"男";
    }else{
        userSex = @"女";
        
    }
    [_genderButton setTitle:userSex forState:UIControlStateNormal];
   
    if (isEmpty(userModel.birthday)) {
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"yyyy-MM-dd";
        NSString *newString = [format stringFromDate:[NSDate date]];
        self.birthStr = newString;
        
    }else{
    
        NSString *str = userModel.birthday;
        
        if (str.length>10) {
            
          str = [str substringToIndex:10];
        }
        
      self.birthStr = str;
      [_birthButton setTitle:self.birthStr forState:UIControlStateNormal];
      [_birthButton setTitleColor:KCOLOR_MAIN_TEXT forState:UIControlStateNormal];
    }
    
}

- (void)_submitIndex:(NSInteger)index parameter:(id)resultStr{

    NSArray *parameterArr = @[@"nickName",@"userSex",@"birthday"];
    NSString *parameterStr = parameterArr[index];
    
    
    [self showLoadingHub];
    [AFNHttpRequestOPManager postWithParameters:@{parameterStr:resultStr} subUrl:kUrl_modifyuserinfo block:^(NSDictionary *resultDic, NSError *error) {
        [self hideLoadingHub];
        if (error.code!=1) {
            return;
        }
    
        DLUserInfoModel *userModel = [UserDataManager sharedManager].userInfo;
        if (index==0) {
            userModel.nickName = resultStr;
        }else if (index==1){
            userModel.userSex = resultStr;
        }else{
            userModel.birthday = resultStr;
        }
        
        [[UserDataManager sharedManager]saveUserModel:userModel];
        [self  _getUserInfo];
        
    }];

}

#pragma mark ------------------------Page Navigate---------------------------

#pragma mark ------------------------View Event---------------------------
- (IBAction)nameBtnClick:(id)sender {
    
    DLModifyNickNameVC *nickVC = [[DLModifyNickNameVC alloc]init];
    nickVC.nickNameBlock = ^(NSString *name){
    
        [self.nameButton setTitle:name forState:UIControlStateNormal];
        [self _submitIndex:self.nameButton.tag parameter:name];
        
    };
    nickVC.nameStr = self.nameButton.titleLabel.text;
    [self navigatePushViewController:nickVC animate:YES];
    
}
- (IBAction)genderBtnClick:(id)sender {
    
    self.actionSheet = [ZFActionSheet actionSheetWithTitle:@"请选择性别" confirms:@[@"男",@"女"] cancel:@"取消" style:ZFActionSheetStyleCancel];
    WEAK_SELF
    self.actionSheet.sheetBlock = ^(NSUInteger index){
        weak_self.genderButton.selected = YES;
        if (index==0) {
            [weak_self.genderButton setTitle:@"男" forState:UIControlStateNormal];
            
        }else{
            
            [weak_self.genderButton setTitle:@"女" forState:UIControlStateNormal];
        }
        [weak_self _submitIndex:weak_self.genderButton.tag parameter:@(index+1)];
    };

    [self.actionSheet showInView:self.view.window];
    
}
- (IBAction)birthBtnClick:(id)sender {
    /** 自定义日期选择器 */
    
   self.datePickVC = [[HMDatePickView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //距离当前日期的年份差（设置最大可选日期）
//    self.datePickVC.maxYear = 1;
    //设置最小可选日期(年分差)
    //    _datePickVC.minYear = 10;
    
    // 日期格式化类
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:self.birthStr];
    self.datePickVC.date = date;
    
    //设置字体颜色
    self.datePickVC.fontColor = KCOLOR_PROJECT_RED;
    //日期回调
    WEAK_SELF
    self.datePickVC.completeBlock = ^(NSString *selectDate) {
        weak_self.birthButton.selected = YES;
        [weak_self _submitIndex:weak_self.birthButton.tag parameter:selectDate];
        [weak_self.birthButton setTitle:selectDate forState:UIControlStateNormal];
    };
    //配置属性
    [self.datePickVC configuration];
    
    [self.view addSubview:self.datePickVC];
    
}


#pragma mark ------------------------Delegate-----------------------------

#pragma mark ------------------------Notification-------------------------

#pragma mark ------------------------Getter / Setter----------------------
- (UploadPhotoManager *)uploadPhotoManager {
    if (!_uploadPhotoManager) {
        _uploadPhotoManager = [[UploadPhotoManager alloc] init];
    }
    return _uploadPhotoManager;
}

@end

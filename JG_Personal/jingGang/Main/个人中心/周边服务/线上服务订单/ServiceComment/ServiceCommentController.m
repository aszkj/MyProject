//
//  ServiceCommentController.m
//  jingGang
//
//  Created by 张康健 on 15/9/14.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ServiceCommentController.h"
#import "AddPhotoCollectionView.h"
#import "UIBarButtonItem+WNXBarButtonItem.h"
#import "GlobeObject.h"
#import "Util.h"
#import "TakePhotoUpdateImg.h"
#import "PhotoDataModel.h"
#import "VApiManager.h"
#import "CWStarRateView.h"
#import "IQKeyboardManager.h"
#import "MBProgressHUD.h"
#import "WSProgressHUD.h"
#import "KJShoppingAlertView.h"
#import "UIImageView+WebCache.h"
#define smallItemSize 21
#define MaxPhotoCount 6
@interface ServiceCommentController () <CWStarRateViewDelegate,UITextViewDelegate>{
    
    TakePhotoUpdateImg *_takePhotoUpdateImg;
    VApiManager        *_vapManager;
    NSInteger          _stars;
}

@property (weak, nonatomic) IBOutlet AddPhotoCollectionView *addPhotoCollectionView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addPhotoCollectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet CWStarRateView *startView;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImgView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ServiceCommentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    NSLog(@"订单id-- %@",self.groupOrder.apiId);
    
    [self _init];
    
    [self _initAddPhotoCollectionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] shouldResignOnTouchOutside];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}


- (void)viewWillDisappear:(BOOL)animate {
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}


#pragma mark ----------------------- private Method -----------------------
- (void)_init {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem initJingGangBackItemWihtAction:@selector(back) target:self];
    [Util setNavTitleWithTitle:@"服务详情" ofVC:self];
    self.navigationController.navigationBar.barTintColor = NavBarColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _takePhotoUpdateImg = [[TakePhotoUpdateImg alloc] init];
    _vapManager = [[VApiManager alloc] init];
    self.startView.delegate = self;
    self.commentTextView.delegate = self;
    self.startView.scorePercent = 5;
    _stars = 0;
    //设置可点
    //设置背景图，原图
    self.startView.originalImgName = @"Star1";
    self.startView.hilightedImgName = @"Star";
    self.startView.isCanbeTouch = YES;
    
    [self.serviceImgView sd_setImageWithURL:[NSURL URLWithString:self.groupOrder.groupAccPath] placeholderImage:nil];
    self.serviceNameLabel.text = self.groupOrder.ggName;
    self.priceLabel.text = kNumberToStrRemain2Point(self.groupOrder.totalPrice);
}


- (void)_initAddPhotoCollectionView {
    //设置默认的layout
    [self.addPhotoCollectionView setDefaultLayout];
    self.addPhotoCollectionViewHeightConstraint.constant = smallItemSize;
    WEAK_SELF;
    self.addPhotoCollectionView.deletePhotoBlock = ^(NSInteger index){
        
        [weak_self.addPhotoCollectionView.photoArr removeObjectAtIndex:index];
        [weak_self _updatePhotoDataConfigure];
    };
}


//更新相片数据源之后的一些配置
-(void)_updatePhotoDataConfigure {
    
    if (self.addPhotoCollectionView.photoArr.count > 0) {
        if (self.addPhotoCollectionViewHeightConstraint.constant == smallItemSize) {
            self.addPhotoCollectionViewHeightConstraint.constant = ItemSize;
        }
    }else {
        self.addPhotoCollectionViewHeightConstraint.constant = smallItemSize;
    }
    [self.addPhotoCollectionView reloadData];
    
//    [self performSelector:@selector(_PhotoImgScrollToBotton) withObject:nil afterDelay:1.0];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)_PhotoImgScrollToBotton {
    
    [self.addPhotoCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathWithIndex:self.addPhotoCollectionView.photoArr.count-1] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}


#pragma mark ----------------------- Action Method -----------------------
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)addPhotoAction:(id)sender {
    

    if (self.addPhotoCollectionView.photoArr.count >= MaxPhotoCount) {
        [Util ShowAlertWithOnlyMessage:@"最多只能评论6张"];
        return;
    }
    
    PhotoDataModel *model = [[PhotoDataModel alloc] init];
    //访问摄像头，添加照片
    [_takePhotoUpdateImg showInVC:self getPhoto:^(UIImagePickerController *picker, UIImage *image, NSDictionary *editingDic) {
        model.photoImg = image;
        [self.addPhotoCollectionView.photoArr addObject:model];
        [self _updatePhotoDataConfigure];
        
    } upDateImg:^(NSString *updateImgUrl, NSError *updateImgError) {
       
        if (updateImgError.code == 1) {
            [Util ShowAlertWithOnlyMessage:updateImgError.localizedDescription];
        }else {
            model.photoUrlStr = updateImgUrl;
        }
        NSLog(@"imgUrl %@",model.photoUrlStr);
    }];
}

#pragma mark ----------------------- CWStartView delegate -----------------------
- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    _stars = (NSInteger)newScorePercent;
    
}

#pragma mark ----------------------- text view delegate -----------------------
-(BOOL) textView :(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text {
    
    if ([text isEqualToString:@"\n"]) {
        [self.commentTextView resignFirstResponder];
    }
    
    return YES;
}


#pragma mark - 发布评论
- (IBAction)distributionCommentAction:(id)sender {
    
    //验证评论内容，评级
    if(![self _varyfyCommentContentAndCommentStart]) {//验证没过
        return ;
    }
    [WSProgressHUD showWithMaskType:WSProgressHUDMaskTypeDefault];
    PersonalCommentSaveRequest *request = [[PersonalCommentSaveRequest alloc] init:GetToken];
    request.api_content = self.commentTextView.text;
    NSMutableArray *commentImgUrlStrArr = [NSMutableArray arrayWithCapacity:self.addPhotoCollectionView.photoArr.count];
    for (PhotoDataModel *model in self.addPhotoCollectionView.photoArr) {
        [commentImgUrlStrArr addObject:model.photoUrlStr];
    }
    //以;分割
    NSString *imgUrlStr = [commentImgUrlStrArr componentsJoinedByString:@";"];
    request.api_orderId = self.groupOrder.apiId;
//    request.api_orderId = @117;
    request.api_content = self.commentTextView.text;
    if (imgUrlStr.length > 5) {//表示有评论图片
        request.api_photo = imgUrlStr;
    }
    request.api_evaluationAverage = @(_stars);
    
    [_vapManager personalCommentSave:request success:^(AFHTTPRequestOperation *operation, PersonalCommentSaveResponse *response) {

        NSLog(@"评论结果 %@",response);
        [WSProgressHUD dismiss];
        if (response.errorCode.integerValue == 5) {
            KSensitiveWords
        }else if (response.errorCode) {
            [KJShoppingAlertView showAlertTitle:response.subMsg inContentView:self.view];
        }else{

            [KJShoppingAlertView showAlertTitle:@"评论成功" inContentView:self.view];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.0];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [WSProgressHUD dismiss];
        [Util ShowAlertWithOnlyMessage:error.localizedDescription];
    }];
}


-(BOOL)_varyfyCommentContentAndCommentStart {

    if (!self.commentTextView.text || [self.commentTextView.text isEqualToString:@""]) {
        [Util ShowAlertWithOnlyMessage:@"评论内容不能为空"];
        return NO;
    }
    
    if (!_stars) {
        [Util ShowAlertWithOnlyMessage:@"你还未评级"];
        return NO;
    }
    
    return YES;
}


@end

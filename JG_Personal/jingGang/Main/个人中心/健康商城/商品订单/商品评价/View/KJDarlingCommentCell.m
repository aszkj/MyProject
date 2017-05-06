//
//  KJDarlingCommentCell.m
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJDarlingCommentCell.h"
#import "GlobeObject.h"
#import "RateView.h"
#import "Masonry.h"
#import "Util.h"
#import "ALActionSheetView.h"
#import "UIView+firstResponseController.h"
#import "AFNetworking.h"
#import "H5Base_url.h"
#import "UIImageView+WebCache.h"
#import "UITextView+Placeholder.h"
@interface KJDarlingCommentCell()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    NSArray *_imgArr;
    NSArray *_imgBgArr;
    NSArray *_commentLevelButtonArrs;

}

@property (weak, nonatomic) IBOutlet UIView *descriptionRateView;
@property (weak, nonatomic) IBOutlet UIView *serviceAtitudeRateView;
@property (weak, nonatomic) IBOutlet UIView *deleverServiceRateView;

//评论图片相关视图
@property (weak, nonatomic) IBOutlet UIView *imgBgViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewFirst;
@property (weak, nonatomic) IBOutlet UIView *imgBgViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSecond;
@property (weak, nonatomic) IBOutlet UIView *imgBgViewThird;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewThird;

//好评，中评，差评
@property (weak, nonatomic) IBOutlet UIButton *goodCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *middleCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *badCommentButton;


@end


@implementation KJDarlingCommentCell

- (void)awakeFromNib {
    
    [self _initInfo];
    // Initialization code
    [self _initRateView];
    
    self.commentContentTextView.placeholder = @"亲，您的意见对其他买家很有帮助哦！";
    self.commentContentTextView.delegate = self;
}


-(void)_initInfo{

    _imgArr = @[_imgViewFirst,_imgViewSecond,_imgViewThird];
    _imgBgArr = @[_imgBgViewFirst,_imgBgViewSecond,_imgBgViewThird];
    _commentLevelButtonArrs = @[_goodCommentButton,_middleCommentButton,_badCommentButton];
}



- (void)_initRateView {
    _descRateView = BoundNibView(@"RateView", RateView);
    _serviceRateView = BoundNibView(@"RateView", RateView);
    _deleverRateView = BoundNibView(@"RateView", RateView);
    
    WEAK_SELF
    _descRateView.clickStarBackBlock = ^(NSInteger starIndex){
        weak_self.model.descriptionStars = starIndex;
    };
    _serviceRateView.clickStarBackBlock = ^(NSInteger starIndex){
        weak_self.model.serviceAltitudeStars = starIndex;
    };
    _deleverRateView.clickStarBackBlock = ^(NSInteger starIndex){
        weak_self.model.deliveryServiceStars = starIndex;
    };

    [self.descriptionRateView addSubview:_descRateView];
    [self.serviceAtitudeRateView addSubview:_serviceRateView];
    [self.deleverServiceRateView addSubview:_deleverRateView];

    [_descRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weak_self.descriptionRateView);
    }];
    [_serviceRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weak_self.serviceAtitudeRateView);
    }];
    [_deleverRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weak_self.deleverServiceRateView);
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)addCommentPhotoAction:(id)sender {
    
    if (self.model.commentImgArr.count < 3) {
        [self _showPhotoSheet];
    }else{
        [Util ShowAlertWithOnlyMessage:@"评论图片不得超过三张"];
    }
}

-(void)_showPhotoSheet{

    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从相册中选择"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {

        if (buttonIndex == 0) {//拍照
            [self showPickerWithType:UIImagePickerControllerSourceTypeCamera];
        }else if (buttonIndex == 1){//从相册中选
            [self showPickerWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{//取消
        
        }
    }];
    
    [actionSheetView show];
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    if (self.model.isAddedPhoto) {
        self.commentImgBgViewHeightConstraint.constant = 48;
        self.commentImgBgView.hidden = NO;
        for (int i=0; i<self.model.commentImgArr.count; i++) {
            UIImageView *commentImgView = (UIImageView *)_imgArr[i];
            UIView *bgView = (UIView *)_imgBgArr[i];
            bgView.hidden = NO;
            commentImgView.image = (UIImage *)self.model.commentImgArr[i];
        }
        
        //隐藏没有图片的bgView
        for (NSInteger i=self.model.commentImgArr.count; i<3; i++) {
            UIView *bgView = (UIView *)_imgBgArr[i];
            bgView.hidden = YES;
        }
        
    }else{
        self.commentImgBgViewHeightConstraint.constant = 22;
        self.commentImgBgView.hidden = YES;
    }
    self.commentContentTextView.text = self.model.commentTextContent;
    _descRateView.startCount = self.model.descriptionStars;
    _deleverRateView.startCount = self.model.deliveryServiceStars;
    _serviceRateView.startCount = self.model.serviceAltitudeStars;
    
    //总评级
    for (int i=0; i<_commentLevelButtonArrs.count; i++) {
        UIButton *button = (UIButton *)_commentLevelButtonArrs[i];
        button.selected = (i == self.model.commentLevel - 1) ? YES : NO;
    }
}


- (void)showPickerWithType:(UIImagePickerControllerSourceType)photoType
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = photoType;
    picker.delegate = self;
    NSLog(@"vc %@",self.firstResponseController);
    [self.firstResponseController presentViewController:picker animated:YES completion:nil];
}

//删除图片
- (IBAction)deleteImgAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag - 10;
    
    [self.model.commentImgArr removeObjectAtIndex:index];
    if (self.model.commentImgUrlArr.count > 0) {//图片有可能没上传成功，导致数组为空
        [self.model.commentImgUrlArr removeObjectAtIndex:index];
    }
    
    if (self.model.commentImgArr.count < 1) {//说明全都删完了,回调再次刷新cell高度
        self.model.isAddedPhoto = NO;
        if (self.photoEditCauseHeightChangeBlock) {
            self.photoEditCauseHeightChangeBlock(NO);
        }
        
    }

    //每次更新cell里的图片源，，必须刷新cell，很关键
    [self setNeedsLayout];

}

#pragma mark - textView delegate
- (void)textViewDidChange:(UITextView *)textView {

    self.model.commentTextContent = textView.text;
    
}

-(BOOL) textView :(UITextView *) textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text {
    
    if ([text isEqualToString:@"\n"]) {
        [self.commentContentTextView resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - image piker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //更新评论图片视图高度约束,并将其显示
    if (self.model.isAddedPhoto == NO) {//说明是第一次增加图片
        self.model.isAddedPhoto = YES;
        //回调表，更新cell高度
        if (self.photoEditCauseHeightChangeBlock) {
            self.photoEditCauseHeightChangeBlock(YES);
        }
    }else{//否则，增加第二张或第三张图片
    }
    [self.model.commentImgArr addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //每次图片源更新，，必须要刷新cell很关键
    [self setNeedsLayout];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [self _upLoadHeadImgWithImgData:imageData];
}

//总评价
- (IBAction)commentLevelAction:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    if (selectedButton.isSelected) {
        return;
    }
    UIButton *lastSeletedButton = [Util getSeletedButtonAtBtnArr:_commentLevelButtonArrs];
    lastSeletedButton.selected = NO;
    selectedButton.selected = YES;
    
    NSInteger commentLevel = selectedButton.tag - 20;
    self.model.commentLevel = commentLevel;
    //刷新cell
    [self setNeedsLayout];
}



#pragma mark - 上传图片 - 生成url
#pragma mark - 上传头像图片
-(void)_upLoadHeadImgWithImgData:(NSData *)imgData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //图片 url + image
    //音频 url + audio
    //视频 url + video
    //@"http://api.jgyes.com/v1/image"
    NSString *postImageUrl = [NSString stringWithFormat:@"%@/v1/image",Base_URL];
    [manager POST:postImageUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"filename" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *newCommentImgUrl =  [[responseObject[@"items"] objectAtIndex:0] objectForKey:@"fileUrl"];
//        NSLog(@"comment img url %@",newCommentImgUrl);
        [self.model.commentImgUrlArr addObject:newCommentImgUrl];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}



-(void)setGoodsInfoModel:(GoodsInfoModel *)goodsInfoModel{

    _goodsInfoModel = goodsInfoModel;
#pragma mark - 2*2
    NSString *newStr = TwiceImgUrlStr(_goodsInfoModel.goodsMainphotoPath, 89, 89);
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:newStr]];
    self.goodsNameLabel.text = _goodsInfoModel.goodsName;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",    _goodsInfoModel.goodsPrice.floatValue];

//    NSLog(@"goods id %@",_goodsInfoModel.GoodsInfoModelID);
    
    //把商品信息给评论产生的模型
    self.model.goodsId = _goodsInfoModel.goodsId;
    self.model.goodsCount = _goodsInfoModel.goodsCount;
    self.model.goodsPrice = _goodsInfoModel.goodsPrice;
    self.model.goodsGspVal = _goodsInfoModel.goodsGspVal;
}





@end

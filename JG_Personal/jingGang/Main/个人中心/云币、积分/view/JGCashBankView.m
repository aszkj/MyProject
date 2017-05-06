//
//  JGCashBankView.m
//  jingGang
//
//  Created by dengxf on 16/1/8.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import "JGCashBankView.h"
#import "JGDropdownMenu.h"
#import "GlobeObject.h"
#import "UITextField+Blocks.h"

typedef void(^ClickSureBlock)(NSDictionary *infoDict);

@interface JGCashBankView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) NSArray *imgArray;

/**
 *  选中银行弹出视图 */
@property (strong,nonatomic) JGDropdownMenu *menu;

/**
 *  当前选中的银行信息 */
@property (strong,nonatomic) NSDictionary *bankInfoDictionary;

@property (copy , nonatomic) ClickSureBlock clickSureBlock;

@end

@implementation JGCashBankView

- (NSArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [[NSArray alloc] init];
    }
    return _imgArray;
}

- (NSArray *)plistArray {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bankinfo" ofType:@"plist"];
    NSArray *data = [[NSArray alloc] initWithContentsOfFile:plistPath];
    return data;
}

- (instancetype)initWithCashBankViewForSelectedBankWithInfoBlock:(void (^)(NSDictionary *))infoDictBlock
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.clickSureBlock = infoDictBlock;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    
    self.userNameTextField.shouldReturnBlock = ^(UITextField *textField){
        [self endEditing:YES];
        return YES;
    };
    self.branchBankTextField.shouldReturnBlock = ^(UITextField *textField){
        [self endEditing:YES];
        return YES;
    };
    
    self.bankCardNumberTextField.shouldChangeCharactersInRangeBlock = ^(UITextField *textField,NSRange range,NSString *string){
    
        // 四位加一个空格
        if ([string isEqualToString:@""]) { // 删除字符
            if ((textField.text.length - 2) % 5 == 0) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
        } else {
            if (textField.text.length % 5 == 0) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
        }
        return YES;  
    };
    
    self.imgArray = [self plistArray];
    if (self.imgArray.count) {
        self.bankInfoDictionary = [self.imgArray firstObject];
    }
}

- (IBAction)selecteBankForCardAction:(id)sender {
    JGLog(@"-------------------------");
    JGLog(@"选择提现银行");
    JGDropdownMenu *menu = [JGDropdownMenu menu];
    [menu configTouchViewDidDismissController:NO];
    [menu configBgShowMengban];
    
    UIViewController *activityController = [[UIViewController alloc] init];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    contentView.backgroundColor = [UIColor whiteColor];
    [activityController.view addSubview:contentView];
    
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.x = 0;
    cancelButton.y = 0;
    cancelButton.width = 80;
    cancelButton.height = 45;
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.showsTouchWhenHighlighted = YES;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.55] forState:UIControlStateNormal];
    [contentView addSubview:cancelButton];
    
    UIButton *sureButton = [[UIButton alloc] init];
    sureButton.x = ScreenWidth - cancelButton.width;
    sureButton.y = sureButton.y;
    sureButton.width = cancelButton.width;
    sureButton.height = cancelButton.height;
    sureButton.showsTouchWhenHighlighted = YES;
    [sureButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitleColor:status_color forState:UIControlStateNormal];
    [sureButton setTitle:@"完成" forState:UIControlStateNormal];
    [contentView addSubview:sureButton];
    
    UIPickerView *p = [[UIPickerView alloc] init];
    p.frame = CGRectMake(0, CGRectGetMaxY(contentView.frame), [UIScreen mainScreen].bounds.size.width, 216);
    [activityController.view addSubview:p];
    p.delegate = self;
    p.dataSource = self;
    activityController.view.backgroundColor = [UIColor whiteColor];
    activityController.view.width = ScreenWidth;
    activityController.view.height = 276;
    activityController.view.x = 10;
    activityController.view.y = ScreenHeight;
    menu.contentController = activityController;
    self.menu = menu;
    [menu showWithFrameWithDuration:0.25 FromDirection:ShowDropViewDirectionFromBottom viewHeight:276];
}

- (void)cancelAction:(UIButton *)btn {
    [self.menu dismiss];
}

- (void)sureAction:(UIButton *)btn {
    BLOCK_EXEC(self.clickSureBlock,self.bankInfoDictionary);
    [self.menu dismiss];
}

/**
 *  返回每一条银行图片名字及标题 */
- (UIView *)pickerViewWithCompnentViewWithComponent:(NSInteger)compnonet {
    NSDictionary *imgDic = self.imgArray[compnonet];
    NSArray *array = [imgDic allKeys];
    if (array.count) {
        if (array.count > 0) {
            NSString *img = [array lastObject];
            NSString *imgName = TNSString(imgDic[img]);

            UIView *showView = [[UIView alloc] init];
            showView.width = 200;
            showView.height = 50;
            UIImageView *iconImage = [[UIImageView alloc] init];
            CGFloat width = 40;
            CGFloat height = width;
            CGFloat imgX = 10;
            CGFloat imgY = (showView.height - height) / 2;
            iconImage.frame = CGRectMake(imgX, imgY, width, height);
            iconImage.image = [UIImage imageNamed:img];
            [showView addSubview:iconImage];
            
            UILabel *lab = [[UILabel alloc] init];
            lab.x  = CGRectGetMaxX(iconImage.frame) + 10;
            lab.y  = imgY;
            lab.width = 160;
            lab.height = iconImage.height;
            lab.font = JGFont(14);
            [showView addSubview:lab];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.text = imgName;
            showView.backgroundColor = [UIColor clearColor];
            return showView;
        }
        return nil;
    }
    return nil;

}

#pragma mark UIPickViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view  {
    return [self pickerViewWithCompnentViewWithComponent:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 75.00;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.bankInfoDictionary = self.imgArray[row];

}

#pragma mark UIPickDataSourceDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.imgArray.count;
}
@end

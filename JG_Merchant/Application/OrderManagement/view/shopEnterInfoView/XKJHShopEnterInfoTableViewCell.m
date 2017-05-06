 //
//  XKJHShopEnterInfoTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopEnterInfoTableViewCell.h"
#import "UITextField+Blocks.h"

@interface XKJHShopEnterInfoTableViewCell ()<UITextFieldDelegate>
{
    
    __weak IBOutlet UIButton *_rightBtn;
    __weak IBOutlet NSLayoutConstraint *rightImageWidth;
    __weak IBOutlet UILabel *baifenhao;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianWith;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidth;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation XKJHShopEnterInfoTableViewCell

- (NSAttributedString *)getShopEnterAttributeString:(NSString *)orignStr withSize:(CGFloat)size
{
    if (!orignStr)
    {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:orignStr];
    NSDictionary *attributeDict = [ NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:size],NSFontAttributeName,
                                   UIColorFromRGB(0Xcccccc),NSForegroundColorAttributeName,nil
                                   ];
    NSRange range = NSMakeRange(0, orignStr.length);
    if (range.length > 0)
    {
        [attributedString addAttributes:attributeDict range:range];
    }
    return attributedString.copy;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentText.delegate = self;
//    加手势
//    UIGestureRecognizer *ges = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerContent)];
//    ges.delegate = self;
//    [self.contentText addGestureRecognizer:ges];
    self.xianHeight.constant = 0.3;
    self.xianWith.constant = 0.25;
//    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self setNeedsDisplay];
//    self.contentText.shouldBegindEditingBlock = ^(UITextField *textField){
//        JGLog(@"--------textfieldBeginEditing:%@",self.titleLabel.text);
//        
//        return YES;
//    };
    

}
//- (void)gestureRecognizerContent{
////    点击事件
//    
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if(CGRectContainsPoint(self.contentText.frame, point)){
        if ([self.titleLabel.text containsString:@"固定电话"] || [self.titleLabel.text containsString:@"手机号码"] || [self.titleLabel.text containsString:@"返佣比例"] || [self.titleLabel.text containsString:@"折"] || [self.titleLabel.text isEqualToString:@"✻ 结算账户"] || [self.titleLabel.text containsString:@"所属身份"])
        {
            self.contentText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        else
        {
            self.contentText.keyboardType = UIKeyboardTypeDefault;
        }
        if ([self.titleLabel.text containsString:@"详细类目"] || [self.titleLabel.text containsString:@"主营类目"])
        {
            if (self.enterCategoryBlock)
            {
                self.enterCategoryBlock(self.titleLabel.text);
            }
            //        return NO;
            
        }
        if ([self.titleLabel.text containsString:@"商户所在地"])
        {
            if (self.mapBlock)
            {
                self.mapBlock();
            }
            //        return NO;
        }
        if ([self.titleLabel.text containsString:@"详细地址"])
        {
            if (self.model.content.length == 0)
            {
                [self mapAction:nil];
                //            return NO;
            }
        }
        if ([self.titleLabel.text containsString:@"开户省"])
        {
            if (self.bankAreaBlock)
            {
                self.bankAreaBlock();
            }
            //        return NO;
        }
    }
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"sbbbb");
//    if ([self.titleLabel.text containsString:@"固定电话"] || [self.titleLabel.text containsString:@"手机号码"] || [self.titleLabel.text containsString:@"返佣比例"] || [self.titleLabel.text containsString:@"折"] || [self.titleLabel.text isEqualToString:@"✻ 结算账户"] || [self.titleLabel.text containsString:@"所属身份"])
//    {
//        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    }
//    else
//    {
//        textField.keyboardType = UIKeyboardTypeDefault;
//    }
//    if ([self.titleLabel.text containsString:@"详细类目"] || [self.titleLabel.text containsString:@"主营类目"])
//    {
//        if (self.enterCategoryBlock)
//        {
//            self.enterCategoryBlock(self.titleLabel.text);
//        }
//        
////        return NO;
//    }
//    if ([self.titleLabel.text containsString:@"商户所在地"])
//    {
//        if (self.mapBlock)
//        {
//            self.mapBlock();
//        }
////        return NO;
//    }
//    if ([self.titleLabel.text containsString:@"详细地址"])
//    {
//        if (self.model.content.length == 0)
//        {
//            [self mapAction:nil];
////            return NO;
//        }
//    }
//    if ([self.titleLabel.text containsString:@"开户省"])
//    {
//        if (self.bankAreaBlock)
//        {
//            self.bankAreaBlock();
//        }
////        return NO;
//    }
////    [textField resignFirstResponder];
////    return  YES;
//}
-(void)setModel:(XKJHShopEnterInfoModel *)model
{
    //返佣比例和折扣比例的百分号
//    if ([model.title containsString:@"返佣比例"] || [model.title containsString:@"折       扣"])
//    {
//        baifenhao.hidden = NO;
//    }
//    else
//    {
//        baifenhao.hidden = YES;
//    }
    baifenhao.hidden = YES;
    _model = model;
    self.titleLabel.attributedText = [Util getShopEnterAttributeString:model.title];
    self.titleWidth.constant = model.titleWidth;
    //右边图标
    if (model.rightImageName.length > 0 )
    {
        self.rightImageView.hidden = NO;
        self.rightImageView.image = [UIImage imageNamed:model.rightImageName];
    }
    else
    {
        self.rightImageView.hidden = YES;
    }
    if ([model.rightImageName isEqualToString:@"Address"])
    {
        rightImageWidth.constant = 16;
        _rightBtn.hidden = NO;
    }
    else
    {
        rightImageWidth.constant = 11;
        _rightBtn.hidden = YES;
    }

    self.contentText.text = model.content;
    self.contentText.attributedPlaceholder = [self getShopEnterAttributeString:model.placeholder withSize:kScreenWidth > 320 ? 15 : 13];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"self.titleLabel.text%@",self.titleLabel.text);
    if ([self.titleLabel.text containsString:@"固定电话"] || [self.titleLabel.text containsString:@"手机号码"] || [self.titleLabel.text containsString:@"返佣比例"] || [self.titleLabel.text containsString:@"折"] || [self.titleLabel.text isEqualToString:@"✻ 结算账户"] || [self.titleLabel.text containsString:@"所属身份"])
    {
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    else
    {
        textField.keyboardType = UIKeyboardTypeDefault;
    }    
    if ([self.titleLabel.text containsString:@"详细类目"] || [self.titleLabel.text containsString:@"主营类目"])
    {
        if (self.enterCategoryBlock)
        {
            self.enterCategoryBlock(self.titleLabel.text);
        }
        return NO;
    }
    if ([self.titleLabel.text containsString:@"商户所在地"])
    {
        if (self.mapBlock)
        {
            self.mapBlock();
        }
        return NO;
    }
    if ([self.titleLabel.text containsString:@"详细地址"])
    {
        if (self.model.content.length == 0)
        {
            [self mapAction:nil];
            return NO;
        }
    }
    if ([self.titleLabel.text containsString:@"开户省"])
    {
        if (self.bankAreaBlock)
        {
            self.bankAreaBlock();
        }
        return NO;
    }
    return  YES;
}
#pragma mark - 点击右边按钮回调
- (IBAction)mapAction:(id)sender
{
    if (self.mapPositionBlock)
    {
        self.mapPositionBlock();
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
//    textField.editing = YES;
    self.model.content = textField.text;
}

@end

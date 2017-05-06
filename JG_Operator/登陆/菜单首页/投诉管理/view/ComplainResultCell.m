//
//  ComplainResultCell.m
//  Operator_JingGang
//
//  Created by dengxf on 15/10/28.
//  Copyright © 2015年 XKJH. All rights reserved.
//

#import "ComplainResultCell.h"
#import "JGTextView.h"

@interface ComplainResultCell ()
/**
 *  按钮的背景视图
 */
@property (strong,nonatomic) UIView *btnBgView;

/**
 *  提交按钮
 */
@property (strong,nonatomic) UIButton *commiteButton;


@property (strong,nonatomic) JGTextView *textView;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;


@end

@implementation ComplainResultCell

// 按钮的背景视图
- (UIView *)btnBgView {
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc] init];
        _btnBgView.backgroundColor = kGetColor(218, 219, 220);
        [self.contentView addSubview:_btnBgView];
    }
    return _btnBgView;
}

// UITextView控件 --
- (JGTextView *)textView {
    if (!_textView) {
        _textView = [[JGTextView alloc] init];
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

// 提交按钮-
- (UIButton *)commiteButton {
    if (!_commiteButton) {
        _commiteButton = [[UIButton alloc] init];
        [_commiteButton setTitle:@"提 交" forState:UIControlStateNormal];
        [_commiteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commiteButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_commiteButton setBackgroundColor:status_color];
        _commiteButton.layer.cornerRadius = 3.0f;
        [_commiteButton addTarget:self action:@selector(conmmiteClick) forControlEvents:UIControlEventTouchUpInside];
        [self.btnBgView addSubview:_commiteButton];
    }
    return _commiteButton;
}

// 监听提交按钮点击事件
- (void)conmmiteClick {
    if (self.textView.text.length > 500) {
        [MBProgressHUD showSuccess:@"输入字数不能超过500个字" toView:[self getCurrentVC].view ];
        return;
    }
    if ([self.delaget respondsToSelector:@selector(commitTextViewTextForVC:)]) {
        return [self.delaget commitTextViewTextForVC:self.textView.text];
    }
}

- (void)setModel:(ComplainDetailModel *)model
{
    _model = model;
    //状态是3  已完成就不要显示提交按钮
    if ([_model.status isEqualToString:@"3"]) {
        self.textView.text = [NSString stringWithFormat:@"%@",_model.handleContent];
        self.textView.text = [NSString stringDiseposeNullWithStr:self.textView.text];
        self.textView.editable = NO;
        self.btnBgView.hidden = YES;
        self.commiteButton.hidden = YES;
    }else{
        self.textView.backgroundColor = kGetColor(218, 219, 220);
    }
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat spacing = 7.0;
    
    self.textView = (JGTextView *) [self layoutControlView:self.textView
                                                    orginX:16
                                                    orginY:CGRectGetMaxY(self.titleLab.frame) + spacing
                                                     width:kScreenWidth - (self.textView.x * 2)
                                                    height:57];
    

    
    self.btnBgView = [self layoutControlView:self.btnBgView
                                      orginX:0
                                      orginY:CGRectGetMaxY(self.textView.frame) + 15
                                       width:kScreenWidth
                                      height:56 + 44];
    
    self.commiteButton = (UIButton *)[self layoutControlView:self.commiteButton
                                                      orginX:16
                                                      orginY:28
                                                       width:self.textView.width
                                                      height:44];


}

- (UIView *)layoutControlView:(UIView *)controlView
                   orginX:(CGFloat)orginX
                   orginY:(CGFloat)orginY
                    width:(CGFloat)width
                   height:(CGFloat)height {
    
    controlView.x = orginX;
    controlView.y = orginY;
    controlView.width = width;
    controlView.height = height;
    return controlView;
}



- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end

//
//  DeleteImageView.m
//  jingGang
//
//  Created by dengxf on 15/10/22.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "DeleteImageView.h"
#import "UIViewExt.h"

@interface DeleteImageView ()

@property (strong,nonatomic) UIButton *deleteButton;

@property (assign, nonatomic) int presee;


@end

@implementation DeleteImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.presee = 0;
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setImage:[UIImage imageNamed:@"ask_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"ask_delete_pressed"] forState:UIControlStateHighlighted];
        deleteBtn.hidden = YES;
        [deleteBtn addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        deleteBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.deleteButton = deleteBtn;
        
        //给uiimageView添加长按手势
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longGesture.numberOfTouchesRequired = 1;
        longGesture.allowableMovement = 15.0;
        longGesture.minimumPressDuration = 1;
        [self addGestureRecognizer:longGesture];
    }
    return self;
}

- (void)deleteImageAction:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(deleteButtonClick:)]) {
        [self.delegate deleteButtonClick:self];
    }
}

/**
 *   监听长按事件
 */
- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.presee ++;
            int a = self.presee%2;
            
            if ([self.delegate respondsToSelector:@selector(deleImageViewLongPress:state:)]) {
                
                if (a) {
                    //当删除按钮的状态为显示时
                    [self.delegate deleImageViewLongPress:self state:DeleteButtonHidden];
                }else{
                    //当删除按钮的状态隐藏时
                    [self.delegate deleImageViewLongPress:self state:DeleteButtonShow];
                }
            }
        }
            break;
        default:
            break;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = 40;
    self.deleteButton.frame = CGRectMake(self.width - width/2, - 20, width, width);
}

- (void)setIsShowDeleteButtn:(BOOL)isShowDeleteButtn {
    _isShowDeleteButtn = isShowDeleteButtn;
    self.deleteButton.hidden = !isShowDeleteButtn;
}

@end

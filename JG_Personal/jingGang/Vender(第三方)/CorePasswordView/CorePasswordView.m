//
//  CorePasswordView.m
//  CorePasswordView
//
//  Created by 冯成林 on 16/1/6.
//  Copyright © 2016年 冯成林. All rights reserved.
//

#import "CorePasswordView.h"

@interface CorePasswordTF : UITextField

@end

@implementation CorePasswordTF

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:) || action == @selector(select:) || action == @selector(selectAll:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end



@interface CorePasswordBtn : UIButton

@end

@implementation CorePasswordBtn


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}



/*
 *  视图准备
 */
-(void)viewPrepare{
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:60];
    self.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    self.layer.borderWidth = 0.5f;
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = NO;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:nil action:nil]];
}

@end



@interface CorePasswordView ()<UITextFieldDelegate>

@property (nonatomic,strong) CorePasswordTF *tf;

@property (nonatomic,strong) NSMutableArray *btns;

@end


@implementation CorePasswordView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}



/*
 *  视图准备
 */
-(void)viewPrepare{
    
    //添加一个UITextField
    self.passwordLength = 6;
    self.layer.borderWidth=0.5f;
    self.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor;
    self.layer.cornerRadius=4;
}



-(CorePasswordTF *)tf{

    if(_tf == nil){
    
        _tf = [[CorePasswordTF alloc] init];
        _tf.keyboardType = UIKeyboardTypeNumberPad;
        _tf.textColor = [UIColor clearColor];
        [self insertSubview:_tf atIndex:0];
        _tf.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:_tf];
    }
    
    return _tf;
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)setPasswordLength:(NSInteger)passwordLength {

    

    NSAssert(passwordLength >= 1, @"Charlin Feng: passwordLength must greater than 1");
    
    if(_passwordLength == 0){ //默认
    
        for (NSUInteger i = 0; i< passwordLength; i++) {
            
            CorePasswordBtn *btn = [[CorePasswordBtn alloc] init];
            [self addSubview:btn];
        }
        
    }else {
    
        if(passwordLength == _passwordLength) return;
        
        if(passwordLength > _passwordLength){ //新的更多
        
            for (NSUInteger i = 0; i< passwordLength - _passwordLength; i++) {
                
                CorePasswordBtn *btn = [[CorePasswordBtn alloc] init];
                [self addSubview:btn];
            }
            
        }else{ // 新的更少
        
            __block NSInteger count = 0;
            
            [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if([obj isKindOfClass:[CorePasswordBtn class]]){
                
                    if(count < passwordLength){
                        
                        count++;
                        
                    }else{
                        [obj removeFromSuperview];
                    }
                }
            }];
            
        }
    }
    

    
    _passwordLength = passwordLength;
}




-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.btns removeAllObjects];
    
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat h_each = height;
    CGFloat w_each = width / self.passwordLength;
    
    __block NSInteger count = 0;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if([obj isKindOfClass:[CorePasswordBtn class]]){
            
            CGFloat x_each = count * w_each;
            CGFloat y_each = 0;
            
            CGRect frame = CGRectMake(x_each, y_each, w_each, h_each);
            
            obj.frame = frame;
        
            
            [self.btns addObject:obj];
            
            
            count++;
        }
    }];
    
    self.tf.frame = self.bounds;
}


-(NSMutableArray *)btns{

    if(_btns == nil){
    
        _btns = [NSMutableArray array];
    }
    
    return _btns;
}

/** 开始输入 */
-(void)beginInput{
    [self.tf becomeFirstResponder];
}


/** 结束输入 */
-(void)endInput{
    [self.tf resignFirstResponder];
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    if(string.length == 0) return YES;
    return textField.text.length < self.passwordLength;
}


-(void)textDidChange{

    NSString *str = self.tf.text;
    
    for (NSUInteger i = 0; i< self.btns.count; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        
        NSString *c = i < str.length ? @"·" : nil;
        
        [self.btns[i] setTitle:c forState:UIControlStateNormal];
    }
    
    if(self.passwordLength > str.length) return;
    
    if(self.PasswordCompeleteBlock != nil) {self.PasswordCompeleteBlock(str); [self endInput];}
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self beginInput];
}


-(NSString *)password{

    return self.tf.text;
}

/** 清空密码 */
-(void)clearPassword{

    self.tf.text = @"";
    [self textDidChange];
}

@end

//
//  welfareView.m
//  QDDictionaryData
//
//  Created by 张康健 on 15-08-08.



#import "welfareView.h"

//button距离两边的间距
#define kMarginLeft 10
//button距离顶部的距离
#define kMarginTop 10
//中间button的垂直间距
#define kVerticalGap 10
//中间button的水平间距
#define kHorizontalGap 10

//button中标题的高度
#define kTitleHeight 20
//button中标题距离button顶部的高度
#define kButtonTitleToTopEdge 5
//button中标题距离button左右的距离
#define KButtonTitleToleftRightEdge 20

//默认按钮颜色
#define kDefaultColor [UIColor whiteColor]
//默认按钮选中颜色
#define kDefaultSelectedColor [UIColor blueColor]

//屏幕宽度
#define WkScreenWidth [[UIScreen mainScreen] bounds].size.width


@interface welfareView(){

    NSMutableArray *_titleButtonArr;
    BOOL            _isCaculateHeight; //是否是计算高度

}

@end

@implementation welfareView

- (void)setWelfaresString:(NSString *)welfaresString
{
    if (welfaresString != _welfaresString) {
        _welfaresString = welfaresString;
    }
    //不是计算高度
    _isCaculateHeight = NO;
    if (welfaresString != nil) {
       _titleArr = [welfaresString componentsSeparatedByString:@","];
        [self _beginCaculate];
    }
    
}

-(void)setTitleArr:(NSArray *)titleArr{
    
    _titleArr = titleArr;
    //不是计算高度
    _isCaculateHeight = NO;
    [self _beginCaculate];
    
}

#pragma mark - 计算高度
-(CGFloat)beginCaculateHeightWithTitleArr:(NSArray *)titleArr {

    _titleArr = titleArr;
    //是计算高度
    _isCaculateHeight = YES;
    [self _beginCaculate];
    return  self.welfheight;
}


#pragma mark - 开始计算
-(void)_beginCaculate{

    //配置间距属性
    [self _configureGapAttribute];
    CGFloat fltX = self.marginLeft;
    CGFloat fltY = self.marginTop;
    
    CGFloat buttonHeight = self.titleHeight + 2 * self.buttonTitleToTopEdge;
    CGFloat buttonLeftRightTotalGap = self.buttonTitleToleftRightEdge * 2;
    NSInteger count = 1;

    if (!_isCaculateHeight) {//不是计算高度，才创建butto数组
        _titleButtonArr = [NSMutableArray arrayWithCapacity:_titleArr.count];
    }
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    for (int i = 0; i < _titleArr.count; i++) {
        NSString *text = _titleArr[i];
        CGSize size = [text boundingRectWithSize:CGSizeMake(1000, buttonHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        if (size.width+buttonLeftRightTotalGap + fltX > WkScreenWidth) {
            
            fltX  = self.marginLeft;
            fltY  = self.marginTop + (self.verticalGap + buttonHeight) * count;
            count++;
        }
        if (!_isCaculateHeight) {//不是计算高度，才添加button
            
            UIButton *textButton = [[UIButton alloc] initWithFrame:CGRectMake(fltX, fltY, size.width+buttonLeftRightTotalGap, buttonHeight)];
            [textButton setTitle:text forState:UIControlStateNormal];
            [self _configureButton:textButton];
            [self addSubview:textButton];
            textButton.tag = i;
            [_titleButtonArr addObject:textButton];
            [textButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    
        fltX = fltX + size.width+buttonLeftRightTotalGap + self.horizontalGap;
    }
    if (!_isCaculateHeight) {//不是计算高度，才给自己赋值
        CGRect selfFrame = self.frame;
        selfFrame.size.height = fltY + buttonHeight+self.verticalGap;
        selfFrame.size.width = WkScreenWidth;
        self.frame = selfFrame;
    }else{//是计算高度
        //赋值高度
        self.welfheight = fltY + buttonHeight+self.verticalGap;
    }
}


#pragma mark - 得到选中的button
-(UIButton *)selectedButton{

    for (UIButton *button in _titleButtonArr) {
        if (button.selected) {
            return button;
            break;
        }
    }
    return nil;
}


#pragma mark - 配置一些间距属性
-(void)_configureGapAttribute{
    
    //设置默认值
    [self setDefaulValueWithPropertyValue:self.marginLeft properptyName:@"marginLeft" defaultValue:kMarginLeft];
    [self setDefaulValueWithPropertyValue:self.marginTop properptyName:@"marginTop" defaultValue:kMarginTop];
    [self setDefaulValueWithPropertyValue:self.verticalGap properptyName:@"verticalGap" defaultValue:kVerticalGap];
    [self setDefaulValueWithPropertyValue:self.horizontalGap properptyName:@"horizontalGap" defaultValue:kHorizontalGap];
    [self setDefaulValueWithPropertyValue:self.titleHeight properptyName:@"titleHeight" defaultValue:kTitleHeight];
    [self setDefaulValueWithPropertyValue:self.buttonTitleToTopEdge properptyName:@"buttonTitleToTopEdge" defaultValue:kButtonTitleToTopEdge];
    [self setDefaulValueWithPropertyValue:self.buttonTitleToleftRightEdge properptyName:@"buttonTitleToleftRightEdge" defaultValue:KButtonTitleToleftRightEdge];
 
    
    if (!self.selectedColor) {
        self.selectedColor = kDefaultSelectedColor;
    }
    if (!self.bgcolor) {
        self.bgcolor = kDefaultColor;
    }
}


#pragma mark - 设置默认属性
-(void)setDefaulValueWithPropertyValue:(CGFloat)propertyValue properptyName:(NSString *)propertyName defaultValue:(CGFloat)defaultValue{

    if (!propertyValue) {
        [self setValue:@(defaultValue) forKey:propertyName];
    }
}


#pragma mark - 配置button属性
-(void)_configureButton:(UIButton *)textButton{
    
    textButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    textButton.backgroundColor = self.bgcolor;
    textButton.layer.cornerRadius = 3.0;
    textButton.layer.masksToBounds = NO;
    textButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textButton.layer.borderWidth = 1;
}


#pragma mark - Action Method
-(void)clickButton:(UIButton *)button{
    //如果本身选中了，则取消
    if (button.selected) {
        button.selected = NO;
        [self setButtonStateColorOfButton:button];
        self.clickIndexBlock(button.tag,self.titleArr[button.tag],NO);
        return;
    }
    
    UIButton *lastSelectedButton = [self selectedButton];
    if (lastSelectedButton) {
        lastSelectedButton.selected = NO;
        [self setButtonStateColorOfButton:lastSelectedButton];
    }
    

    //设置button选中状态，颜色
    button.selected = YES;
    [self setButtonStateColorOfButton:button];
    
    
    //回调
    if (self.clickIndexBlock) {
        //不是同一个，打开
        self.clickIndexBlock(button.tag,self.titleArr[button.tag],YES);
    }
    
}


-(void)setButtonStateColorOfButton:(UIButton *)button{
    
    button.backgroundColor = button.selected ? self.selectedColor : kDefaultColor;
}



@end

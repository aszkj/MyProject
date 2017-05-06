//
//  JGShopActiveContentController.m
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGShopActiveContentController.h"
#import "UIImage+SizeAndTintColor.h"
#import "JGActivityHotSaleApiBO.h"
#import "UIImageView+WebCache.h"

@interface JGShopActiveContentController ()

@property (strong,nonatomic) UIView *contentView;

@property (strong,nonatomic) UIButton *selectedBtn;

@property (strong,nonatomic) JGActivityHotSaleApiBO *apiBO;

@property (copy , nonatomic) NSString *urlString;


@end

@implementation JGShopActiveContentController


- (instancetype)initWithControllerType:(ControllerType)controllerType withModelObject:(id)object {
    if ([super init]) {
        self.controllerType = controllerType;
        if ([object isKindOfClass:[JGActivityHotSaleApiBO class]]) {
            self.apiBO = (JGActivityHotSaleApiBO *)object;
        }
    }
    return self;
}

- (instancetype)initWithControllerType:(ControllerType)controllerType imageUrlString:(NSString *)urlString {
    if (self = [super init]) {
        self.controllerType = controllerType;
        self.urlString = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    switch (self.controllerType) {
        case ControllerPopImageType:
        {
            self.view.backgroundColor = [UIColor clearColor];
            UIImageView *img = [[UIImageView alloc] init];
            img.backgroundColor = [UIColor clearColor];
            img.x = 20;
            img.width = ScreenWidth - img.x * 2;
            img.height = 1.47 * img.width;
            CGFloat height = img.height;
            height = ( (ScreenHeight - 3.5 * NavBarHeight) -  height )/ 2;
            img.y = height;
            img.userInteractionEnabled = YES;
            [img sd_setImageWithURL:[NSURL URLWithString:self.urlString] placeholderImage:nil options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushActivityAction)];
            [img addGestureRecognizer:tapGesture];
            img.alpha = 0;
            POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            basic.fromValue = @(0.0);
            basic.toValue = @(1.0);
            [img pop_addAnimation:basic forKey:@"fade"];
            [self.view addSubview:img];
            
            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [closeBtn setImage:[UIImage imageNamed:@"shop_main_closeButton"] forState:UIControlStateNormal];
            closeBtn.x = CGRectGetMaxX(img.frame) - 22;
            closeBtn.y = -15;
            closeBtn.width = 45;
            closeBtn.height = 45;
            [closeBtn addTarget:self action:@selector(closeActivity) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:closeBtn];
        }
            break;
        case ControllerCustomViewType:
        {
            UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
            bgView.height = 75;
            bgView.alpha = 0.8;
            bgView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:bgView];
            
            UIView *contentView = [[UIView alloc] initWithFrame:self.view.bounds];
            contentView.height = 75;
            contentView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:contentView];
            self.view.backgroundColor = [UIColor clearColor];
            self.contentView  = contentView;
            [self setupContentView];
        }
            break;
        default:
            break;
    }
}

- (void)pushActivityAction {
    if (self.pushActivityPageBlock) {
        self.pushActivityPageBlock();
    }
}

- (void)closeActivity {
    if (self.closeViewClickBlock) {
        self.closeViewClickBlock();
    }
}

- (void)setupContentView {
    
    NSArray *array = @[@"我能兑换的",@"全部",@"101-1000",@"1001-2000",@"2001-3000",@"3001-5000",@"5000以上"];
    // 设置按钮的位置
    for (int i = 0; i < array.count; i++) {
        // 取出按钮
        UIButton *btn = [self button];
        
        // 设置位置
        CGFloat w = 85;
        CGFloat h = 24;
        int totalCol = 3;
        CGFloat col = i % totalCol;
        CGFloat row = i / totalCol;
        CGFloat margin = (ScreenWidth- totalCol * w) / (totalCol + 1);
        CGFloat x = col * (margin + w) + margin;
        CGFloat y = row * (0 + h) ;
        btn.frame = CGRectMake(x, y, w, h);
        btn.tag = i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger remeberTag =[[NSUserDefaults standardUserDefaults] integerForKey:@"kButtonFilterTagKey"];
        
        if (btn.tag == remeberTag ) {
            btn.selected = YES;
            self.selectedBtn = btn;
        }
        
        [self.contentView addSubview:btn];
    }
}

- (void)filterButtonClick:(UIButton *)btn {
    
    if (btn == self.selectedBtn) {
        if (btn.tag == 0) {
            // 我能兑换的
            self.filterButtonClickBlock(FilterUserShouldConvertType,btn.currentTitle);
        }
        return;
    }else {
        btn.selected = !btn.selected;
        self.selectedBtn.selected = NO;

    }
    
    if (self.filterButtonClickBlock) {
        if (btn.tag == 0) {
            // 我能兑换的
            self.filterButtonClickBlock(FilterUserShouldConvertType,btn.currentTitle);
        }else if (btn.tag == 1) {
            // 全部
            self.filterButtonClickBlock(FilterAllShopType,btn.currentTitle);

        }else if (btn.tag == 6) {
            // 5000以上的
            self.filterButtonClickBlock(FilterMostUpType,btn.currentTitle);
        }else {
            // 分段的
            self.filterButtonClickBlock(FilterSectionType,btn.currentTitle);
        }
        
    }
    
    self.selectedBtn = btn;
    
    [[NSUserDefaults standardUserDefaults] setInteger:btn.tag forKey:@"kButtonFilterTagKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (UIButton *)button{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:JGColor(255, 255, 255, 1) forState:UIControlStateSelected];
    [button setTitleColor:JGColor(216, 15, 56, 1) forState:UIControlStateNormal];
    [button setBackgroundImage:[self mdf_imageWithColor:JGColor(216, 15, 56, 1) cornerRadius:2.5] forState:UIControlStateSelected];
    [button setBackgroundImage:[self mdf_imageWithColor:[UIColor clearColor] cornerRadius:0    ] forState:UIControlStateNormal];
    return button;
}


- (UIImage *)mdf_imageWithColor:(UIColor *)color
                   cornerRadius:(CGFloat)cornerRadius
{
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}


@end

//
//  CWStarRateView.m
//  StarRateDemo
//
//  Created by WANGCHAO on 14/11/4.
//  Copyright (c) 2014年 wangchao. All rights reserved.
//
//Star_white
#import "CWStarRateView.h"

#define FOREGROUND_STAR_IMAGE_NAME @"icon_star_white_unselect"
#define BACKGROUND_STAR_IMAGE_NAME @"Star_white"
#define DEFALUT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.2

@interface CWStarRateView ()

@property (nonatomic, strong) UIView *foregroundStarView;
@property (nonatomic, strong) UIView *backgroundStarView;

@property (nonatomic, assign) NSInteger numberOfStars;

@end

@implementation CWStarRateView

#pragma mark - Init Methods
- (instancetype)init {
    NSAssert(NO, @"You should never call this method in this class. Use initWithFrame: instead!");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame numberOfStars:DEFALUT_STAR_NUMBER];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _numberOfStars = DEFALUT_STAR_NUMBER;
        [self buildDataAndUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = numberOfStars;
        [self buildDataAndUI];
    }
    return self;
}

#pragma mark - Private Methods

- (void)buildDataAndUI {
    _scorePercent = 1;//默认为1
    _hasAnimation = NO;//默认为NO
    _allowIncompleteStar = NO;//默认为NO
    _isCanbeTouch = NO;//默认不可点
    self.userInteractionEnabled = _isCanbeTouch;
    self.foregroundStarView = [self createStarViewWithImage:FOREGROUND_STAR_IMAGE_NAME];
    self.backgroundStarView = [self createStarViewWithImage:BACKGROUND_STAR_IMAGE_NAME];
    
    [self addSubview:self.backgroundStarView];
    [self addSubview:self.foregroundStarView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
    CGPoint tapPoint = [gesture locationInView:self];
    [self setStarAtTouchPoint:tapPoint];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint tapPoint = [touch locationInView:self];
    if (self.isCanbeTouch) {
        [self setStarAtTouchPoint:tapPoint];
    }
}

- (void)setStarAtTouchPoint:(CGPoint)tapPoint{
    CGFloat offset = tapPoint.x;
    CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
    CGFloat starScore = self.allowIncompleteStar ? realStarScore : ceilf(realStarScore);
#pragma mark - 修改 扩大 /2 *10
    self.scorePercent = ((starScore / self.numberOfStars)/2) * 10;
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    for (NSInteger i = 0; i < self.numberOfStars; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars, 0, self.bounds.size.width / self.numberOfStars, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak CWStarRateView *weakSelf = self;
    CGFloat animationTimeInterval = self.hasAnimation ? ANIMATION_TIME_INTERVAL : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
       weakSelf.foregroundStarView.frame = CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
    }];
}

#pragma mark - Get and Set Methods
-(void)setIsCanbeTouch:(BOOL)isCanbeTouch {
    _isCanbeTouch = isCanbeTouch;
    self.userInteractionEnabled = isCanbeTouch;
}

-(void)setOriginalImgName:(NSString *)originalImgName {
    
    [self.backgroundStarView removeFromSuperview];
    self.backgroundStarView = [self createStarViewWithImage:originalImgName];
    [self addSubview:self.backgroundStarView];

}

-(void)setHilightedImgName:(NSString *)hilightedImgName {
    [self.foregroundStarView removeFromSuperview];
    self.foregroundStarView = [self createStarViewWithImage:hilightedImgName];
    [self addSubview:self.foregroundStarView];
}


- (void)setScorePercent:(CGFloat)scroePercent {
    //原本是0-1,现在改了，将它扩大，
//    scroePercent += 0.5;
#pragma mark - 缩小 *2 /10
    scroePercent = scroePercent * 2 / 10;
    if (_scorePercent == scroePercent) {
        return;
    }
    
    if (scroePercent < 0) {
        _scorePercent = 0;
    } else if (scroePercent > 1) {
        _scorePercent = 1;
    } else {
        _scorePercent = scroePercent;
    }
    
    if ([self.delegate respondsToSelector:@selector(starRateView:scroePercentDidChange:)]) {
#pragma mark - 放大，因为入口处缩小了
        scroePercent = (scroePercent / 2) * 10;
        [self.delegate starRateView:self scroePercentDidChange:scroePercent];
    }
    
    [self setNeedsLayout];
}

@end

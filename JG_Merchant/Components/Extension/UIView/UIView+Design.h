//
//  UIView+Design.h
//  
//
//  Created by 1 on 15/4/21.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Design)

@property(nonatomic)IBInspectable CGFloat cornerRadius;
@property(nonatomic)IBInspectable UIColor *borderColor;
@property(nonatomic)IBInspectable CGFloat borderWidth;

@property (nonatomic) IBInspectable UIColor *barTintGradientColorStart;
@property (nonatomic) IBInspectable UIColor *barTintGradientColorEnd;
@property (nonatomic) IBInspectable NSArray *gradientColors;
@property (nonatomic) CAGradientLayer *gradientLayer;

- (void)drawGradientColor;
- (void)setBarTintGradientColors:(NSArray *)barTintGradientColors;


@end

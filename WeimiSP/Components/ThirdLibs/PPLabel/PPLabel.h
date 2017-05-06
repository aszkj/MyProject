//
//  PPLabel.h
//  PPLabel
//
//  Created by Petr Pavlik on 12/26/12.
//  Copyright (c) 2012 Petr Pavlik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPLabel;

typedef NS_ENUM(NSUInteger, ClickKeyType) {
    ClickKeyTypeUserCustomerID = 0,
    ClickKeyTypeKeyword
};

@protocol PPLabelDelegate <NSObject>

@optional
- (void)ppLabelIsTouched;

- (void)ppLabel:(PPLabel *)label didSelectKey:(NSString *)key;
- (void)ppLabel:(PPLabel *)label didSelectKey:(NSString *)key clickKeyType:(ClickKeyType)type;

- (void)label:(PPLabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex;
- (void)label:(PPLabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex;
- (void)label:(PPLabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex;
- (void)label:(PPLabel*)label didCancelTouch:(UITouch*)touch;

@end

@interface PPLabel : UILabel

@property (nonatomic, copy) NSArray *clickUserCustomerIDs;
@property (nonatomic, copy) NSArray *clickNames;

@property (nonatomic, strong) NSString *userCustomerID;
@property (nonatomic, weak) id <PPLabelDelegate> delegate;

@property (nonatomic, assign) ClickKeyType clickKeyType;


- (CFIndex)characterIndexAtPoint:(CGPoint)point;

@end

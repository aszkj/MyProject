//
//  JDBKeyboard.m
//  JDBClient
//
//  Created by You Tu on 15/1/17.
//  Copyright (c) 2015年 JDB. All rights reserved.
//

#import "XF_Keyboard.h"
NSString *const kTabNormalColor = @"tabNormalColor";
NSString *const kTabSelectedColor = @"tabSelectedColor";
NSString *const kNavigationBarBgColor = @"navgaitonBarBgColor";
NSString *const kDotBadgeBgColor = @"dotBadgeBgColor";
NSString *const kPasswordDotColor = @"passwordDotColor";
NSString *const kGroupTableViewColor = @"groupTableViewColor";
NSString *const kGroupTableViewSeparatorColor = @"groupTableViewSeparatorColor";
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion]\
compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation XF_Keyboard

- (id)init {
    self = [super init];
    if (self){
        _navBarColor = [UIColor groupTableViewBackgroundColor];
        _fontColor = [self jdb_colorForKey:@"000000"];
    }
    return self;
}

- (UIColor *)jdb_colorForKey:(NSString *)key {
    return [self jdb_colorForKey:key alpha:1.0];
}

- (UIColor *)jdb_colorForKey:(NSString *)key alpha:(CGFloat)alpha {
    if ([key isEqualToString:kTabNormalColor]) {
        return [self mdf_colourWithHexString:@"87888a" alpha:alpha];
    } else  if ([key isEqualToString:kTabSelectedColor]) {
        return [self mdf_colourWithHexString:@"2064bd" alpha:alpha];
    } else if ([key isEqualToString:kNavigationBarBgColor]) {
        return [self mdf_colourWithHexString:@"044cbf" alpha:alpha];
    } else if ([key isEqualToString:kDotBadgeBgColor]) {
        return [self mdf_colourWithHexString:@"ee4721" alpha:alpha];
    } else if ([key isEqualToString:kPasswordDotColor]) {
        return [self mdf_colourWithHexString:@"096cff" alpha:alpha];
    } else if ([key isEqualToString:kGroupTableViewColor]) {
        return [self mdf_colourWithHexString:@"edeef0" alpha:alpha];
    } else if ([key isEqualToString:kGroupTableViewSeparatorColor]) {
        return [self mdf_colourWithHexString:@"e1e3e6" alpha:alpha];
    }
    return [self mdf_colourWithHexString:key alpha:alpha];
}

- (UIColor *)mdf_colourWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [self mdf_colourWithRGBHex:hexNum alpha:alpha];
}

- (UIColor *)mdf_colourWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}



- (UIToolbar *)getToolbarWithDonePrevious:(BOOL)previousEnabled next:(BOOL)nextEnabled
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *barSegment = [self getNextPrevButtons:previousEnabled :nextEnabled];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [self getDoneButton];
    toolbar.items = [NSArray arrayWithObjects:barSegment, flexButton, doneButton, nil];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [toolbar setBarTintColor:self.navBarColor];
        [toolbar setTintColor:self.fontColor];
    } else {
        [toolbar setTintColor:self.navBarColor];
    }
    
    return toolbar;
}

- (UIToolbar *)getToolbarWithPrevious:(BOOL)previousEnabled next:(BOOL)nextEnabled {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    // Segmented control with next and prev buttons
    UIBarButtonItem *barSegment = [self getNextPrevButtons:previousEnabled :nextEnabled];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolbar.items = [NSArray arrayWithObjects:barSegment, flexButton, nil];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [toolbar setBarTintColor:self.navBarColor];
        [toolbar setTintColor:self.fontColor];
    } else {
        [toolbar setTintColor:self.navBarColor];
    }
    
    return toolbar;
}

- (UIToolbar *)getToolbarWithUIBarButtonSystemItem:(UIBarButtonSystemItem)item
{
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(userClickedDone:)];
    toolbar.items = [NSArray arrayWithObjects:flexButton, doneButton, nil];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [toolbar setBarTintColor:self.navBarColor];
        [toolbar setTintColor:self.fontColor];
    } else {
        [toolbar setTintColor:self.navBarColor];
    }
    
    return toolbar;
}

- (UIBarButtonItem *)getNextPrevButtons:(BOOL)prevEnabled :(BOOL)nextEnabled {
    UISegmentedControl *tabNavigation = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
//    tabNavigation.segmentedControlStyle = UISegmentedControlStyleBar;
    [tabNavigation setEnabled:prevEnabled forSegmentAtIndex:0];
    [tabNavigation setEnabled:nextEnabled forSegmentAtIndex:1];
    tabNavigation.momentary = YES;
    [tabNavigation addTarget:self action:@selector(segmentedControlHandler:) forControlEvents:UIControlEventValueChanged];
    
    return [[UIBarButtonItem alloc] initWithCustomView:tabNavigation];
}

- (UIBarButtonItem *)getDoneButton {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(userClickedDone:)];
}

/* Previous / Next segmented control changed value */
- (void)segmentedControlHandler:(id)sender
{
    switch ([(UISegmentedControl *)sender selectedSegmentIndex]) {
        case 0:
            if (self.delegate && [self.delegate respondsToSelector:@selector(previousClicked:)]) {
                [self.delegate previousClicked:self.currentSelectedTextboxIndex];
            }
            break;
        case 1:
            if (self.delegate && [self.delegate respondsToSelector:@selector(nextClicked:)]) {
                [self.delegate nextClicked:self.currentSelectedTextboxIndex];
            }
            break;
        default:
            break;
    }
}

- (void)userClickedDone:(id)sender {
    if ([self.delegate respondsToSelector:@selector(doneBtnTapped)]){
        [self.delegate doneBtnTapped];
    }
}

@end

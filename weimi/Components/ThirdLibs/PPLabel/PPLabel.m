//
//  PPLabel.m
//  PPLabel
//
//  Created by Petr Pavlik on 12/26/12.
//  Copyright (c) 2012 Petr Pavlik. All rights reserved.
//

#import "PPLabel.h"
#import <CoreText/CoreText.h>

@interface PPLabel ()

@property (nonatomic, copy) NSMutableDictionary *rangeDic;
@property (nonatomic, copy) NSMutableDictionary *nameDic;

@end

@implementation PPLabel

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        [self becomeFirstResponder];
    }
    return self;
}

- (NSString *)replaceStringFromString:(NSString *)name
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (int i = 0; i < name.length; i++) {
        [string appendString:@"*"];
    }
    return [string copy];
}

- (NSString *)getKeyFromText:(NSString *)text name:(NSString *)name
{
  
    NSMutableString *mText = [NSMutableString stringWithString:text];
    NSRange rangeName = [mText rangeOfString:name];
    NSString *key = NSStringFromRange(rangeName);
    if ([_rangeDic.allKeys containsObject:key]) {
        if (rangeName.length == name.length) {
            [mText replaceCharactersInRange:rangeName withString:[self replaceStringFromString:name]];
            key = [self getKeyFromText:mText name:name];
        }
    }
    return key;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (IsEmpty(text)) {
        return;
    }
    
    _rangeDic = [NSMutableDictionary dictionary];
    _nameDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < _clickUserCustomerIDs.count; i++) {
        [_nameDic setObject:_clickUserCustomerIDs[i] forKey:_clickNames[i]];
        NSString *value = _clickUserCustomerIDs[i];
        NSString *key = [self getKeyFromText:text name:_clickNames[i]];
        [_rangeDic setObject:value forKey:key];
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    NSString *text = attributedText.string;

    _rangeDic = [NSMutableDictionary dictionary];
    _nameDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < _clickUserCustomerIDs.count; i++) {
        [_nameDic setObject:_clickUserCustomerIDs[i] forKey:_clickNames[i]];
        NSString *value = _clickUserCustomerIDs[i];
        NSString *key = [self getKeyFromText:text name:_clickNames[i]];
        [_rangeDic setObject:value forKey:key];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (CFIndex)characterIndexAtPoint:(CGPoint)point {
    
    ////////
    NSLog(@"point %@",NSStringFromCGPoint(point));
    NSMutableAttributedString* optimizedAttributedText = [self.attributedText mutableCopy];
    
    [self.attributedText enumerateAttribute:(NSString*)kCTParagraphStyleAttributeName inRange:NSMakeRange(0, [optimizedAttributedText length]) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        
        if (!value) {
            return ;
        }
        NSMutableParagraphStyle* paragraphStyle = [value mutableCopy];
        
        if ([paragraphStyle lineBreakMode] == kCTLineBreakByTruncatingTail) {
            [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
        }
        
        [optimizedAttributedText removeAttribute:(NSString*)kCTParagraphStyleAttributeName range:range];
        [optimizedAttributedText addAttribute:(NSString*)kCTParagraphStyleAttributeName value:paragraphStyle range:range];
        
    }];
    
    ////////
    
    if (!CGRectContainsPoint(self.bounds, point)) {
        return NSNotFound;
    }
    
    CGRect textRect = [self textRect];
    
    NSLog(@"textRect %@",NSStringFromCGRect(textRect));
    
    if (!CGRectContainsPoint(textRect, point)) {
        return NSNotFound;
    }
    
    // Offset tap coordinates by textRect origin to make them relative to the origin of frame
    point = CGPointMake(point.x - textRect.origin.x, point.y - textRect.origin.y);
    // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
    point = CGPointMake(point.x, textRect.size.height - point.y);
    NSLog(@"point1 %@",NSStringFromCGPoint(point));
    //////
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)optimizedAttributedText);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [self.attributedText length]), path, NULL);
    
    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    
    //NSLog(@"num lines: %d", numberOfLines);
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }

    NSUInteger idx = NSNotFound;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        // Get bounding information of line
        CGFloat ascent, descent, leading, width;
        width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = floor(lineOrigin.y - descent);
        CGFloat yMax = ceil(lineOrigin.y + ascent);
        
        // Check if we've already passed the line
        if (point.y > yMax) {
            break;
        }
        
        // Check if the point is within this line vertically
        if (point.y >= yMin) {
            
            // Check if the point is within this line horizontally
            if (point.x >= lineOrigin.x && point.x <= lineOrigin.x + width) {
                
                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(point.x - lineOrigin.x, point.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                
                break;
            }
        }
    }
    
    CFRelease(frame);
    CFRelease(path);
    
    return idx;
}

#pragma mark --

- (CGRect)textRect {
    
    CGRect textRect = [self textRectForBounds:self.bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.origin.y = (self.bounds.size.height - textRect.size.height)/2;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        textRect.origin.x = (self.bounds.size.width - textRect.size.width)/2;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        textRect.origin.x = self.bounds.size.width - textRect.size.width;
    }
    
    return textRect;
}

#pragma mark --

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    __block NSString *result = nil;
    if (_clickKeyType == ClickKeyTypeKeyword) {
        NSArray *reversedArray = [[_clickNames reverseObjectEnumerator] allObjects];
        NSString *key = [self getKeyPoint:reversedArray touchPoint:point];
        result = _nameDic[key];
    }
    else {
        CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
        NSLog(@"index %ld",index);
        
        for (NSString *key in _rangeDic.allKeys) {
            NSRange rangeToCheck = NSRangeFromString(key);
            NSUInteger min = rangeToCheck.location;
            NSUInteger max = min + rangeToCheck.length;
            if (index >= min && index < max){
                result = _rangeDic[key];
                break;
            }
        }
    }

    NSLog(@"result %@",result);
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppLabel:didSelectKey:clickKeyType:)]) {
        [_delegate ppLabel:self didSelectKey:result clickKeyType:_clickKeyType];
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppLabel:didSelectKey:)]) {
        [_delegate ppLabel:self didSelectKey:result];
    }
    
    //    [self.delegate label:self didEndTouch:touch onCharacterAtIndex:index];
    
    [super touchesEnded:touches withEvent:event];
}

- (NSString *)getKeyPoint:(NSArray *)keywords touchPoint:(CGPoint) touchPoint
{
    NSString *result = @"";
    
    //获取UILabel上最后一个字符串的位置。
    CGPoint lastPoint;
    
    CGSize sz;
    
    CGSize linesSz = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if ([self.text containsString:@"\n"]) {
        sz = [[self.text stringByReplacingOccurrencesOfString:@"\n" withString:@""] sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, 14)];

        NSRange range = [self.text rangeOfString:@"\n" options:NSBackwardsSearch];
        
        CGFloat length = [[self.text substringFromIndex:range.location + 1] sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, 14)].width;
        lastPoint = CGPointMake(length, linesSz.height);
    }
    else {
        sz = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, 14)];
        
        if(sz.width <= linesSz.width) //判断是否折行
        {
            lastPoint = CGPointMake(sz.width, sz.height);
        }
        else
        {
            lastPoint = CGPointMake((int)sz.width % (int)linesSz.width + 3*(linesSz.height/sz.height),linesSz.height);
        }
    }
    
    int i=0;
    for (NSString *key in keywords) {
        
        CGFloat length = [key sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, 14)].width;
        
        if (lastPoint.x >= length) {
            
            if (i == 0) {
                if (touchPoint.x >= lastPoint.x - length && touchPoint.x <= lastPoint.x + 50  && touchPoint.y >= lastPoint.y - sz.height && touchPoint.y <= lastPoint.y + 5) {
                    
                    return key;
                }
            }
            else {
                if (touchPoint.x >= lastPoint.x - length && touchPoint.x <= lastPoint.x  && touchPoint.y >= lastPoint.y - sz.height && touchPoint.y <= lastPoint.y) {
                    
                    return key;
                }
            }
            
            lastPoint.x -= length;
            
            if (lastPoint.x == length) {
                
                lastPoint.x = linesSz.width;
                lastPoint.y -= sz.height;
            }
        }
        else {
            if (i == 0) {
                if ((touchPoint.x >=0 && touchPoint.x <= lastPoint.x + 50 && touchPoint.y >= lastPoint.y - sz.height && touchPoint.y <= lastPoint.y + 5) || (touchPoint.x >= (linesSz.width - length + lastPoint.x) && touchPoint.y >= (lastPoint.y - sz.height*2) && touchPoint.y <= (lastPoint.y - sz.height))) {
                    
                    return key;
                }
            }
            else {
                if ((touchPoint.x >=0 && touchPoint.x <= lastPoint.x && touchPoint.y >= lastPoint.y - sz.height && touchPoint.y <= lastPoint.y) || (touchPoint.x >= (linesSz.width - length + lastPoint.x) && touchPoint.y >= (lastPoint.y - sz.height*2) && touchPoint.y <= (lastPoint.y - sz.height))) {
                    
                    return key;
                }
            }
            
            lastPoint.x = linesSz.width - length + lastPoint.x;
            lastPoint.y -= sz.height;
        }
        
        i++;
    }
    
    return result;
}

@end

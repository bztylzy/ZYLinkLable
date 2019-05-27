//
//  ZYLinkLabel.m
//  可以点击的label
//
//  Created by lizongyao on 2019/5/27.
//  Copyright © 2019 lizongyao. All rights reserved.
//

#import "ZYLinkLabel.h"
@interface ZYLinkLabel()
@property (nonatomic, strong) NSMutableArray *ranges;
@end
@implementation ZYLinkLabel

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    for (NSValue *rangeV in _ranges) {
        NSRange range = [rangeV rangeValue];
        CGRect rect = [self boundingRectForCharacterRange:range];
        
        if (CGRectContainsPoint(rect, point)) {
            if (_linkBlock) {
                NSInteger index = [_ranges indexOfObject:rangeV];
                _linkBlock(index);
            }
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame text:(nonnull NSString *)text font:(nonnull UIFont *)font textAlignment:(NSTextAlignment)textAlignment textColor:(nonnull UIColor *)textColor linkStrings:(nonnull NSArray *)linkStrings linkColor:(nonnull UIColor *)linkColor
{
    if (self = [super initWithFrame:frame]) {
        self.font = font;
        self.numberOfLines = 0;
        self.textAlignment = textAlignment;
        self.textColor = textColor;
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
        NSRange textRange = NSMakeRange(0, att.length);
        [att addAttribute:NSFontAttributeName value:font range:textRange];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 2;
        paragraphStyle.alignment = self.textAlignment;
        [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:textRange];
        
        _ranges = [NSMutableArray array];
        for (NSString *str in linkStrings) {
            NSRange range = [text rangeOfString:str];
            [att addAttribute:NSForegroundColorAttributeName value:linkColor range:range];
            
            [_ranges addObject:[NSValue valueWithRange:range]];
        }
        self.attributedText = att;
        [self sizeToFit];
        
    }
    return self;
}


- (CGRect)boundingRectForCharacterRange:(NSRange)range{
    //创建textContainer
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.bounds.size];
    textContainer.lineFragmentPadding = 0;
    
    //创建layoutManager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    
    //创建textStorage
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    [textStorage addLayoutManager:layoutManager];
    
    //创建range
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

@end

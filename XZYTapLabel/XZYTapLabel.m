//
//  XZYTapLabel.m
//  XZYTapLabelDemo
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XZYTapLabel.h"

@interface XZYTapLabel ()
@property (strong,nonatomic) UIColor * tempColor;
@property (strong,nonatomic) NSMutableDictionary * tapRangeDic;

@property (strong,nonatomic) NSObject * tempObject;
@property (strong,nonatomic) NSAttributedString * tempAttributeString;
@end

@implementation XZYTapLabel


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInstancetype];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupInstancetype];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupInstancetype];
    }
    return self;
}

- (void)setupInstancetype{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.highlightedBackgroudColor = self.backgroundColor;
    self.highlightedTextBackgroudColor = self.backgroundColor;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tap];
}

- (void)setText:(NSString *)text{
    self.attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName:self.font}];
}

- (void)tapGesture:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    NSString * key = [self checkTapRangeWithPoint:point];
    self.tempObject = key ? [self.tapRangeDic objectForKey:key] : nil;
    if ([self.delegate respondsToSelector:@selector(XZYTapLabelDidtapWith:)]) {
        [self.delegate XZYTapLabelDidtapWith:self.tempObject];
    }
    
}

/// 返回点击已设置的taprange，否则为nil
- (NSString *)checkTapRangeWithPoint:(CGPoint)point{
    NSAttributedString * attring = self.attributedText;
    if (attring == nil) {
        attring = [[NSAttributedString alloc] initWithString:self.text  attributes:@{NSFontAttributeName:self.font}];
    }
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:attring];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    NSTextStorage * textstorage = [[NSTextStorage alloc]initWithAttributedString:attributedText];
    NSLayoutManager * manager = [[NSLayoutManager alloc]init];
    [textstorage addLayoutManager:manager];
    NSTextContainer * container = [[NSTextContainer alloc]initWithSize:self.bounds.size];
    container.lineFragmentPadding = 0;
    [manager addTextContainer:container];
    
    NSUInteger glyphIndex          = [manager glyphIndexForPoint:point inTextContainer:container];
    NSInteger tappedCharacterIndex = [manager characterIndexForGlyphAtIndex:glyphIndex];
    
    for (NSString * key  in self.tapRangeDic.allKeys) {
        NSRange range = NSRangeFromString(key);
        if (NSLocationInRange(tappedCharacterIndex, range)) {
            return key;
        }
    }
    return nil;
}






- (void)addTapRange:(NSRange)range with:(NSObject *)information{
    if (self.tapRangeDic == nil) {
        self.tapRangeDic = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    if (information) {
        [self.tapRangeDic setObject:information forKey:[NSValue valueWithRange:range].description];
    }
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    BOOL canHighlight = YES;
    NSString * rangeString = [self checkTapRangeWithPoint:point];
    if (rangeString) {
        canHighlight = NO;
        self.tempAttributeString = self.attributedText;
        NSMutableAttributedString * atring = [[NSMutableAttributedString alloc]initWithAttributedString:self.tempAttributeString];
        NSRange range = NSRangeFromString(rangeString);
        if (range.length + range.location <= atring.length) {
            [atring addAttribute:NSBackgroundColorAttributeName value:self.highlightedTextBackgroudColor range:range];
        }
        self.attributedText = atring;
        
    }
    if (canHighlight) {
        self.tempColor = self.backgroundColor;
        self.backgroundColor = self.highlightedBackgroudColor;
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    if (self.tempColor) {
        [self setBackgroundColor:self.tempColor];
    }
    
    if (self.tempAttributeString) {
        self.attributedText = self.tempAttributeString;
        self.tempAttributeString = nil;
    }
    if ([self.delegate respondsToSelector:@selector(XZYTapLabelDidCancelTouch)]) {
        [self.delegate XZYTapLabelDidCancelTouch];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.tempColor) {
        [self setBackgroundColor:self.tempColor];
    }
    if (self.tempAttributeString) {
        self.attributedText = self.tempAttributeString;
        self.tempAttributeString = nil;
    }
    if ([self.delegate respondsToSelector:@selector(XZYTapLabelDidCancelTouch)]) {
        [self.delegate XZYTapLabelDidCancelTouch];
    }
}
- (void)cleanTapRange{
    self.tapRangeDic = nil;
}
@end

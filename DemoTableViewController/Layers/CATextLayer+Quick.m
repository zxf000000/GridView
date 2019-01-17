//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "CATextLayer+Quick.h"


@implementation CATextLayer (Quick)


+ (CATextLayer *)zxf_textLayerWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
//create a text layer

    CGRect textFrame = [text boundingRectWithSize:frame.size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : font} context:nil];
    CGFloat x = frame.origin.x + (frame.size.width - textFrame.size.width) / 2;
    CGFloat y = frame.origin.y + (frame.size.height - textFrame.size.height) / 2;
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(x, y, textFrame.size.width, textFrame.size.height);

    //set text attributes
    textLayer.foregroundColor = color.CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
//    textLayer.truncationMode = kCATruncationMiddle;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    //choose a font

    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);

    //choose some text
    //set layer text
    textLayer.string = text;

    return textLayer;
}

- (void)caculateFrameFor:(CGRect)frame {

    CGRect textFrame = [self.string boundingRectWithSize:frame.size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.fontSize]} context:nil];
    CGFloat x = frame.origin.x + (frame.size.width - textFrame.size.width) / 2;
    CGFloat y = frame.origin.y + (frame.size.height - textFrame.size.height) / 2;
    self.frame = CGRectMake(x, y, textFrame.size.width, textFrame.size.height);
}

@end
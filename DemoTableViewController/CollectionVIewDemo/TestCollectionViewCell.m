//
//  TestCollectionViewCell.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/16.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell ()
@property (strong, nonatomic) CATextLayer *titleLayer;

@property (strong, nonatomic) CAShapeLayer  *bgLayer;

@property (strong, nonatomic) CAShapeLayer  *borderLayer;

@end

@implementation TestCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _borderLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_borderLayer];

        _bgLayer = [[CAShapeLayer alloc] init];
        [self.layer insertSublayer:_bgLayer atIndex:0];

        self.backgroundColor = [UIColor clearColor];
        _bgLayer.hidden = YES;

        _titleLayer = [CATextLayer layer];

        //set layer font
        UIFont *font = [UIFont systemFontOfSize:10];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _titleLayer.font = fontRef;
        _titleLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);


        _titleLayer.wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
        _titleLayer.alignmentMode = kCAAlignmentCenter;//字体的对齐方式
        _titleLayer.contentsScale = [UIScreen mainScreen].scale;//解决文字模糊 以Retina方式来渲染，防止画出来的文本像素化
        [self.layer addSublayer:_titleLayer];
    }
    return self;
}


- (void)setModel:(TestModel *)model {
    _model = model;

    _titleLayer.string = model.title;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat margin = 2;
    UIBezierPath *borderPath = [UIBezierPath bezierPath];
    [borderPath moveToPoint:(CGPointMake(0 , 0))];
    [borderPath addLineToPoint:(CGPointMake(width, 0))];
    [borderPath addLineToPoint:(CGPointMake(width, height))];
    [borderPath addLineToPoint:(CGPointMake(0, height))];
    [borderPath closePath];
    self.borderLayer.path = borderPath.CGPath;
    self.borderLayer.lineWidth = 1;
    self.borderLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;


    self.titleLayer.frame = CGRectMake(0, (height - 20)/ 2, width, 20);



    UIBezierPath *path = [UIBezierPath bezierPath];

    switch (self.model.bgType) {
        case BgTypeCircle:
        {
            self.bgLayer.hidden = NO;
            
            CGFloat radius = width > height ? height / 2 - margin : width / 2 - margin;
            [path addArcWithCenter:CGPointMake(width / 2, height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            self.titleLayer.foregroundColor =[UIColor whiteColor].CGColor;//字体的颜色 文本颜色

        }
            break;
        case BgTypeNone:
        {
            self.bgLayer.hidden = YES;
            self.titleLayer.foregroundColor =[UIColor blackColor].CGColor;//字体的颜色 文本颜色
            
            break;
        }
        case BgTypeSquare:
        {
            self.bgLayer.hidden = NO;
            
            CGFloat length = width > height ? height - margin * 2 : width - margin * 2;
            CGFloat leftPadding = (width - length)/2;
            CGFloat topPadding = margin;
            
            [path moveToPoint:(CGPointMake(leftPadding , topPadding))];
            [path addLineToPoint:(CGPointMake(leftPadding + length, topPadding))];
            [path addLineToPoint:(CGPointMake(length + leftPadding, length + topPadding))];
            [path addLineToPoint:(CGPointMake(leftPadding, length + topPadding))];
            [path closePath];

            self.titleLayer.foregroundColor =[UIColor whiteColor].CGColor;//字体的颜色 文本颜色
            
            break;
        }
        default:
        {
            self.bgLayer.hidden = NO;

            
            [path moveToPoint:(CGPointMake(0 , 0))];
            [path addLineToPoint:(CGPointMake(width, 0))];
            [path addLineToPoint:(CGPointMake(width, height))];
            [path addLineToPoint:(CGPointMake(0, height))];
            [path closePath];


            self.titleLayer.foregroundColor =[UIColor whiteColor].CGColor;//字体的颜色 文本颜色
            
        }
            break;
    }
    
    _bgLayer.path = path.CGPath;
    _bgLayer.lineWidth = 1;
    _bgLayer.strokeColor = [UIColor redColor].CGColor;
    _bgLayer.fillColor = [UIColor redColor].CGColor;
    
}

@end

//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormItemLayer.h"
#import <UIKit/UIKit.h>
#import "CATextLayer+Quick.h"

@interface ZXFFormItemLayer ()

@property(nonatomic, strong) CATextLayer *textLayer;

@property(nonatomic, strong) CAShapeLayer *bgLayer;

@end

@implementation ZXFFormItemLayer


- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    _textLayer.string = [NSString stringWithFormat:@"%zd",number];
}

- (void)setHasBg:(BOOL)hasBg {
    _hasBg = hasBg;
    if (!_hasBg) {
        _textLayer.foregroundColor = [UIColor blackColor].CGColor;
        _bgLayer.hidden = YES;
        return;
    }
    _bgLayer.hidden = NO;

}

- (void)setupUI {
//    _textLayer = [CATextLayer zxf_textLayerWithFrame:CGRectMake(0, 0, 50, 25) text:@"test" font:[UIFont systemFontOfSize:9] color:[UIColor whiteColor]];
    _textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.backgroundColor = [UIColor blueColor].CGColor;
    _bgLayer.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:1].CGColor;
    _bgLayer.strokeColor = [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1].CGColor;
    [self addSublayer:_bgLayer];
//    [self addSublayer:_textLayer];

}
- (void)layoutSublayers {

    [self.textLayer caculateFrameFor:self.bounds];
    [self setNeedsDisplay];

    if (!self.hasBg) {
        return;
    }
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat radius = 10;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];

    self.bgLayer.path = path.CGPath;
    
}

- (void)drawInContext:(CGContextRef)ctx {
    
    //2.绘图
    //2.1创建一条直线绘图的路径
    //注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CGMutablePathRef path=CGPathCreateMutable();
    //2.2把绘图信息添加到路径里
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, self.bounds.size.height);
    //2.3把路径添加到上下文中
    //把绘制直线的绘图信息保存到图形上下文中
    CGContextAddPath(ctx, path);
    
    //3.渲染
    CGContextStrokePath(ctx);
    
    //4.释放前面创建的两条路径
    //第一种方法
    CGPathRelease(path);
    
//    CGContextSetCharacterSpacing(ctx, 4);          //设置字符距
//    CGContextSetRGBFillColor(ctx, 1, 0, 1, 1);     //设置填充颜色
//    CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);     //设置线条颜色
//    CGContextSetTextDrawingMode(ctx, kCGTextFill); //设置使用填充模式绘制文字
    //绘制文字
//    [@"123" drawAtPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:9],NSFontAttributeName,[UIColor magentaColor],NSForegroundColorAttributeName, nil]];
}


@end

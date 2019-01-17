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
    _textLayer = [CATextLayer zxf_textLayerWithFrame:CGRectMake(0, 0, 50, 25) text:@"test" font:[UIFont systemFontOfSize:9] color:[UIColor whiteColor]];
    _textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.backgroundColor = [UIColor blueColor].CGColor;
    _bgLayer.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:1].CGColor;
    _bgLayer.strokeColor = [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1].CGColor;
    [self addSublayer:_bgLayer];
    [self addSublayer:_textLayer];

}
- (void)layoutSublayers {

    [self.textLayer caculateFrameFor:self.bounds];

    if (!self.hasBg) {
        return;
    }
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGFloat radius = 10;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];

    self.bgLayer.path = path.CGPath;
    

}


@end

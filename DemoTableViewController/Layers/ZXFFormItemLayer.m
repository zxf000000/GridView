//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormItemLayer.h"
#import <UIKit/UIKit.h>
#import "CATextLayer+Quick.h"

@interface ZXFFormItemLayer ()

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
    
}

- (void)setHasBg:(BOOL)hasBg {
    _hasBg = hasBg;
    if (!_hasBg) {
        _bgLayer.hidden = YES;
        return;
    }
    _bgLayer.hidden = NO;

}

- (void)setupUI {
    
    [self setContentsScale:[UIScreen mainScreen].scale];

    _bgLayer = [CAShapeLayer layer];
    _bgLayer.backgroundColor = [UIColor blueColor].CGColor;
    _bgLayer.fillColor = [UIColor colorWithRed:0.5 green:0.5 blue:0 alpha:1].CGColor;
    _bgLayer.strokeColor = [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1].CGColor;
    [self addSublayer:_bgLayer];

}
- (void)layoutSublayers {

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



@end

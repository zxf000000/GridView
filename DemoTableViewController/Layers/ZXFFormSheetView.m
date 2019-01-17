//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormSheetView.h"


@interface ZXFFormSheetView ()

@property(nonatomic, assign) CGFloat baseWidth;
@property(nonatomic, assign) CGFloat baseHeight;

@property(nonatomic, assign) BOOL hasVerticalLine;
@property(nonatomic, assign) BOOL hasHorizontalLine;

@property(nonatomic, assign) CGFloat verticalLineWidth;
@property(nonatomic, assign) CGFloat horizontalLineWidth;

@property(nonatomic, strong) UIColor *verticalLineColor;
@property(nonatomic, strong) UIColor *horizontalLineColor;

@property(nonatomic, assign) NSInteger rowCount;
@property(nonatomic, assign) NSInteger columnCount;


@property(nonatomic, strong) NSMutableArray *lineLayers;


@end


@implementation ZXFFormSheetView

- (instancetype)init {
    if (self = [super init]) {

        _lineLayers = [NSMutableArray array];

        [self initDefaultConfig];
    }
    return self;
}

- (void)initDefaultConfig {


    _baseHeight = 20.f;
    _baseWidth = 20.f;
    _hasHorizontalLine = YES;
    _hasVerticalLine = YES;
    _verticalLineWidth = 0.5;
    _horizontalLineWidth = 0.5;
    _verticalLineColor = [UIColor colorWithWhite:0.5 alpha:1];
    _horizontalLineColor = [UIColor colorWithWhite:0.5 alpha:1];


}

- (void)strokeForm {
    [self drawLine];

    self.contentSize = CGSizeMake(self.baseWidth * self.columnCount, self.baseHeight * self.rowCount);

}

- (void)setupUI {



}

- (void)drawLine {

    if ([self.delegate respondsToSelector:@selector(numberOfRowsForFormView:)]) {
        self.rowCount = [self.delegate numberOfRowsForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(numberOfColunmsForFormView:)]) {
        self.columnCount = [self.delegate numberOfColunmsForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(baseWidthForFormView:)]) {
        self.baseWidth = [self.delegate baseWidthForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(baseHeightForFormView:)]) {
        self.baseHeight = [self.delegate baseHeightForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(verticalLineColorForFormView:)]) {
        self.verticalLineColor = [self.delegate verticalLineColorForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(horizontalLineColorForFormView:)]) {
        self.horizontalLineColor = [self.delegate horizontalLineColorForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(hasHorizontalLineForFormView:)]) {
        self.hasHorizontalLine = [self.delegate hasHorizontalLineForFormView:self];
    }

    if ([self.delegate respondsToSelector:@selector(hasVerticalLineForFormView:)]) {
        self.hasVerticalLine = [self.delegate hasVerticalLineForFormView:self];
    }

    if (self.hasHorizontalLine) {
        for (int i = 0; i <= self.rowCount; ++i) {
            CGFloat fromX = 0;
            CGFloat y = i * self.baseHeight;
            CGFloat endX = self.baseWidth * self.rowCount;
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(fromX, y)];
            [bezierPath addLineToPoint:CGPointMake(endX, y)];

            CAShapeLayer *lineLayer = [self lineLayerWithWidth:self.horizontalLineWidth color:self.horizontalLineColor];
            lineLayer.path = bezierPath.CGPath;
            [self.layer addSublayer:lineLayer];
            [self.lineLayers addObject:lineLayer];
        }
    }

    if (self.hasVerticalLine) {
        for (int j = 0; j <= self.columnCount; ++j) {
            CGFloat x = j * self.baseWidth;
            CGFloat fromY = 0;
            CGFloat endY = self.baseHeight * self.rowCount;
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(x, fromY)];
            [bezierPath addLineToPoint:CGPointMake(x, endY)];

            CAShapeLayer *lineLayer = [self lineLayerWithWidth:self.verticalLineWidth color:self.verticalLineColor];
            lineLayer.path = bezierPath.CGPath;
            [self.layer addSublayer:lineLayer];
            [self.lineLayers addObject:lineLayer];
        }
    }

}




 - (CAShapeLayer *)lineLayerWithWidth:(CGFloat)width color:(UIColor *)color {
     CAShapeLayer *lineLayer = [CAShapeLayer layer];
     lineLayer.lineWidth = width;
     lineLayer.strokeColor = color.CGColor;
     lineLayer.fillColor = [UIColor clearColor].CGColor;
     return lineLayer;
}



@end
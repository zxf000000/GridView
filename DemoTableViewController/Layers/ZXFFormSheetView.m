//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormSheetView.h"
#import "ZXFFormItemLayout.h"



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
@property(nonatomic, strong) NSMutableArray *bgLayers;


@property(nonatomic, assign) NSInteger numberOfItems;


@end


@implementation ZXFFormSheetView

- (instancetype)init {
    if (self = [super init]) {

        _lineLayers = [NSMutableArray array];
        _bgLayers = [NSMutableArray array];

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

- (void)setupUI {



}

- (void)strokeForm {


    [self initConfig];
    self.contentSize = [self caculateContentSize];
    [self drawBackgroundColors];

    [self drawLine];

    [self drawItems];

}

- (void)drawItems {

    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsForFormView:)], @"必须实现datasource方法");
    NSAssert([self.dataSource respondsToSelector:@selector(sheetView:layoutForIndex:)], @"必须实现datasource方法");
    NSAssert([self.dataSource respondsToSelector:@selector(sheetView:itemForIndex:)], @"必须实现datasource方法");

    // 获取item数量
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsForFormView:)]) {
        self.numberOfItems = [self.dataSource numberOfItemsForFormView:self];
    }

    // 获取item位置
    for (NSInteger index = 0 ; index < self.numberOfItems; index++ ) {
        if (![self.dataSource respondsToSelector:@selector(sheetView:layoutForIndex:)]) {
            return;
        }

        ZXFFormItemLayout *layout = [self.dataSource sheetView:self layoutForIndex:index];
        CGFloat x = [self xForColumn:layout.column];
        CGFloat y = [self yForRow:layout.row];
        CGFloat width = layout.width * self.baseWidth;
        CGFloat height = layout.height * self.baseHeight;
        CGRect frame = CGRectMake(x, y, width, height);

        CALayer *layer = [self.dataSource sheetView:self itemForIndex:index];
        layer.frame = frame;
        [self.layer addSublayer:layer];
    }
}

- (void)drawBackgroundColors {

    if ([self.delegate respondsToSelector:@selector(sheetView:colorForColumn:)]) {
        // 纵向颜色
        for (NSInteger columnIndex = 0 ; columnIndex < self.columnCount; columnIndex++ ) {
            if (![self.delegate sheetView:self colorForColumn:columnIndex]) {
                continue;
            }
            UIColor *color = [self.delegate sheetView:self colorForColumn:columnIndex];
            CALayer *colorLayer = [CALayer layer];
            colorLayer.backgroundColor = color.CGColor;
            colorLayer.frame = CGRectMake([self xForColumn:columnIndex], 0, self.baseWidth, self.contentSize.height);
            [self.layer addSublayer:colorLayer];
            [self.bgLayers addObject:colorLayer];
        }
    }

    if ([self.delegate respondsToSelector:@selector(sheetView:colorForRow:)]) {
        // 横向颜色
        for (NSInteger rowIndex = 0; rowIndex < self.rowCount; rowIndex++) {
            if (![self.delegate sheetView:self colorForRow:rowIndex]) {
                continue;
            }
            UIColor *color = [self.delegate sheetView:self colorForRow:rowIndex];
            CALayer *colorLayer = [CALayer layer];
            colorLayer.backgroundColor = color.CGColor;
            colorLayer.frame = CGRectMake( 0, [self yForRow:rowIndex], self.contentSize.width, self.baseHeight);
            [self.layer addSublayer:colorLayer];
            [self.bgLayers addObject:colorLayer];
        }
    }
}


- (void)drawLine {


    if (self.hasHorizontalLine) {
        for (int i = 0; i <= self.rowCount; ++i) {
            CGFloat fromX = 0;
            CGFloat y = i * self.baseHeight + i * self.horizontalLineWidth;
            CGFloat endX = self.baseWidth * self.columnCount + self.horizontalLineWidth * (self.columnCount + 1);
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
            CGFloat x = j * self.baseWidth + j * self.verticalLineWidth;
            CGFloat fromY = 0;
            CGFloat endY = self.baseHeight * self.rowCount + (self.rowCount + 1) * self.verticalLineWidth;
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

- (void)initConfig {

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
}

- (CGFloat)yForRow:(NSInteger)row {
    CGFloat y = row * self.baseHeight;
    if (self.hasHorizontalLine) {
        y += (row + 1) * self.verticalLineWidth;
    }
    return y;
}


- (CGFloat)xForColumn:(NSInteger)column {
    CGFloat x = column * self.baseWidth;
    if (self.hasVerticalLine) {
        x += (column + 1) * self.horizontalLineWidth;
    }
    return x;
}


 - (CAShapeLayer *)lineLayerWithWidth:(CGFloat)width color:(UIColor *)color {
     CAShapeLayer *lineLayer = [CAShapeLayer layer];
     lineLayer.lineWidth = width;
     lineLayer.strokeColor = color.CGColor;
     lineLayer.fillColor = [UIColor clearColor].CGColor;
     return lineLayer;
}

- (CGSize)caculateContentSize {
    return CGSizeMake(self.baseWidth * self.columnCount + (self.columnCount + 1) * self.horizontalLineWidth, self.baseHeight * self.rowCount + (self.rowCount + 1) * self.verticalLineWidth);
}

@end
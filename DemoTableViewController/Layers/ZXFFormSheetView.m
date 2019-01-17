//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormSheetView.h"
#import "ZXFFormItemLayout.h"



typedef void(^CompleteHandle)(void);

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


@property(nonatomic, strong) NSMutableArray *gridLineLayers;
@property(nonatomic, strong) NSMutableArray *bgLayers;

@property(nonatomic, strong) NSMutableArray *lineLayers;

@property(nonatomic, assign) NSInteger numberOfItems;

@property(nonatomic, strong) NSMutableArray *layouts;

@property(nonatomic, strong) NSMutableDictionary *linePoints;

/*辅助layer 用于item 和 连接线的层次区分*/
@property(nonatomic, strong) CALayer *bgAssistLayer;
@property(nonatomic, strong) CALayer *itemAssistLayer;

@property(nonatomic, strong) UIActivityIndicatorView *myActivity;

@end


@implementation ZXFFormSheetView

- (instancetype)init {
    if (self = [super init]) {

        _gridLineLayers = [NSMutableArray array];
        _bgLayers = [NSMutableArray array];
        _layouts = [NSMutableArray array];
        _lineLayers = [NSMutableArray array];
        _linePoints = [NSMutableDictionary dictionary];
        [self setupUI];
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


    self.bounces = NO;

    _bgAssistLayer = [CALayer layer];
    _bgAssistLayer.backgroundColor = [UIColor clearColor].CGColor;

    _itemAssistLayer = [CALayer layer];
    _itemAssistLayer.backgroundColor = [UIColor clearColor].CGColor;


}

- (void)layoutSubviews {

    self.bgAssistLayer.frame = self.bounds;
    self.itemAssistLayer.frame = self.bounds;
}

- (void)strokeForm {
    self.alpha = 0;

    [self initConfig];

    [self.layer addSublayer:self.bgAssistLayer];

    [self startIndicator];
    __weak typeof(self) weakSelf = self;
    [self caculateFramesWithComplete:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;

        [strongSelf drawBackgroundColors];
        [strongSelf drawGridLine];

        [strongSelf drawItems];
        [strongSelf drawLines];
        [strongSelf endIndicator];
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    }];


}


- (void)caculateFramesWithComplete:(CompleteHandle)complete {
    NSAssert([self.dataSource respondsToSelector:@selector(sheetView:layoutForIndex:)], @"必须实现datasource方法");
    NSAssert([self.dataSource respondsToSelector:@selector(numberOfItemsForFormView:)], @"必须实现datasource方法");



    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获取item数量
        if ([self.dataSource respondsToSelector:@selector(numberOfItemsForFormView:)]) {
            self.numberOfItems = [self.dataSource numberOfItemsForFormView:self];
        }

        NSMutableSet *lineSet = [NSMutableSet set];

        // 计算所有item位置
        for (NSInteger index = 0 ; index < self.numberOfItems; index++ ) {
            ZXFFormItemLayout *layout = [self.dataSource sheetView:self layoutForIndex:index];
            CGFloat x = [self xForColumn:layout.column];
            CGFloat y = [self yForRow:layout.row];
            CGFloat width = layout.width * self.baseWidth;
            CGFloat height = layout.height * self.baseHeight;
            CGRect frame = CGRectMake(x, y, width, height);
            [layout setFrame:frame];
            [self.layouts addObject:layout];

            // 计算line count
            if (layout.hasLinePoint) {
                NSNumber *lineNumber = @(layout.lineSerialNumber);
                if (self.linePoints[lineNumber]) {
                    NSMutableArray *points = self.linePoints[lineNumber];
                    [points addObject:layout];
                    self.linePoints[lineNumber] = points;
                } else {
                    NSMutableArray *points = [NSMutableArray array];
                    [points addObject:layout];
                    self.linePoints[lineNumber] = points;
                }
            }

        }
        dispatch_async(dispatch_get_main_queue(), ^{
           complete();
        });
    });

}

- (void)startIndicator {
    _myActivity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];

    //设置等待指示器的颜色

    //设置等待指示器的位置(center-中心)
    _myActivity.center = self.center;

    //给等待指示器设置倒圆角
    _myActivity.layer.cornerRadius = 5;
    _myActivity.layer.masksToBounds = YES;

    //设置上面转着的圆圈的颜色
    _myActivity.color = [UIColor blackColor];


    //将等待指示器添加到手机界面上
    [self addSubview:_myActivity];

    //!!!很重要，让它可以显示并转动起来
    [_myActivity startAnimating];
}

- (void)endIndicator {
    [_myActivity stopAnimating];
    [_myActivity removeFromSuperview];
}

- (void)drawItems {

    NSAssert([self.dataSource respondsToSelector:@selector(sheetView:itemForIndex:)], @"必须实现datasource方法");

    [self.layer insertSublayer:self.itemAssistLayer above:self.bgAssistLayer];

    // 获取item位置
    for (NSInteger index = 0 ; index < self.numberOfItems; index++ ) {

        ZXFFormItemLayout *layout = self.layouts[index];

        CALayer *layer = [self.dataSource sheetView:self itemForIndex:index];
        layer.frame = layout.frame;
        if (layout.hasLinePoint) {
            [self.layer insertSublayer:layer above:self.itemAssistLayer];
        } else {
            [self.layer insertSublayer:layer below:self.itemAssistLayer];
        }

    }
}

- (void)drawLines {

    [self.linePoints enumerateKeysAndObjectsUsingBlock:^(NSNumber * lineNumber, NSMutableArray * points, BOOL *stop) {

        NSInteger count = 0;
        CGPoint lastPoint = CGPointZero;
        UIColor *color = [lineNumber integerValue] == 1 ? [UIColor redColor] : [UIColor blueColor];
        for (int pointIndex = 0, length = points.count; pointIndex < length; ++pointIndex) {
            ZXFFormItemLayout *layout = points[pointIndex];
            CGFloat x = layout.frame.origin.x + layout.frame.size.width / 2;
            CGFloat y = layout.frame.origin.y + layout.frame.size.height / 2;
            CGPoint point = CGPointMake(x, y);
            if (count != 0) {
                UIBezierPath *path = [UIBezierPath bezierPath];
                [path moveToPoint:lastPoint];
                [path addLineToPoint:point];
                CAShapeLayer *lineLayer = [CAShapeLayer layer];
                lineLayer.strokeColor = color.CGColor;
                lineLayer.lineWidth = 1.f;
                lineLayer.path = path.CGPath;
                [self.layer insertSublayer:lineLayer below:self.itemAssistLayer];
                [self.lineLayers addObject:lineLayer];
            }
            count += 1;
            lastPoint = point;
        }

    }];

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
//            [self.layer addSublayer:colorLayer];
            [self.layer insertSublayer:colorLayer below:self.bgAssistLayer];

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
            [self.layer insertSublayer:colorLayer below:self.bgAssistLayer];
//            [self.layer addSublayer:colorLayer];
            [self.bgLayers addObject:colorLayer];
        }
    }
}


- (void)drawGridLine {


    if (self.hasHorizontalLine) {
        for (int i = 0; i <= self.rowCount; ++i) {
            CGFloat fromX = 0;
            CGFloat y = i * self.baseHeight + i * self.horizontalLineWidth;
            CGFloat endX = [self xForColumn:self.columnCount];
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(fromX, y)];
            [bezierPath addLineToPoint:CGPointMake(endX, y)];

            CAShapeLayer *lineLayer = [self lineLayerWithWidth:self.horizontalLineWidth color:self.horizontalLineColor];
            lineLayer.path = bezierPath.CGPath;
            [self.layer addSublayer:lineLayer];
            [self.gridLineLayers addObject:lineLayer];
        }
    }

    if (self.hasVerticalLine) {
        for (int j = 0; j <= self.columnCount; ++j) {
            CGFloat x = j * self.baseWidth + j * self.verticalLineWidth;
            CGFloat fromY = 0;
            CGFloat endY = [self yForRow:self.rowCount];
            UIBezierPath *bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint:CGPointMake(x, fromY)];
            [bezierPath addLineToPoint:CGPointMake(x, endY)];

            CAShapeLayer *lineLayer = [self lineLayerWithWidth:self.verticalLineWidth color:self.verticalLineColor];
            lineLayer.path = bezierPath.CGPath;
            [self.layer addSublayer:lineLayer];
            [self.gridLineLayers addObject:lineLayer];
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

    self.contentSize = [self caculateContentSize];

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
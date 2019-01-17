//
// Created by 云舟02 on 2019-01-03.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "DemoTableView.h"
@interface DemoTableView ()

@property(nonatomic, assign) NSInteger rowCount;
@property(nonatomic, assign) NSInteger columnCount;

@property(nonatomic, copy) NSArray *heights;
@property(nonatomic, copy) NSArray *actualYs;

@property(nonatomic, copy) NSArray *widths;
@property(nonatomic, copy) NSArray *actualXs;

@property(nonatomic, copy) NSMutableArray *frames;

@property(nonatomic, assign) CGFloat itemWidth;
@property(nonatomic, assign) CGFloat itemHeight;

@end

@implementation DemoTableView

- (instancetype)initWithRowCount:(NSInteger)rowCount columnCount:(NSInteger)columnCount frame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSAssert(rowCount > 0, @"rowCount must > 0");
        NSAssert(columnCount > 0, @"columnCount must > 0");
        _rowCount = rowCount;
        _columnCount = columnCount;
        self.bounces = NO;
        [self initCommit];
    }
    return self;
}

- (void)initCommit {
    self.backgroundColor = [UIColor whiteColor];
    // set default value
    _fontSize = 13;
    _minWidth = 0;
    _minHeight = 0;
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self caculateSize];
    _rowCount = _datas.count;
    _columnCount = [_datas[0] count];
    _frames = [NSMutableArray arrayWithCapacity:_rowCount];
    for (NSInteger i = 0; i < _rowCount ; i++) {
        [_frames addObject:[NSMutableArray arrayWithCapacity:_columnCount]];
    }
}

- (void)caculateSize {

    // 计算高度
//    CGFloat horizontalPadding;
//    if ([self.demoDelegate respondsToSelector:@selector(demoTableView:widthForColumn:)]) {
//        [self.demoDelegate demoTableView:self widthForColumn:0];
//    }

    CGFloat horizontalPadding = [self horizontalPadding];
    // 高度自适应
    // 宽度平均
    // 先找出最长的一组数据
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSArray *rowDatas in _datas) {
        NSString *largestStr = @"";
        for (NSString *text in rowDatas) {
            if (text.length > largestStr.length) {
                largestStr = text;
            }
        }
        [tempArray addObject:largestStr];
    }
    // 计算总高度
    NSMutableArray *heights = [NSMutableArray array];
    CGFloat totalHeight = 0.f;
    for (NSString *text in tempArray) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(horizontalPadding, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.fontSize]} context:nil];
        [heights addObject:@(frame.size.height)];
        totalHeight += frame.size.height;
    }
    // 计算每一行的y值 (以横线为参考,包含最下面一条线)
    // 保存每一行的高度
    NSMutableArray *actualyYs = [NSMutableArray array];
    NSMutableArray *actualHeights = [NSMutableArray array];
    [actualyYs addObject:@(0.f)];
    for (NSInteger i = 0 ; i < heights.count ; i ++) {
        NSNumber *number = heights[i];
        CGFloat height = [number doubleValue] / totalHeight * self.bounds.size.height;
        // 防止数据行数过多造成计算出来的高度小于文字高度
        if (height < [number doubleValue]) {
            height = [number doubleValue];
        }
        // 适配最低高度
        if (height < self.minHeight) {
            height = self.minHeight;
        }

        if (i == 0) {
            [actualyYs addObject:@(height)];
        } else {
            NSNumber *lastNumber = actualyYs[i];
            [actualyYs addObject:@(height + [lastNumber doubleValue])];
        }
        [actualHeights addObject:@(height)];
    }
    _actualYs = actualyYs.copy;
    _heights = actualHeights.copy;
    self.contentSize = CGSizeMake(horizontalPadding * self.columnCount, [_actualYs.lastObject doubleValue]);
}

- (void)strokeTable {

    [self addLines];

    [self drawItems];

    [self addTestLines];
    [self setNeedsDisplay];
}

- (void)drawItems {
    // 计算所有textLayer的frame
    CGFloat horizontalPadding = [self horizontalPadding];
    for (int i = 0; i < self.rowCount; i++) {
        NSMutableArray *array = self.frames[i];
        for (int j = 0; j < self.columnCount; j++) {
            CGFloat x = j * horizontalPadding;
            CGFloat y = [self.actualYs[i] doubleValue];
            CGFloat height = [self.heights[i] doubleValue];
            [self drawTextLayerWithFrame:CGRectMake(x, y, horizontalPadding, height) text:self.datas[i][j]];
            [array addObject:NSStringFromCGRect(CGRectMake(x, y, horizontalPadding, height))];
        }
    }
}

- (void)addTestLines {

    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0, length = self.frames.count; i < length ; i ++) {
        NSInteger count = [self.frames[i] count];
        NSString *rectStr = self.frames[i][arc4random()%count];
        CGRect frame = CGRectFromString(rectStr);
        CGPoint center = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
        if (i == 0) {
            [path moveToPoint:center];
        } else {
            [path addLineToPoint:center];
        }
    }

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 1;
    layer.strokeColor = [UIColor blueColor].CGColor;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineJoin = kCALineJoinRound;
    [self.layer insertSublayer:layer atIndex:0];

}

- (void)addLines {

    CGFloat horizontalPadding = [self horizontalPadding];

    for (NSInteger i = 0 ; i <= self.rowCount; i ++) {
        UIBezierPath *topPath = [UIBezierPath bezierPath];
        if (i == 0) {
            [topPath moveToPoint:CGPointMake(0, 0)];
            [topPath addLineToPoint:CGPointMake(self.contentSize.width, 0)];
        } else {
            CGFloat y = [self.actualYs[i] doubleValue];
            [topPath moveToPoint:CGPointMake(0, y)];
            [topPath addLineToPoint:CGPointMake(self.contentSize.width, y)];
        }
        [topPath stroke];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 1;
        layer.strokeColor = [UIColor lightGrayColor].CGColor;
        layer.path = topPath.CGPath;
        [self.layer addSublayer:layer];
    }

    for (NSInteger j = 0; j <= self.columnCount; j++) {
        UIBezierPath *topPath = [UIBezierPath bezierPath];
        [topPath moveToPoint:CGPointMake(j * horizontalPadding, 0)];
        [topPath addLineToPoint:CGPointMake(j * horizontalPadding, self.contentSize.height)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 1;
        layer.strokeColor = [UIColor lightGrayColor].CGColor;
        layer.path = topPath.CGPath;
        [self.layer addSublayer:layer];    }
}


- (void)drawTextLayerWithFrame:(CGRect)frame text:(NSString *)text {
//create a text layer

    CGRect textFrame = [text boundingRectWithSize:frame.size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.fontSize]} context:nil];
    CGFloat x = frame.origin.x + (frame.size.width - textFrame.size.width) / 2;
    CGFloat y = frame.origin.y + (frame.size.height - textFrame.size.height) / 2;
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(x, y, textFrame.size.width, textFrame.size.height);

    [self.layer addSublayer:textLayer];

    //set text attributes
    textLayer.foregroundColor = [UIColor whiteColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.wrapped = YES;
//    textLayer.truncationMode = kCATruncationMiddle;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:self.fontSize];

    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);

    //choose some text
    //set layer text
    textLayer.string = text;
    textLayer.backgroundColor = [UIColor redColor].CGColor;
}

- (CGFloat)horizontalPadding {
    return self.bounds.size.width / self.columnCount > self.minWidth ? self.bounds.size.width / self.columnCount : self.minWidth;
}

@end
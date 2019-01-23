//
//  YZMovementsCollectionViewCell.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/18.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "YZMovementsCollectionViewCell.h"
#import <YYText.h>
#import "YZMovementsModel.h"
#import <YYAsyncLayer.h>

#define ssRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

CGFloat const YZMovementsCellBallMargin = 5.f;
@interface YZMovementsCollectionViewCell()

@property (strong, nonatomic) YYLabel *titleLabel;
@property (strong, nonatomic) CAShapeLayer  *bgLayer;

@property (strong, nonatomic) CAShapeLayer  *leftBorderLayer;
@property(nonatomic, strong) CAShapeLayer *rightBorderLayer;

@property(nonatomic, strong) UIColor *darkDataColor;
@property(nonatomic, strong) UIColor *dataColor;
@property(nonatomic, strong) UIColor *titleColor;

@property(nonatomic, strong) UIBezierPath *circlepath;
@property(nonatomic, strong) UIBezierPath *squarePath;
@property(nonatomic, strong) UIBezierPath *allPath;

@end

@implementation YZMovementsCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _rightBorderLayer = [CAShapeLayer layer];
        _rightBorderLayer.lineWidth = 0.25;
        _rightBorderLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
        _rightBorderLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_rightBorderLayer];

        _leftBorderLayer = [CAShapeLayer layer];
        _leftBorderLayer.lineWidth = 0.25;
        _leftBorderLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
        _leftBorderLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_leftBorderLayer];

        _bgLayer = [[CAShapeLayer alloc] init];
        _bgLayer.lineWidth = 1;
        [self.layer insertSublayer:_bgLayer atIndex:0];

        self.backgroundColor = [UIColor clearColor];
        _bgLayer.hidden = YES;

        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.frame = self.bounds;


        _titleColor = [UIColor colorWithRed:240/255.0 green:235/255.0 blue:229/255.0 alpha:1.0];
        _dataColor = [UIColor colorWithRed:248/255.0 green:247/255.0 blue:243/255.0 alpha:1.0];
        _darkDataColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];

        [self addSubview:_titleLabel];

        [self setupLayers];
//
//        CGFloat width = self.bounds.size.width;
//        CGFloat height = self.bounds.size.height;

//        UIBezierPath *leftBorderPath = [UIBezierPath bezierPath];
//        [leftBorderPath moveToPoint:(CGPointMake(0 , 0))];
//        [leftBorderPath addLineToPoint:(CGPointMake(0, height))];
//        _leftBorderLayer.path = leftBorderPath.CGPath;
//
//        UIBezierPath *rightBorderPath = [UIBezierPath bezierPath];
//        [rightBorderPath moveToPoint:(CGPointMake(width , 0))];
//        [rightBorderPath addLineToPoint:(CGPointMake(width, height))];
//        _rightBorderLayer.path = rightBorderPath.CGPath;


    }
    return self;
}

- (void)setupLayers {
    _allPath = [UIBezierPath bezierPath];
    [_allPath moveToPoint:(CGPointMake(0 , 0))];
    [_allPath addLineToPoint:(CGPointMake(self.bounds.size.width, 0))];
    [_allPath addLineToPoint:(CGPointMake(self.bounds.size.width, self.bounds.size.height))];
    [_allPath addLineToPoint:(CGPointMake(0, self.bounds.size.height))];
    [_allPath closePath];

    _squarePath = [UIBezierPath bezierPath];
    CGFloat length = MIN(self.bounds.size.width, self.bounds.size.height) - YZMovementsCellBallMargin * 2;
    CGFloat leftPadding = (MAX(self.bounds.size.width, self.bounds.size.height) - MIN(self.bounds.size.width, self.bounds.size.height))/2;
    CGFloat topPadding = YZMovementsCellBallMargin;
    [_squarePath moveToPoint:(CGPointMake(leftPadding , topPadding))];
    [_squarePath addLineToPoint:(CGPointMake(leftPadding + length, topPadding))];
    [_squarePath addLineToPoint:(CGPointMake(length + leftPadding, length + topPadding))];
    [_squarePath addLineToPoint:(CGPointMake(leftPadding, length + topPadding))];
    [_squarePath closePath];

    _circlepath = [UIBezierPath bezierPath];
    CGFloat radius = (MIN(self.bounds.size.width, self.bounds.size.height)) / 2 - YZMovementsCellBallMargin;
    [_circlepath addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
}

- (void)setModel:(YZMovementsModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    switch (model.type) {
        case YZMovementsModelPositionLeft: {
            if (model.row % 2 == 0) {
                self.backgroundColor = _titleColor;
            } else {
                self.backgroundColor = _dataColor;
            }
            break;
        }
        case YZMovementsModelPositionDefault:{
            if (model.row % 2 == 0) {
                self.backgroundColor = _darkDataColor;
            } else {
                self.backgroundColor = _dataColor;
            }
            break;
        }
        case YZMovementsModelPositionTop: {
            if (model.row % 2 == 0) {
                self.backgroundColor = _titleColor;
            } else {
                self.backgroundColor = _dataColor;
            }
            break;
        }
    }

    switch (self.model.ballColor) {

        case YZMovementsModelBallColorRed:
        {
            _bgLayer.strokeColor = [UIColor redColor].CGColor;
            _bgLayer.fillColor = [UIColor redColor].CGColor;
        }
        break;
        case YZMovementsModelBallColorBlue:{
            _bgLayer.strokeColor = [UIColor blueColor].CGColor;
            _bgLayer.fillColor = [UIColor blueColor].CGColor;
        }
        break;
        case YZMovementsModelBallColorBig: {
            _bgLayer.strokeColor = ssRGBHex(0xFFDCB9).CGColor;
            _bgLayer.fillColor = ssRGBHex(0xFFDCB9).CGColor;
        }
        break;
        case YZMovementsModelBallColorSmall: {
            _bgLayer.strokeColor = ssRGBHex(0xC9F4E9).CGColor;
            _bgLayer.fillColor = ssRGBHex(0xC9F4E9).CGColor;
        }
        break;
        case YZMovementsModelBallColorOther: {

        }
        break;
    }

    if (_model.isPercent) {
        _bgLayer.hidden = NO;
        _bgLayer.strokeColor = [UIColor redColor].CGColor;
        _bgLayer.fillColor = [UIColor redColor].CGColor;
        _bgLayer.path = [self percentPathWithPercent:self.model.percent * 3].CGPath;
        _titleLabel.textColor = [UIColor clearColor];
    }
    
    switch (self.model.bgType) {
        case BgTypeCircle:
        {
            self.bgLayer.hidden = NO;
            self.bgLayer.path = self.circlepath.CGPath;
            if (self.model.ballColor == YZMovementsModelBallColorRed || self.model.ballColor == YZMovementsModelBallColorBlue) {
                self.titleLabel.textColor = [UIColor whiteColor];
            }
        }
            break;
        case BgTypeNone:
        {
            self.bgLayer.hidden = YES;
            self.titleLabel.textColor = [UIColor blackColor];
            break;
        }
        case BgTypeSquare:
        {
            self.bgLayer.hidden = NO;
            self.bgLayer.path = self.squarePath.CGPath;
            if (self.model.ballColor == YZMovementsModelBallColorRed || self.model.ballColor == YZMovementsModelBallColorBlue) {
                self.titleLabel.textColor = [UIColor whiteColor];
            }
            break;
        }
        default:
        {
            self.bgLayer.hidden = NO;
            _bgLayer.path = self.allPath.CGPath;
            if (self.model.ballColor == YZMovementsModelBallColorRed || self.model.ballColor == YZMovementsModelBallColorBlue) {
                self.titleLabel.textColor = [UIColor whiteColor];
            }
        }
            break;
    }

//    [self setNeedsLayout];
}

- (void)layoutSubviews {
//    [super layoutSubviews];

    _titleLabel.frame = self.bounds;
    

}

- (UIBezierPath *)circlepath {
    if (!_circlepath) {
        _circlepath = [UIBezierPath bezierPath];
        CGFloat radius = (MIN(self.bounds.size.width, self.bounds.size.height)) / 2 - YZMovementsCellBallMargin;
        [_circlepath addArcWithCenter:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    }
    return _circlepath;
}

- (UIBezierPath *)squarePath {
    if (!_squarePath) {
        _squarePath = [UIBezierPath bezierPath];
        CGFloat length = MIN(self.bounds.size.width, self.bounds.size.height) - YZMovementsCellBallMargin * 2;
        CGFloat leftPadding = (MAX(self.bounds.size.width, self.bounds.size.height) - MIN(self.bounds.size.width, self.bounds.size.height))/2;
        CGFloat topPadding = YZMovementsCellBallMargin;

        [_squarePath moveToPoint:(CGPointMake(leftPadding , topPadding))];
        [_squarePath addLineToPoint:(CGPointMake(leftPadding + length, topPadding))];
        [_squarePath addLineToPoint:(CGPointMake(length + leftPadding, length + topPadding))];
        [_squarePath addLineToPoint:(CGPointMake(leftPadding, length + topPadding))];
        [_squarePath closePath];
    }
    return _squarePath;
}

- (UIBezierPath *)allPath {
    if (!_allPath) {
        _allPath = [UIBezierPath bezierPath];
        [_allPath moveToPoint:(CGPointMake(0 , 0))];
        [_allPath addLineToPoint:(CGPointMake(self.bounds.size.width, 0))];
        [_allPath addLineToPoint:(CGPointMake(self.bounds.size.width, self.bounds.size.height))];
        [_allPath addLineToPoint:(CGPointMake(0, self.bounds.size.height))];
        [_allPath closePath];
    }
    return _allPath;
}

- (UIBezierPath *)percentPathWithPercent:(CGFloat)percent {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat topMargin = self.bounds.size.height / 4;
    CGFloat height = self.bounds.size.height / 2;
    CGFloat totalWidth = self.bounds.size.width * percent;
    [path moveToPoint:CGPointMake(0, topMargin)];
    [path addLineToPoint:CGPointMake(totalWidth, topMargin)];
    [path addLineToPoint:CGPointMake(totalWidth, topMargin + height)];
    [path addLineToPoint:CGPointMake(0, topMargin + height)];
    [path closePath];
    return path;
}

- (void)drawRect:(CGRect)rect {
//
//    [[UIColor colorWithWhite:0.5 alpha:1] setStroke];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(0, 0)];
//    [path addLineToPoint:CGPointMake(0, rect.size.height)];
//    path.lineWidth = 0.25;
//    [path stroke];
//
//    UIBezierPath *path1 = [UIBezierPath bezierPath];
//    [path1 moveToPoint:CGPointMake(rect.size.width, 0)];
//    [path1 addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
//    path1.lineWidth = 0.25;
//    [path1 stroke];

}

@end

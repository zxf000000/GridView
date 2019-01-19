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
CGFloat const YZMovementsCellBallMargin = 5.f;
@interface YZMovementsCollectionViewCell()

@property (strong, nonatomic) YYLabel *titleLabel;
@property (strong, nonatomic) CAShapeLayer  *bgLayer;

@property (strong, nonatomic) CAShapeLayer  *borderLayer;

@property(nonatomic, strong) UIColor *darkDataColor;
@property(nonatomic, strong) UIColor *dataColor;
@property(nonatomic, strong) UIColor *titleColor;

@end

@implementation YZMovementsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//
//        _borderLayer = [CAShapeLayer layer];
//        [self.layer addSublayer:_borderLayer];

        _bgLayer = [[CAShapeLayer alloc] init];
        [self.layer insertSublayer:_bgLayer atIndex:0];

        self.backgroundColor = [UIColor clearColor];
        _bgLayer.hidden = YES;

        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;



        _titleColor = [UIColor colorWithRed:240/255.0 green:235/255.0 blue:229/255.0 alpha:1.0];
        _dataColor = [UIColor colorWithRed:248/255.0 green:247/255.0 blue:243/255.0 alpha:1.0];
        _darkDataColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];

        [self addSubview:_titleLabel];

    }
    return self;
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
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat margin = YZMovementsCellBallMargin;
//    UIBezierPath *borderPath = [UIBezierPath bezierPath];
//    [borderPath moveToPoint:(CGPointMake(0 , 0))];
//    [borderPath addLineToPoint:(CGPointMake(width, 0))];
//    [borderPath addLineToPoint:(CGPointMake(width, height))];
//    [borderPath addLineToPoint:(CGPointMake(0, height))];
//    [borderPath closePath];
//    self.borderLayer.path = borderPath.CGPath;
//    self.borderLayer.lineWidth = 0.25;
//    self.borderLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
//    self.borderLayer.fillColor = [UIColor clearColor].CGColor;

    self.titleLabel.frame = self.bounds;

    UIBezierPath *path = [UIBezierPath bezierPath];

    switch (self.model.bgType) {
        case BgTypeCircle:
        {
            self.bgLayer.hidden = NO;
            CGFloat radius = width > height ? height / 2 - margin : width / 2 - margin;
            [path addArcWithCenter:CGPointMake(width / 2, height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            self.titleLabel.textColor = [UIColor whiteColor];

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

            CGFloat length = width > height ? height - margin * 2 : width - margin * 2;
            CGFloat leftPadding = (width - length)/2;
            CGFloat topPadding = margin;

            [path moveToPoint:(CGPointMake(leftPadding , topPadding))];
            [path addLineToPoint:(CGPointMake(leftPadding + length, topPadding))];
            [path addLineToPoint:(CGPointMake(length + leftPadding, length + topPadding))];
            [path addLineToPoint:(CGPointMake(leftPadding, length + topPadding))];
            [path closePath];

            self.titleLabel.textColor = [UIColor whiteColor];

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

            self.titleLabel.textColor = [UIColor whiteColor];

        }
            break;
    }

    _bgLayer.path = path.CGPath;
    _bgLayer.lineWidth = 1;
    if (self.model.ballColor == YZMovementsModelBallColorRed) {
        _bgLayer.strokeColor = [UIColor redColor].CGColor;
        _bgLayer.fillColor = [UIColor redColor].CGColor;
    } else if (self.model.ballColor == YZMovementsModelBallColorBlue){
        _bgLayer.strokeColor = [UIColor blueColor].CGColor;
        _bgLayer.fillColor = [UIColor blueColor].CGColor;
    }


}

- (void)drawRect:(CGRect)rect {

    [[UIColor colorWithWhite:0.5 alpha:1] setStroke];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, rect.size.height)];
    path.lineWidth = 0.25;
    [path stroke];

    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(rect.size.width, 0)];
    [path1 addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    path1.lineWidth = 0.25;
    [path1 stroke];

}

@end

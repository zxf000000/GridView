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

@interface YZMovementsCollectionViewCell()

@property (strong, nonatomic) YYLabel *titleLabel;
@property (strong, nonatomic) CAShapeLayer  *bgLayer;

@property (strong, nonatomic) CAShapeLayer  *borderLayer;

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

        [self addSubview:_titleLabel];

        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)setModel:(YZMovementsModel *)model {
    _model = model;
    _titleLabel.text = model.title;

    if (model.row % 2 == 0) {
        self.backgroundColor = [UIColor colorWithRed:245.f/255.f green:246.f/255.f blue:239.f/255.f alpha:1];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat margin = 2;
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
    _bgLayer.strokeColor = [UIColor redColor].CGColor;
    _bgLayer.fillColor = [UIColor redColor].CGColor;

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

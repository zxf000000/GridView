//
//  DemoCollectionViewCell.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "DemoCollectionViewCell.h"
#import <YYLabel.h>

@interface DemoCollectionViewCell ()
//@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) YYLabel *titleLabel;
@property (strong, nonatomic) CAShapeLayer  *bgLayer;

@property (strong, nonatomic) CAShapeLayer  *borderLayer;

@end

@implementation DemoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        _borderLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_borderLayer];

        _bgLayer = [[CAShapeLayer alloc] init];
        [self.layer insertSublayer:_bgLayer atIndex:0];

        self.backgroundColor = [UIColor clearColor];
        _bgLayer.hidden = YES;

        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.displaysAsynchronously = YES;
//        _titleLabel.ignoreCommonProperties = YES;

        [self addSubview:_titleLabel];
    }
    return self;
}


- (void)setModel:(TestModel *)model {
    _model = model;
    _titleLabel.text = model.title;

    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat margin = 2;
    UIBezierPath *borderPath = [UIBezierPath bezierPath];
    [borderPath moveToPoint:(CGPointMake(0 , 0))];
    [borderPath addLineToPoint:(CGPointMake(width, 0))];
    [borderPath addLineToPoint:(CGPointMake(width, height))];
    [borderPath addLineToPoint:(CGPointMake(0, height))];
    [borderPath closePath];
    self.borderLayer.path = borderPath.CGPath;
    self.borderLayer.lineWidth = 1;
    self.borderLayer.strokeColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;

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

@end

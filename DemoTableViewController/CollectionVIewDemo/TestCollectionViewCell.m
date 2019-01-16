//
//  TestCollectionViewCell.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/16.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell ()

@property (strong, nonatomic) CAShapeLayer  *bgLayer;

@property (strong, nonatomic) CAShapeLayer  *borderLayer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelCenterXConstant;

@end

@implementation TestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.borderLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.borderLayer];
    _bgLayer = [[CAShapeLayer alloc] init];
    [self.layer insertSublayer:_bgLayer atIndex:0];
    
    self.backgroundColor = [UIColor clearColor];
    self.bgLayer.hidden = YES;

}

- (void)setModel:(TestModel *)model {
    _model = model;
    
    
    _titleLabel.text = model.title;

    [self bringSubviewToFront:self.titleLabel];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat margin = 2;
    if (self.model.height > 1) {
        self.layer.masksToBounds = NO;
//        self.labelCenterXConstant.constant = self.bounds.size.height * self.model.height / 2.f;
        self.labelCenterXConstant.constant = 10.f;

    } else {
        self.layer.masksToBounds = YES;
        self.labelCenterXConstant.constant = 0.f;
    }
    
    UIBezierPath *borderPath = [UIBezierPath bezierPath];
    [borderPath moveToPoint:(CGPointMake(0 , 0))];
    [borderPath addLineToPoint:(CGPointMake(width, 0))];
    [borderPath addLineToPoint:(CGPointMake(width, height))];
    [borderPath addLineToPoint:(CGPointMake(0, height))];
    [borderPath closePath];
    self.borderLayer.path = borderPath.CGPath;
    self.borderLayer.lineWidth = 1;
    self.borderLayer.strokeColor = [UIColor redColor].CGColor;
    self.borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];

    switch (self.model.bgType) {
        case BgTypeCircle:
        {
            self.bgLayer.hidden = NO;
            
            CGFloat radius = width > height ? height / 2 - margin : width / 2 - margin;
            [path addArcWithCenter:CGPointMake(width / 2, height / 2) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
            
            _titleLabel.textColor = [UIColor whiteColor];
            
        }
            break;
        case BgTypeNone:
        {
            self.bgLayer.hidden = YES;
            _titleLabel.textColor = [UIColor blackColor];
            
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
            
            _titleLabel.textColor = [UIColor whiteColor];
            
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
            
            
            _titleLabel.textColor = [UIColor whiteColor];
            
        }
            break;
    }
    
    _bgLayer.path = path.CGPath;
    _bgLayer.lineWidth = 1;
    _bgLayer.strokeColor = [UIColor redColor].CGColor;
    _bgLayer.fillColor = [UIColor redColor].CGColor;
    
}

@end

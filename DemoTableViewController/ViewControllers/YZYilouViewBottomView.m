//
// Created by 云舟02 on 2019-01-22.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZYilouViewBottomView.h"

NSString *const YZYilouViewBottomViewId = @"YZYilouViewBottomViewId";

@interface YZYilouViewBottomView ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation YZYilouViewBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:11];
    _titleLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    _titleLabel.text = @"[平均遗漏] 指多期遗漏的平均值\n"
                       "[最大遗漏] 历史上遗漏的最大值\n"
                       "[上次遗漏] 指该号码上次开出之前的遗漏次数\n"
                       "[本次遗漏] 指该号码自上次开出之后的遗漏次数\n"
                       "[欲出几率] 本期遗漏/平均遗漏";
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];


//    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:1];
//    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:1];
//    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:1];
//    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:1];
//
//    [self addConstraint:top];
//    [self addConstraint:left];
//    [self addConstraint:width];
//    [self addConstraint:height];


}

- (void)layoutSubviews {
    CGRect rect = [_titleLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width - 30, 3000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11]} context:nil];
    _titleLabel.frame = CGRectMake(15, 12, rect.size.width, rect.size.height);

}

@end
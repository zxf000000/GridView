//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CATextLayer (Quick)

+ (CATextLayer *)zxf_textLayerWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font color:(UIColor *)color;
- (void)caculateFrameFor:(CGRect)frame;

@end
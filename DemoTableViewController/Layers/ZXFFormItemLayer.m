//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormItemLayer.h"
#import <UIKit/UIKit.h>
#import "CATextLayer+Quick.h"

@interface ZXFFormItemLayer ()

@property(nonatomic, strong) CATextLayer *textLayer;

@end

@implementation ZXFFormItemLayer


- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _textLayer = [CATextLayer zxf_textLayerWithFrame:CGRectMake(0, 0, 50, 25) text:@"test" font:[UIFont systemFontOfSize:12] color:[UIColor lightGrayColor]];

    [self addSublayer:_textLayer];
}

- (void)layoutSublayers {

    [self.textLayer caculateFrameFor:self.bounds];

}

@end
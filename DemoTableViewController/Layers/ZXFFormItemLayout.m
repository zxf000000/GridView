//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormItemLayout.h"


@implementation ZXFFormItemLayout
- (instancetype)initWithRow:(NSInteger)row column:(NSInteger)column width:(NSInteger)width height:(NSInteger)height {
    self = [super init];
    if (self) {
        self.row = row;
        self.column = column;
        self.width = width;
        self.height = height;
    }

    return self;
}

+ (instancetype)layoutWithRow:(NSInteger)row column:(NSInteger)column width:(NSInteger)width height:(NSInteger)height {
    return [[self alloc] initWithRow:row column:column width:width height:height];
}

@end
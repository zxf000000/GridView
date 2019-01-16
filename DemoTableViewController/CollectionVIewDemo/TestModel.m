//
//  TestModel.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/16.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

- (instancetype)initWithWidth:(NSInteger)width height:(NSInteger)height hasLinePoint:(BOOL)hasLinePoint bgType:(BgType)type title:(NSString *)title {
    if (self = [super init]) {
        _width = width;
        _hasLinePoint = hasLinePoint;
        _bgType = type;
        _title = title;
        _height = height;
    }
    return self;
}

@end

//
// Created by 云舟02 on 2019-01-15.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "DemoDataModel.h"


@implementation DemoDataModel {

}
- (instancetype)initWithType:(DemoDataModelType)type hasBg:(BOOL)hasBg hasBgCorner:(BOOL)hasBgCorner {
    self = [super init];
    if (self) {
        self.type = type;
        self.hasBg = hasBg;
        self.hasBgCorner = hasBgCorner;
    }

    return self;
}

+ (instancetype)modelWithType:(DemoDataModelType)type hasBg:(BOOL)hasBg hasBgCorner:(BOOL)hasBgCorner {
    return [[self alloc] initWithType:type hasBg:hasBg hasBgCorner:hasBgCorner];
}

@end
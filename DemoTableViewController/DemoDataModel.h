//
// Created by 云舟02 on 2019-01-15.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DemoDataModelType) {
    DemoDataModelTypeText,
};


@interface DemoDataModel : NSObject

@property(nonatomic, assign) DemoDataModelType type;
@property(nonatomic, assign) BOOL hasBg;
@property(nonatomic, assign) BOOL hasBgCorner;

- (instancetype)initWithType:(DemoDataModelType)type hasBg:(BOOL)hasBg hasBgCorner:(BOOL)hasBgCorner;

+ (instancetype)modelWithType:(DemoDataModelType)type hasBg:(BOOL)hasBg hasBgCorner:(BOOL)hasBgCorner;

@end
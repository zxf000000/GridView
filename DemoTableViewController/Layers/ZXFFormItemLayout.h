//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZXFFormItemLayout : NSObject

@property(nonatomic, assign) NSInteger row;
@property(nonatomic, assign) NSInteger column;
@property(nonatomic, assign) NSInteger width;
@property(nonatomic, assign) NSInteger height;

- (instancetype)initWithRow:(NSInteger)row column:(NSInteger)column width:(NSInteger)width height:(NSInteger)height;

+ (instancetype)layoutWithRow:(NSInteger)row column:(NSInteger)column width:(NSInteger)width height:(NSInteger)height;


@end
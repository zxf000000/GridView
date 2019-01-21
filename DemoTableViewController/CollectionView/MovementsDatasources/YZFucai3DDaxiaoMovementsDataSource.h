//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZBaseMovementsDataSource.h"


@interface YZFucai3DDaxiaoMovementsDataSource :  YZBaseMovementsDataSource

- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete;

- (void)loadJiouDataWithhHandle:(LoadDataCompleteHandle)complete;

- (void)loadZhiheWithhHandle:(LoadDataCompleteHandle)complete;

@end
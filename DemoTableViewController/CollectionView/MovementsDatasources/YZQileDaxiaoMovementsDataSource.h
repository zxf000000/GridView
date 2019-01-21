//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZBaseMovementsDataSource.h"


@interface YZQileDaxiaoMovementsDataSource : YZBaseMovementsDataSource

- (void)loadJiouDataWithhHandle:(LoadDataCompleteHandle)complete;

- (void)loadDaxiaoWithHandle:(LoadDataCompleteHandle)complete;

@end
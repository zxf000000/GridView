//
// Created by 云舟02 on 2019-01-22.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZBaseMovementsDataSource.h"


@interface YZ11Xuan5HezhiMovementsDataSource : YZBaseMovementsDataSource  <YZMovementsViewDelegate>

- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete;

- (void)loadQianyiDataWithHandle:(LoadDataCompleteHandle)complete;

@end
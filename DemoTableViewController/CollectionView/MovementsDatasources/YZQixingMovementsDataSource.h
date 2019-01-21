//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZMovementsView.h"
#import "YZBaseMovementsDataSource.h"

@interface YZQixingMovementsDataSource : YZBaseMovementsDataSource  <YZMovementsViewDelegate>

- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete;

@property(nonatomic, assign) NSInteger index;

@end
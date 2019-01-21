//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZMovementsView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface YZBaseMovementsDataSource : NSObject <YZMovementsViewDelegate>


@property(nonatomic, copy) NSArray *datas;
@property(nonatomic, copy) NSArray *topTitles;
@property(nonatomic, copy) NSArray *leftTitles;

- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete;


@end
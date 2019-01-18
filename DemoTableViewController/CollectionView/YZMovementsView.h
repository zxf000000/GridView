//
// Created by 云舟02 on 2019-01-18.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZMovementsModel;
@class YZMovementsView;

@protocol YZMovementsViewDelegate<NSObject>

@required
// 行列数
- (NSInteger)numberOfColumnsForMovementsView:(YZMovementsView *)view;
- (NSInteger)rowOfColumnsForMovementsView:(YZMovementsView *)view;

// 头部标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view topTitleModelForIndex:(NSInteger)index;
- (NSInteger)numberOfTopTitleForMovementsView:(YZMovementsView *)view;

// 左侧标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view leftTitleModelForIndex:(NSInteger)index;
- (NSInteger)numberOfleftTitleForMovementsView:(YZMovementsView *)view;

// 数据
- (YZMovementsModel *)movementsView:(YZMovementsView *)view dataModelForIndex:(NSInteger)index;
- (NSInteger)numberOfItemForMovementsView:(YZMovementsView *)view;

- (CGSize)itemSizeForMovementsView:(YZMovementsView *)view;

@end


@interface YZMovementsView : UIView

- (instancetype)initWithDelegate:(id<YZMovementsViewDelegate>)delegate;

@end

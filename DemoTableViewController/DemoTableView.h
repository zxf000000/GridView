//
// Created by 云舟02 on 2019-01-03.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DemoTableView;

@protocol DemoTableViewDataSource <NSObject>

- (NSInteger)demoTableView:(DemoTableView *)demoView numberOfItemForRow:(NSInteger)row;
- (NSInteger)columnsForDemoTableView:(DemoTableView *)demoView;

- (CGFloat)demoTableView:(DemoTableView *)demoView heightOfRow:(NSInteger)row;
- (CGFloat)demoTableView:(DemoTableView *)demoView widthForColumn:(NSInteger)column;

@end



@interface DemoTableView : UIScrollView

@property (nonatomic, weak) id<DemoTableViewDataSource> demoDelegate;

@property(nonatomic, assign) NSInteger fontSize;

@property(nonatomic, copy) NSArray *datas;

@property(nonatomic, assign) CGFloat minHeight;
@property(nonatomic, assign) CGFloat minWidth;

@property(nonatomic, copy) NSArray *heightValues;
@property(nonatomic, copy) NSArray *widthValues;

- (instancetype)initWithRowCount:(NSInteger)rowCount columnCount:(NSInteger)columnCount frame:(CGRect)frame;

- (void)strokeTable;

@end
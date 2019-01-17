//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXFFormItemLayout;

@protocol ZXFFormSheetViewDelegate;
@protocol ZXFFormSheetViewDataSource;

@interface ZXFFormSheetView : UIScrollView


- (void)strokeForm;

@property (nonatomic, weak) id<ZXFFormSheetViewDelegate> delegate;
@property (nonatomic, weak) id<ZXFFormSheetViewDataSource> dataSource;


@end



@protocol ZXFFormSheetViewDelegate <NSObject>

@optional

- (NSInteger)numberOfRowsForFormView:(ZXFFormSheetView *)sheetView;

- (NSInteger)numberOfColunmsForFormView:(ZXFFormSheetView *)sheetView;

- (CGFloat)baseWidthForFormView:(ZXFFormSheetView *)sheetView;
- (CGFloat)baseHeightForFormView:(ZXFFormSheetView *)sheetView;
- (BOOL)hasHorizontalLineForFormView:(ZXFFormSheetView *)sheetView;
- (BOOL)hasVerticalLineForFormView:(ZXFFormSheetView *)sheetView;
- (UIColor *)verticalLineColorForFormView:(ZXFFormSheetView *)sheetView;
- (UIColor *)horizontalLineColorForFormView:(ZXFFormSheetView *)sheetView;

- (UIColor *)sheetView:(ZXFFormSheetView *)sheet colorForColumn:(NSInteger)index;
- (UIColor *)sheetView:(ZXFFormSheetView *)sheet colorForRow:(NSInteger)index;


@end

@protocol ZXFFormSheetViewDataSource <NSObject>

@required

- (NSInteger)numberOfItemsForFormView:(ZXFFormSheetView *)sheetView;

- (ZXFFormItemLayout *)sheetView:(ZXFFormSheetView *)sheet layoutForIndex:(NSInteger)index;

- (CALayer *)sheetView:(ZXFFormSheetView *)sheet itemForIndex:(NSInteger)index;


@end
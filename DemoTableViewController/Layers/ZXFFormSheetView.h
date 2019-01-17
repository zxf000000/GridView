//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXFFormSheetViewDelegate;


@interface ZXFFormSheetView : UIScrollView


- (void)strokeForm;

@property (nonatomic, weak) id<ZXFFormSheetViewDelegate> delegate;


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



@end
//
//  ZXFLeftTitleViewDelegate.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/17.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "ZXFLeftTitleViewDelegate.h"
#import "ZXFFormItemLayer.h"
#import "ZXFFormItemLayout.h"

@implementation ZXFLeftTitleViewDelegate

#pragma mark - ZXFFormSheetViewDataSource

- (NSInteger)numberOfItemsForFormView:(ZXFFormSheetView *)sheetView {
    return 30;
}

- (ZXFFormItemLayout *)sheetView:(ZXFFormSheetView *)sheet layoutForIndex:(NSInteger)index {
    
    return [ZXFFormItemLayout layoutWithRow:index column:0 width:1 height:1 hasLinePoint:NO lineSerialNumber:-1];
    
}

- (CALayer *)sheetView:(ZXFFormSheetView *)sheet itemForIndex:(NSInteger)index {
    
    ZXFFormItemLayer *layer = [[ZXFFormItemLayer alloc]init];
    layer.number = 200;
    layer.hasBg = NO;
    return layer;
}


#pragma mark - ZXFFormSheetViewDelegate

- (NSInteger)numberOfRowsForFormView:(ZXFFormSheetView *)sheetView {
    return 30;
}

- (NSInteger)numberOfColunmsForFormView:(ZXFFormSheetView *)sheetView {
    return 1;
}

- (CGFloat)baseWidthForFormView:(ZXFFormSheetView *)sheetView {
    return 50;
}

- (CGFloat)baseHeightForFormView:(ZXFFormSheetView *)sheetView {
    return 25;
}

- (BOOL)hasHorizontalLineForFormView:(ZXFFormSheetView *)sheetView {
    return NO;
}

- (BOOL)hasVerticalLineForFormView:(ZXFFormSheetView *)sheetView {
    return NO;
}

- (UIColor *)verticalLineColorForFormView:(ZXFFormSheetView *)sheetView {
    return [UIColor grayColor];
}

- (UIColor *)horizontalLineColorForFormView:(ZXFFormSheetView *)sheetView {
    return [UIColor grayColor];
}

- (UIColor *)sheetView:(ZXFFormSheetView *)sheet colorForColumn:(NSInteger)index {
    
    return nil;
    //    return index % 2 == 0 ? [UIColor colorWithWhite:0.8 alpha:1] : [UIColor clearColor];
    
}

- (UIColor *)sheetView:(ZXFFormSheetView *)sheet colorForRow:(NSInteger)index {
    return nil;
}

@end

//
//  ZXFTopTitleViewDelegare.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/17.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "ZXFTopTitleViewDelegare.h"
#import "ZXFFormItemLayer.h"
#import "ZXFFormItemLayout.h"

@implementation ZXFTopTitleViewDelegare

#pragma mark - ZXFFormSheetViewDataSource

- (NSInteger)numberOfItemsForFormView:(ZXFFormSheetView *)sheetView {
    return 60;
}

- (ZXFFormItemLayout *)sheetView:(ZXFFormSheetView *)sheet layoutForIndex:(NSInteger)index {
    
    return [ZXFFormItemLayout layoutWithRow:index / 30 column:index % 30 width:1 height:1 hasLinePoint:NO lineSerialNumber:-1];
    
}

- (CALayer *)sheetView:(ZXFFormSheetView *)sheet itemForIndex:(NSInteger)index {
    
    ZXFFormItemLayer *layer = [[ZXFFormItemLayer alloc]init];
    layer.number = 1000;
    layer.hasBg = NO;

    return layer;
}


#pragma mark - ZXFFormSheetViewDelegate

- (NSInteger)numberOfRowsForFormView:(ZXFFormSheetView *)sheetView {
    return 2;
}

- (NSInteger)numberOfColunmsForFormView:(ZXFFormSheetView *)sheetView {
    return 30;
}

- (CGFloat)baseWidthForFormView:(ZXFFormSheetView *)sheetView {
    return 50;
}

- (CGFloat)baseHeightForFormView:(ZXFFormSheetView *)sheetView {
    return 25;
}

- (BOOL)hasHorizontalLineForFormView:(ZXFFormSheetView *)sheetView {
    return YES;
}

- (BOOL)hasVerticalLineForFormView:(ZXFFormSheetView *)sheetView {
    return YES;
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
    return index % 2 == 0 ? [UIColor colorWithWhite:0.8 alpha:1] : [UIColor clearColor];
}

@end

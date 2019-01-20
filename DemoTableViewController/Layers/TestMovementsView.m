//
//  TestMovementsView.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/17.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "TestMovementsView.h"
#import "ZXFFormSheetView.h"
#import "ZXFFormItemLayout.h"
#import "ZXFFormItemLayer.h"
#import "ZXFTopTitleViewDelegare.h"
#import "ZXFLeftTitleViewDelegate.h"

@interface TestMovementsView () <ZXFFormSheetViewDelegate,ZXFFormSheetViewDataSource, UIScrollViewDelegate>

@property(nonatomic, strong) ZXFFormSheetView *dataFormView;

@property(nonatomic, strong) ZXFFormSheetView *topTitleView;
@property(nonatomic, strong) ZXFFormSheetView *leftTitleView;

@property (strong, nonatomic) ZXFTopTitleViewDelegare  *topDelegate;
@property (strong, nonatomic) ZXFLeftTitleViewDelegate  *leftDelegate;


@end

@implementation TestMovementsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
//
    _dataFormView = [[ZXFFormSheetView alloc] init];
    [self addSubview:_dataFormView];
    _dataFormView.formDelegate = self;
    _dataFormView.formDataSource = self;
    _dataFormView.delegate = self;
    _dataFormView.backgroundColor = [UIColor whiteColor];
    
    _leftTitleView = [[ZXFFormSheetView alloc] init];
    [self addSubview:_leftTitleView];
    _leftDelegate = [[ZXFLeftTitleViewDelegate alloc] init];
    _leftTitleView.formDelegate = _leftDelegate;
    _leftTitleView.formDataSource = _leftDelegate;
    _leftTitleView.delegate = self;
    _leftTitleView.backgroundColor = [UIColor whiteColor];
    
    _topTitleView = [[ZXFFormSheetView alloc] init];
    [self addSubview:_topTitleView];
    _topDelegate = [[ZXFTopTitleViewDelegare alloc] init];
    _topTitleView.formDelegate = _topDelegate;
    _topTitleView.formDataSource = _topDelegate;
    _topTitleView.delegate = self;
    _topTitleView.backgroundColor = [UIColor whiteColor];
    
    [self.dataFormView strokeForm];
    [self.topTitleView strokeForm];
    [self.leftTitleView strokeForm];
}


- (void)willMoveToSuperview:(UIView *)newSuperview {

}

- (void)layoutSubviews {
    
    _dataFormView.frame = CGRectMake(50, 50, self.bounds.size.width, self.bounds.size.height - 50);
    _leftTitleView.frame = CGRectMake(0, 50, 50, self.bounds.size.height - 50);
    _topTitleView.frame = CGRectMake(50, 0, self.bounds.size.width - 50, 50);
}

#pragma mark - ZXFFormSheetViewDataSource

- (NSInteger)numberOfItemsForFormView:(ZXFFormSheetView *)sheetView {
    return 900;
}

- (ZXFFormItemLayout *)sheetView:(ZXFFormSheetView *)sheet layoutForIndex:(NSInteger)index {
    
    if (index % 31 == 0) {
        return [ZXFFormItemLayout layoutWithRow:index / 30 column:index % 30 width:1 height:1 hasLinePoint:YES lineSerialNumber:1];
    } else if (index % 32 == 0) {
        return [ZXFFormItemLayout layoutWithRow:index / 30 column:index % 30 width:1 height:1 hasLinePoint:YES lineSerialNumber:2];
    } else {
        return [ZXFFormItemLayout layoutWithRow:index / 30 column:index % 30 width:1 height:1 hasLinePoint:NO lineSerialNumber:-1];
    }
}

- (CALayer *)sheetView:(ZXFFormSheetView *)sheet itemForIndex:(NSInteger)index {
    
    ZXFFormItemLayer *layer = [[ZXFFormItemLayer alloc]init];
    layer.number = index;
    if (index % 31 == 0 || index % 32 == 0) {
        layer.hasBg = YES;
    } else {
        layer.hasBg = NO;
    }
    return layer;
    
}


#pragma mark - ZXFFormSheetViewDelegate

- (NSInteger)numberOfRowsForFormView:(ZXFFormSheetView *)sheetView {
    return 30;
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
//    return index % 2 == 0 ? [UIColor colorWithWhite:0.8 alpha:1] : nil;
    return nil;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.dataFormView) {
        CGPoint offset = self.topTitleView.contentOffset;
        CGPoint offsetLeft = self.leftTitleView.contentOffset;
        offset.x = self.dataFormView.contentOffset.x;
        offsetLeft.y = self.dataFormView.contentOffset.y;
        self.topTitleView.contentOffset = offset;
        self.leftTitleView.contentOffset = offsetLeft;
    } else if (scrollView == self.leftTitleView) {
        CGPoint offset = self.dataFormView.contentOffset;
        offset.y = self.leftTitleView.contentOffset.y;
        self.dataFormView.contentOffset = offset;
    } else if (scrollView == self.topTitleView) {
        CGPoint offset = self.dataFormView.contentOffset;
        offset.x = self.topTitleView.contentOffset.x;
        self.dataFormView.contentOffset = offset;
    }
}


@end

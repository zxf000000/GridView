//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormViewController.h"
#import "ZXFFormSheetView.h"
#import "ZXFFormItemLayout.h"
#import "YYFPSLabel.h"
#import "ZXFFormItemLayer.h"


@interface ZXFFormViewController() <ZXFFormSheetViewDelegate,ZXFFormSheetViewDataSource>

@property(nonatomic, strong) ZXFFormSheetView *dataFormView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end




@implementation ZXFFormViewController




#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];


}

#pragma mark - Custom Accessors

#pragma mark - Actions

#pragma mark - Network

#pragma mark - Public

#pragma mark - Private

#pragma mark - UITableViewDataSource/delegate

#pragma mark - YUZSuperclass

#pragma mark - NSObject

#pragma mark - initUI

- (void)setupUI {

    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kScreenHeight = [UIScreen mainScreen].bounds.size.height;

    CGFloat kNavigationBarHeight = self.navigationController.navigationBar.bounds.size.height;


    _dataFormView = [[ZXFFormSheetView alloc] init];
    _dataFormView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);

    [self.view addSubview:_dataFormView];
    _dataFormView.delegate = self;
    _dataFormView.dataSource = self;
    _dataFormView.backgroundColor = [UIColor whiteColor];
    [_dataFormView strokeForm];
}

#pragma mark - ZXFFormSheetViewDataSource

- (NSInteger)numberOfItemsForFormView:(ZXFFormSheetView *)sheetView {
    return 100;
}

- (ZXFFormItemLayout *)sheetView:(ZXFFormSheetView *)sheet layoutForIndex:(NSInteger)index {
    return [ZXFFormItemLayout layoutWithRow:index / 30 column:index % 30 width:1 height:1];
}

- (CALayer *)sheetView:(ZXFFormSheetView *)sheet itemForIndex:(NSInteger)index {

    ZXFFormItemLayer *layer = [[ZXFFormItemLayer alloc]init];

    return layer;
}


#pragma mark - ZXFFormSheetViewDelegate

- (NSInteger)numberOfRowsForFormView:(ZXFFormSheetView *)sheetView {
    return 100;
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
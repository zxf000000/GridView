//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormViewController.h"
#import "ZXFFormSheetView.h"

@interface ZXFFormViewController() <ZXFFormSheetViewDelegate>

@property(nonatomic, strong) ZXFFormSheetView *dataFormView;

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

    CGFloat kNavigationBarHeight = [UINavigationBar appearance].bounds.size.height;


    _dataFormView = [[ZXFFormSheetView alloc] init];
    _dataFormView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);

    [self.view addSubview:_dataFormView];
    _dataFormView.delegate = self;
    _dataFormView.backgroundColor = [UIColor whiteColor];
    [_dataFormView strokeForm];
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
    return 50;
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




@end
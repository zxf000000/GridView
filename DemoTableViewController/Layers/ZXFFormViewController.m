//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormViewController.h"
#import "ZXFFormSheetView.h"
#import "ZXFFormItemLayout.h"
#import "YYFPSLabel.h"
#import "ZXFFormItemLayer.h"
#import "TestMovementsView.h"

@interface ZXFFormViewController()

@property(nonatomic, strong) TestMovementsView *dataFormView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@end




@implementation ZXFFormViewController


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];

}

- (void)tap {
//    ZXFFormViewController *formVC = [[ZXFFormViewController alloc] init];
//    [self.navigationController pushViewController:formVC animated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

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


    _dataFormView = [[TestMovementsView alloc] init];
    _dataFormView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);

    [self.view addSubview:_dataFormView];


}

- (void)dealloc {
    NSLog(@"==========+>>>>>>>>>>>>> 销毁");
    
}

@end

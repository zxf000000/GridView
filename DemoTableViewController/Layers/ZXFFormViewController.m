//
// Created by 云舟02 on 2019-01-17.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "ZXFFormViewController.h"
#import "ZXFFormSheetView.h"
#import "ZXFFormItemLayout.h"
#import "ZXFFormItemLayer.h"
#import "TestMovementsView.h"

@interface ZXFFormViewController()

@property(nonatomic, strong) TestMovementsView *dataFormView;
@property(nonatomic, strong) TestMovementsView *dataFormView1;
@property(nonatomic, strong) TestMovementsView *dataFormView2;


@property (strong, nonatomic) UISegmentedControl  *segment;

@property (strong, nonatomic) UIScrollView  *scrollView;


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

- (void)change {
    [self.scrollView setContentOffset:(CGPointMake(self.view.bounds.size.width * self.segment.selectedSegmentIndex, 0)) animated:YES];
}

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
    
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"1",@"2",@"3"]];
    [self.view addSubview:self.segment];
    self.segment.frame = CGRectMake(0, 0, kScreenWidth, 40);
    
    [self.segment addTarget:self action:@selector(change) forControlEvents:(UIControlEventValueChanged)];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - kNavigationBarHeight)];
    [self.view addSubview:self.scrollView];

    _dataFormView = [[TestMovementsView alloc] init];
    _dataFormView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);

    [self.scrollView addSubview:_dataFormView];
    
    
    _dataFormView1 = [[TestMovementsView alloc] init];
    _dataFormView1.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
    
    [self.scrollView addSubview:_dataFormView1];
    
    _dataFormView2 = [[TestMovementsView alloc] init];
    _dataFormView2.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight);
    
    [self.scrollView addSubview:_dataFormView2];


}

- (void)dealloc {
    NSLog(@"==========+>>>>>>>>>>>>> 销毁");
    
}

@end

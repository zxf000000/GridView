//
//  CollectionViewController.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "CollectionViewController.h"

#import "YZMovementsView.h"
#import "YZMovementsModel.h"
#import "YZMovementsConvertTool.h"

@interface CollectionViewController () <YZMovementsViewDelegate>

@property (strong, nonatomic) YZMovementsView  *demoView;

@property(nonatomic, copy) NSArray *datas;
@property(nonatomic, copy) NSArray *topTitles;
@property(nonatomic, copy) NSArray *leftTitles;

@property (strong, nonatomic) UISegmentedControl  *segment;

@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation CollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _demoView = [[YZMovementsView alloc] initWithDelegate:self];

    _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
    [self.view addSubview:_demoView];

    _demoView.backgroundColor = [UIColor redColor];
    
//    _segment = [[UISegmentedControl alloc] initWithItems:@[@"基本",@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"]];
//    [_segment addTarget:self action:@selector(change) forControlEvents:(UIControlEventValueChanged)];
//    _segment.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
//    [self.view addSubview:_segment];

    _indicatorView = [[UIActivityIndicatorView alloc]
                                               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    _indicatorView.bounds = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];

    __weak typeof(self) weakSelf = self;

    [YZMovementsConvertTool convertQilecaiJsonToModelsWithFile:@"qilecai" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        weakSelf.leftTitles = leftTitles;
        weakSelf.datas = allDatas;
        weakSelf.topTitles = topTitles;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.demoView reloadData];
            [weakSelf.indicatorView stopAnimating];
        });
    }];
//
//    [YZMovementsConvertTool convertJsonToModelsWithFile:@"movements" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
//        weakSelf.leftTitles = leftTitles;
//        weakSelf.datas = allDatas;
//        weakSelf.topTitles = topTitles;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.demoView reloadData];
//            [weakSelf.indicatorView stopAnimating];
//        });
//    }];

}

- (void)change {
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);

}

// 行列数
- (NSInteger)numberOfColumnsForMovementsView:(YZMovementsView *)view {
    if (self.leftTitles.count == 0) {
        return 0;
    }
    return self.datas.count % self.leftTitles.count == 0 ? self.datas.count / self.leftTitles.count + 4 : self.datas.count / self.leftTitles.count + 1 + 4;
}
- (NSInteger)rowOfColumnsForMovementsView:(YZMovementsView *)view {
    return self.leftTitles.count;
}

// 头部标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view topTitleModelForIndex:(NSInteger)index {
    return self.topTitles[index];
}
- (NSInteger)numberOfTopTitleForMovementsView:(YZMovementsView *)view {
    return self.topTitles.count;
}
- (NSInteger)topTitleRowCountForMovementsView:(YZMovementsView *)view {
    return 1;
}

// 左侧标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view leftTitleModelForIndex:(NSInteger)index {
    return self.leftTitles[index];
}

- (NSInteger)numberOfleftTitleForMovementsView:(YZMovementsView *)view {
    return self.leftTitles.count;
}

- (NSInteger)leftTitleColumnCountForMovementsView:(YZMovementsView *)view {
    return 2;
}

// 数据
- (YZMovementsModel *)movementsView:(YZMovementsView *)view dataModelForIndex:(NSInteger)index {
    return self.datas[index];
}

- (NSInteger)numberOfItemForMovementsView:(YZMovementsView *)view {
    return self.datas.count;
}

- (CGSize)itemSizeForMovementsView:(YZMovementsView *)view {
    return CGSizeMake(30, 30);
}

- (void)dealloc {
    NSLog(@"销毁============>>>>> %s",__func__);
}

@end

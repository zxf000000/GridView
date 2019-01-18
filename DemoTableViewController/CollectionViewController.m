//
//  CollectionViewController.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "CollectionViewController.h"
//#import "DemoLayout.h"
//#import "TestCollectionViewCell.h"
//#import "TestModel.h"
//#import "DemoView.h"
#import "YZMovementsView.h"
#import "YZMovementsModel.h"

@interface CollectionViewController () <YZMovementsViewDelegate>


@property (strong, nonatomic) YZMovementsView  *demoView;

@property(nonatomic, copy) NSArray *datas;
@property(nonatomic, copy) NSArray *topTitles;
@property(nonatomic, copy) NSArray *leftTitles;

@property (strong, nonatomic) UISegmentedControl  *segment;

@end

@implementation CollectionViewController

- (instancetype)init {
    if (self = [super init]) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:2400];
        for (NSInteger i = 0, length = 2400; i < length; i++) {
            YZMovementsModel *model;
            NSString *title = [NSString stringWithFormat:@"%zd",i % 10];
            if (i == 2 || i == 6) {
                model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:title row:i / 80 column:i % 80 lineSerialNumber:0];
            } else if (i > 10 && i %20 == 1) {
                model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeCircle) title:title row:i / 80 column:i % 80 lineSerialNumber:1];
            } else if (i > 10 && i %22 == 1) {
                model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeSquare) title:title row:i / 80 column:i % 80 lineSerialNumber:2];
            } else if (i > 10 && i %23 == 1) {
                model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeFull) title:title row:i / 80 column:i % 80 lineSerialNumber:3];
            } else {
                model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:title row:i / 80 column:i % 80 lineSerialNumber:0];
            }
            [array addObject:model];
        }
        _datas = array.copy;

        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (NSInteger i = 0 ; i < 2 ; i ++) {
            YZMovementsModel *model;
            if (i == 0) {
                NSArray *titles = @[@"基本",@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"];
                for (int j = 0; j < 8; ++j) {
                    model = [[YZMovementsModel alloc] initWithWidth:10 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:titles[j] row:i column:j*10 lineSerialNumber:0];
                    [topArr addObject:model];
                }
            } else {
                for (int j = 0; j < 80; ++j) {
                    model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd",j % 10] row:i column:j lineSerialNumber:0];
                    [topArr addObject:model];
                }
            }
        }
        _topTitles = topArr.copy;

        NSMutableArray *leftArr = [NSMutableArray arrayWithCapacity:500];
        for (NSInteger i = 0 ; i < 30 ; i ++) {
            YZMovementsModel *model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd",18131 + i] row:i / 1 column:i % 1 lineSerialNumber:0];
            [leftArr addObject:model];
        }
        _leftTitles = leftArr.copy;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _demoView = [[YZMovementsView alloc] initWithDelegate:self];

    _demoView.frame = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 30);
    [self.view addSubview:_demoView];

    _demoView.backgroundColor = [UIColor redColor];
    
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"基本",@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"]];
    [_segment addTarget:self action:@selector(change) forControlEvents:(UIControlEventValueChanged)];
    _segment.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    [self.view addSubview:_segment];
    

}

- (void)change {
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _demoView.frame = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - 30);
    _segment.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);

}

// 行列数
- (NSInteger)numberOfColumnsForMovementsView:(YZMovementsView *)view {
    return 80;
}
- (NSInteger)rowOfColumnsForMovementsView:(YZMovementsView *)view {
    return 30;
}

// 头部标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view topTitleModelForIndex:(NSInteger)index {
    return self.topTitles[index];
}
- (NSInteger)numberOfTopTitleForMovementsView:(YZMovementsView *)view {
    return self.topTitles.count;
}

// 左侧标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view leftTitleModelForIndex:(NSInteger)index {
    return self.leftTitles[index];
}

- (NSInteger)numberOfleftTitleForMovementsView:(YZMovementsView *)view {
    return self.leftTitles.count;
}

// 数据
- (YZMovementsModel *)movementsView:(YZMovementsView *)view dataModelForIndex:(NSInteger)index {
    return self.datas[index];
}

- (NSInteger)numberOfItemForMovementsView:(YZMovementsView *)view {
    return self.datas.count;
}

- (CGSize)itemSizeForMovementsView:(YZMovementsView *)view {
    return CGSizeMake(50, 25);
}

- (void)dealloc {
    NSLog(@"销毁============>>>>> %s",__func__);
}

@end

//
// Created by 云舟02 on 2019-01-15.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "DemoGridView.h"
#import "DemoTableView.h"

@interface DemoGridView () <UIScrollViewDelegate>

@property(nonatomic, strong) DemoTableView *topTitleView;
@property(nonatomic, strong) DemoTableView *leftTitleView;
@property(nonatomic, strong) DemoTableView *dataView;
@property(nonatomic, strong) DemoTableView *cornerView;


@end

@implementation DemoGridView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    _cornerView = [[DemoTableView alloc]
                                    initWithRowCount:10 columnCount:7 frame:CGRectMake(0, 0, 100, 50)];
    [self addSubview:_cornerView];
    NSMutableArray *corner = [NSMutableArray array];
    [corner addObject:@[@"号码"]];
    _cornerView.minWidth = 10;
    _cornerView.minHeight = 50;
    _cornerView.datas = corner.copy;
    _cornerView.delegate = self;
    [_cornerView strokeTable];

    _topTitleView = [[DemoTableView alloc]
                                initWithRowCount:10 columnCount:7 frame:CGRectMake(100, 0, self.bounds.size.width - 100, 50)];
    [self addSubview:_topTitleView];
    NSMutableArray *titles = [NSMutableArray array];
    [titles addObject:@[@"222222222222222222",@"222222222222222222",@"222222222222222222",@"222222222222222222",@"222222222222222222",@"222222222222222222",@"222222222222222222"]];
    _topTitleView.minWidth = 10;
    _topTitleView.minHeight = 10;
    _topTitleView.datas = titles.copy;
    _topTitleView.delegate = self;
    [_topTitleView strokeTable];


    _leftTitleView = [[DemoTableView alloc]
                                    initWithRowCount:10 columnCount:7 frame:CGRectMake(0, 50, 100, self.bounds.size.height - 100)];
    [self addSubview:_leftTitleView];
    NSMutableArray *leftTitles = [NSMutableArray array];
    for (NSInteger i = 0 ; i < 60 ; i ++) {
        [leftTitles addObject:@[@"3333"]];
    }
    _leftTitleView.minWidth = 10;
    _leftTitleView.minHeight = 50;
    _leftTitleView.datas = leftTitles.copy;
    _leftTitleView.delegate = self;

    [_leftTitleView strokeTable];


    _dataView = [[DemoTableView alloc]
                                                   initWithRowCount:10 columnCount:7 frame:CGRectMake(100, 50, self.bounds.size.width - 100, self.bounds.size.height - 100)];
    [self addSubview:_dataView];
    NSMutableArray *datas = [NSMutableArray array];
    for (NSInteger i = 0 ; i < 60 ; i ++) {
        [datas addObject:@[@"1111",@"1111",@"1111",@"1111",@"1111",@"1111",@"1111"]];
    }
    _dataView.minWidth = 50;
    _dataView.minHeight = 50;
    _dataView.datas = datas.copy;
    _dataView.delegate = self;
    [_dataView strokeTable];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.dataView) {
        CGPoint offset = self.topTitleView.contentOffset;
        CGPoint offsetLeft = self.leftTitleView.contentOffset;
        offset.x = self.dataView.contentOffset.x;
        offsetLeft.y = self.dataView.contentOffset.y;
        self.topTitleView.contentOffset = offset;
        self.leftTitleView.contentOffset = offsetLeft;
    } else if (scrollView == self.leftTitleView) {
        CGPoint offset = self.dataView.contentOffset;
        offset.y = self.leftTitleView.contentOffset.y;
        self.dataView.contentOffset = offset;
    } else if (scrollView == self.topTitleView) {
        CGPoint offset = self.dataView.contentOffset;
        offset.x = self.topTitleView.contentOffset.x;
        self.dataView.contentOffset = offset;
    }
}

@end
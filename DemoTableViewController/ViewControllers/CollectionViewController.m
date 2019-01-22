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
#import "YZQixingMovementsDataSource.h"
#import "YZQileMovementsDataSource.h"
#import "YZFucai3DMovementsDataSource.h"
#import "YZFucai3DDaxiaoMovementsDataSource.h"
#import "YZQileDaxiaoMovementsDataSource.h"


@interface CollectionViewController () <YZMovementsViewDelegate>

@property (strong, nonatomic) YZMovementsView  *demoView;


@property (strong, nonatomic) UISegmentedControl  *segment;

@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;

@property(nonatomic, strong) YZBaseMovementsDataSource *movementsDataSource;

@property(nonatomic, assign) NSInteger type;

@end

@implementation CollectionViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        switch (_type) {
            case 1:
            {
                _movementsDataSource = [[YZQixingMovementsDataSource alloc] init];
                break;
            }
            case 2:
            {
                _movementsDataSource = [[YZQileMovementsDataSource alloc] init];
                break;
            }
            case 3:
            {
                _movementsDataSource = [[YZFucai3DMovementsDataSource alloc] init];
                break;
            }
            case 4:
            {
                _movementsDataSource = [[YZFucai3DDaxiaoMovementsDataSource alloc] init];
                break;
            }
            case 5:
            {
                _movementsDataSource = [[YZFucai3DDaxiaoMovementsDataSource alloc] init];
                break;
            }
            case 6:
            {
                _movementsDataSource = [[YZFucai3DDaxiaoMovementsDataSource alloc] init];
                break;
            }
            case 7:
            {
                _movementsDataSource = [[YZQileDaxiaoMovementsDataSource alloc] init];
                break;
            }
            case 8:
            {
                _movementsDataSource = [[YZQileDaxiaoMovementsDataSource alloc] init];
                break;
            }
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    switch (_type) {
        case 1:
        {
            self.segment = [[UISegmentedControl alloc] initWithItems:@[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第7️⃣位"]];
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            self.segment = [[UISegmentedControl alloc] initWithItems:@[@"百位",@"十位",@"个位",@"不分位"]];
            break;
        }
    }
    [self.segment addTarget:self action:@selector(changed) forControlEvents:UIControlEventValueChanged];
    self.segment.tintColor = [UIColor colorWithWhite:0.7 alpha:1];
    [self.view addSubview:self.segment];

    _demoView = [[YZMovementsView alloc] initWithDelegate:self.movementsDataSource];
    _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
    [self.view addSubview:_demoView];

    _demoView.backgroundColor = [UIColor redColor];

    _indicatorView = [[UIActivityIndicatorView alloc]
                                               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    _indicatorView.bounds = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];

    __weak typeof(self) weakSelf = self;
    if (self.type == 5) {
        [((YZFucai3DDaxiaoMovementsDataSource *)self.movementsDataSource) loadJiouDataWithhHandle:^{
            [weakSelf.demoView reloadData];
            [weakSelf.indicatorView stopAnimating];
        }];
    } else if (self.type == 6) {
        [((YZFucai3DDaxiaoMovementsDataSource *)self.movementsDataSource) loadZhiheWithhHandle:^{
            [weakSelf.demoView reloadData];
            [weakSelf.indicatorView stopAnimating];
        }];
    } else if (self.type == 7) {
        [((YZQileDaxiaoMovementsDataSource *)self.movementsDataSource) loadDaxiaoWithHandle:^{
            [weakSelf.demoView reloadData];
            [weakSelf.indicatorView stopAnimating];
        }];
    } else if (self.type == 8) {
        [((YZQileDaxiaoMovementsDataSource *)self.movementsDataSource) loadJiouDataWithhHandle:^{
            [weakSelf.demoView reloadData];
            [weakSelf.indicatorView stopAnimating];
        }];
    } else  {
        [self.movementsDataSource loadDataWithHandle:^{
            [weakSelf.demoView reloadData];
            [weakSelf.indicatorView stopAnimating];
        }];
    }


}

- (void)changed {
    NSInteger index = self.segment.selectedSegmentIndex;
    switch (_type) {
        case 1:
        {
            ((YZQixingMovementsDataSource *)self.movementsDataSource).index = index;
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            ((YZFucai3DMovementsDataSource *)self.movementsDataSource).index = index;
            break;
        }
    }
    [self.demoView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    switch (_type) {
        case 1:
        {
            self.segment.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
            _demoView.frame = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
            break;
        }
        case 2:
        {
            _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
            break;
        }
        case 3:
        {
            self.segment.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
            _demoView.frame = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
            break;
        }
        case 4:
        {
            _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
            break;
        }
        default:
        {
            _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
            break;
        }
    }

}


- (void)dealloc {
    NSLog(@"销毁============>>>>> %s",__func__);
}

@end

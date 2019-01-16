//
//  CollectionViewController.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/15.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "CollectionViewController.h"
#import "DemoLayout.h"
#import "TestCollectionViewCell.h"
#import "TestModel.h"
#import "YYFPSLabel.h"
#import "DemoView.h"

@interface CollectionViewController () 


@property (nonatomic, strong) YYFPSLabel *fpsLabel;
@property (strong, nonatomic) DemoView  *demoView;

@end

@implementation CollectionViewController
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    
    UILabel *label_;
    UITableView *table_;
}

- (instancetype)init {
    if (self = [super init]) {


    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _demoView = [[DemoView alloc] initWithItemWidth:50 itemHeight:25];

    _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
    [self.view addSubview:_demoView];
    [self testFPSLabel];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
}

- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
    
    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题
    
    // 移除也不能使 label里的 timer invalidate
    //        [_fpsLabel removeFromSuperview];
}



@end

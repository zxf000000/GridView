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
#import "DemoView.h"

@interface CollectionViewController () 


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

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _demoView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height);
}



@end

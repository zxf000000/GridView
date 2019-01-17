//
// Created by 云舟02 on 2019-01-03.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoTableView.h"
#import "DemoGridView.h"


@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    DemoGridView *gridView = [[DemoGridView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 100)];
    [self.view addSubview:gridView];

}

@end
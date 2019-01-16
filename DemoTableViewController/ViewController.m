//
//  ViewController.m
//  DemoTableViewController
//
//  Created by 云舟02 on 2019-01-03.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "CollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                                           initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap {
//    DemoViewController *demoViewController = [[DemoViewController alloc]init];
//    [self.navigationController pushViewController:demoViewController animated:YES];
    
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end

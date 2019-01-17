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
#import "ZXFFormViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"UICollectionView实现";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"CAShapeLayer实现";
    } else {
        cell.textLabel.text = @"CAShapeLayer(1)";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CollectionViewController *vc = [[CollectionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        DemoViewController *demoViewController = [[DemoViewController alloc]init];
        [self.navigationController pushViewController:demoViewController animated:YES];
    } else {
        ZXFFormViewController *formVC = [[ZXFFormViewController alloc] init];
        [self.navigationController pushViewController:formVC animated:YES];
    }
}




@end

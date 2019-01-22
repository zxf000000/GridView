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
#import "YYFPSLabel.h"
#import "YZYilouViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) YYFPSLabel *fpsLabel;
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

    self.fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(100, self.navigationController.navigationBar.bounds.size.height, 50, 30)];
    [self.navigationController.view addSubview:self.fpsLabel];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"UICollectionView(七星彩)";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"UICollectionView(七乐彩)";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"UICollectionView(福彩3D/基本走势)";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"UICollectionView(福彩3D/大小分析)";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"UICollectionView(福彩3D/奇偶分析)";
    } else  if (indexPath.row == 5) {
        cell.textLabel.text = @"UICollectionView(福彩3D/质和分析)";
    } else if (indexPath.row == 6) {
        cell.textLabel.text = @"UICollectionView(七乐彩/大小)";
    } else if (indexPath.row == 7) {
        cell.textLabel.text = @"UICollectionView(七乐彩/奇偶)";
    } else if (indexPath.row == 8) {
        cell.textLabel.text = @"UICollectionView(福彩3D/遗漏分析)";
    } else if (indexPath.row == 9) {
        cell.textLabel.text = @"UICollectionView(福彩3D/冷热分析)";
    } else {
        cell.textLabel.text = @"CAShapeLayer(1)";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:1];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:2];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2){
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:3];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3){
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:4];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4){
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:5];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 5){
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:6];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 6){
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:7];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 7){
        CollectionViewController *vc = [[CollectionViewController alloc] initWithType:8];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 8){
        YZYilouViewController *vc = [[YZYilouViewController alloc] initWithType:YZYilouViewControllerTypeYilou];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 9){
        YZYilouViewController *vc = [[YZYilouViewController alloc] initWithType:YZYilouViewControllerTypeLengre];
        [self.navigationController pushViewController:vc animated:YES];
    } else  {
        ZXFFormViewController *formVC = [[ZXFFormViewController alloc] init];
        [self.navigationController pushViewController:formVC animated:YES];
    }
}




@end

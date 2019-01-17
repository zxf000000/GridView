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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YYFPSLabel *fpsLabel;

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

    [self testFPSLabel];

}


- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [[UIApplication sharedApplication].keyWindow addSubview:_fpsLabel];

    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题

    // 移除也不能使 label里的 timer invalidate
    //        [_fpsLabel removeFromSuperview];
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

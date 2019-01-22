//
// Created by 云舟02 on 2019-01-22.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZYilouViewController.h"
#import "YZYilouCell.h"
#import "YZMovementsConvertTool.h"
#import "YZYilouViewBottomView.h"

static CGFloat const kItemHeight = 30.f;
static CGFloat const kTitleHeight = 40.f;

@interface YZYilouViewController() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, copy) NSArray *yilouDatas;
@property(nonatomic, assign) YZYilouViewControllerType type;
@end

@implementation YZYilouViewController

- (instancetype)initWithType:(YZYilouViewControllerType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self loadData];
}
#pragma mark - Custom Accessors

#pragma mark - Actions

#pragma mark - Network

#pragma mark - Public

#pragma mark - Private

- (void)loadData {

    switch (self.type) {

        case YZYilouViewControllerTypeYilou:
        {
            [YZMovementsConvertTool convertFucai3DYilouDataToModelsWithFileName:@"fucai3Dyilou" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
                self.yilouDatas = allDatas;
                [self.collectionView reloadData];
            }];
        }
            break;
        case YZYilouViewControllerTypeLengre:
        {
            [YZMovementsConvertTool convertFucai3DLengreDataToModelsWithFileName:@"fucai3Dlengre" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
                self.yilouDatas = allDatas;
                [self.collectionView reloadData];
            }];
        }
            break;
    }


}

#pragma mark - UICollectionViewDataSource/delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZYilouCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YZYilouCellId forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0: {
            cell.datas = self.yilouDatas[0];
            cell.title = self.type == YZYilouViewControllerTypeYilou ? @"百位遗漏" : @"百位冷热";
            break;
        }
        case 1: {
            cell.datas = self.yilouDatas[1];
            cell.title = self.type == YZYilouViewControllerTypeYilou ? @"十位遗漏" : @"十位冷热";
            break;
        }
        case 2: {
            cell.datas = self.yilouDatas[2];
            cell.title = self.type == YZYilouViewControllerTypeYilou ? @"个位遗漏" : @"个位冷热";
            break;
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
viewForSupplementaryElementOfKind:(NSString *)kind
                      atIndexPath:(NSIndexPath *)indexPath {
    YZYilouViewBottomView *bottomView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:YZYilouViewBottomViewId forIndexPath:indexPath];
    return bottomView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.bounds.size.width, 200);
}

#pragma mark - YUZSuperclass

#pragma mark - NSObject

#pragma mark - initUI


- (void)setupUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, kItemHeight * 11 + kTitleHeight);
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0.f;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc]
                                             initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YZYilouCell class] forCellWithReuseIdentifier:YZYilouCellId];
    [self.collectionView registerClass:[YZYilouViewBottomView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:YZYilouViewBottomViewId];

}




@end
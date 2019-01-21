//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZQixingMovementsDataSource.h"

#import "YZMovementsModel.h"
#import "YZMovementsConvertTool.h"


@interface YZQixingMovementsDataSource ()

@property(nonatomic, copy) NSArray *allIndexData;

@end


@implementation YZQixingMovementsDataSource

- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete {
    __weak typeof(self) weakSelf = self;
    [YZMovementsConvertTool convertJsonToModelsWithFile:@"movements" numberIndex:0 complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        weakSelf.leftTitles = leftTitles;
        weakSelf.datas = allDatas[0];
        weakSelf.allIndexData = allDatas;
        weakSelf.topTitles = topTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
//    [YZMovementsConvertTool convertJsonToModelsWithFile:@"movements" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
//        weakSelf.leftTitles = leftTitles;
//        weakSelf.datas = allDatas;
//        weakSelf.topTitles = topTitles;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            complete();
//        });
//    }];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    self.datas = _allIndexData[index];
}

// 行列数
- (NSInteger)numberOfColumnsForMovementsView:(YZMovementsView *)view {
    if (self.leftTitles.count == 0) {
        return 0;
    }
    return self.datas.count % self.leftTitles.count == 0 ? self.datas.count / self.leftTitles.count  : self.datas.count / self.leftTitles.count + 1;
}

- (NSInteger)rowOfColumnsForMovementsView:(YZMovementsView *)view {
    return self.leftTitles.count;
}

// 头部标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view topTitleModelForIndex:(NSInteger)index {
    return self.topTitles[index];
}
- (NSInteger)numberOfTopTitleForMovementsView:(YZMovementsView *)view {
    return self.topTitles.count;
}
- (NSInteger)topTitleRowCountForMovementsView:(YZMovementsView *)view {
    return 1;
}

// 左侧标题
- (YZMovementsModel *)movementsView:(YZMovementsView *)view leftTitleModelForIndex:(NSInteger)index {
    return self.leftTitles[index];
}

- (NSInteger)numberOfleftTitleForMovementsView:(YZMovementsView *)view {
    return self.leftTitles.count;
}

- (NSInteger)leftTitleColumnCountForMovementsView:(YZMovementsView *)view {
    return 2;
}

// 数据
- (YZMovementsModel *)movementsView:(YZMovementsView *)view dataModelForIndex:(NSInteger)index {
    return self.datas[index];
}

- (NSInteger)numberOfItemForMovementsView:(YZMovementsView *)view {
    return self.datas.count;
}

- (CGSize)itemSizeForMovementsView:(YZMovementsView *)view {
    return CGSizeMake(kScreenWidth / 12.f, kScreenWidth / 12.f);
}

@end
//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZFucai3DDaxiaoMovementsDataSource.h"
#import "YZMovementsConvertTool.h"


@implementation YZFucai3DDaxiaoMovementsDataSource


- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete {
    __weak typeof(self) weakSelf = self;
    [YZMovementsConvertTool convertFucai3DDaxiaoJsonToModelsWithFile:@"fucai3Ddaxiao" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        self.leftTitles = leftTitles;
        self.datas = allDatas;
        self.topTitles = topTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
}

- (void)loadJiouDataWithhHandle:(LoadDataCompleteHandle)complete {
    [YZMovementsConvertTool convertFucai3DJiouJsonToModelsWithFile:@"fucai3Djiou" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        self.leftTitles = leftTitles;
        self.datas = allDatas;
        self.topTitles = topTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
}

- (void)loadZhiheWithhHandle:(LoadDataCompleteHandle)complete {
    [YZMovementsConvertTool convertFucai3DZhiheJsonToModelsWithFile:@"fucai3Dzhihe" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        self.leftTitles = leftTitles;
        self.datas = allDatas;
        self.topTitles = topTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
}

// 行列数
- (NSInteger)numberOfColumnsForMovementsView:(YZMovementsView *)view {
    return self.topTitles.count * 2;
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
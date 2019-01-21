//
// Created by 云舟02 on 2019-01-21.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZQileDaxiaoMovementsDataSource.h"
#import "YZMovementsConvertTool.h"


@implementation YZQileDaxiaoMovementsDataSource

- (void)loadJiouDataWithhHandle:(LoadDataCompleteHandle)complete {
    [YZMovementsConvertTool convertQilecaiJiouJsonToModelsWithFile:@"qilejiou" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        self.leftTitles = leftTitles;
        self.datas = allDatas;
        self.topTitles = topTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
}

- (void)loadDaxiaoWithHandle:(LoadDataCompleteHandle)complete {
    [YZMovementsConvertTool convertQilecaiDaxiaoJsonToModelsWithFile:@"qiledaxiao" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
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
    return self.topTitles.count / 3 * 2;
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
    return 2;
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
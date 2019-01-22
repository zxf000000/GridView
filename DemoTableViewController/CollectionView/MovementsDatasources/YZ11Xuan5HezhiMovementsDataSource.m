//
// Created by 云舟02 on 2019-01-22.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZ11Xuan5HezhiMovementsDataSource.h"

#import "YZMovementsModel.h"
#import "YZMovementsConvertTool.h"


@interface YZ11Xuan5HezhiMovementsDataSource ()

@property(nonatomic, copy) NSArray *allIndexData;

@end

@implementation YZ11Xuan5HezhiMovementsDataSource

- (void)loadDataWithHandle:(LoadDataCompleteHandle)complete {
    __weak typeof(self) weakSelf = self;
    [YZMovementsConvertTool convert11xuan5HezhiJsonToModelsWithFileName:@"11xuan5hezhi" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        weakSelf.datas = allDatas[0];
        weakSelf.allIndexData = allDatas;
        weakSelf.topTitles = topTitles;
        weakSelf.leftTitles = leftTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
}

- (void)loadQianyiDataWithHandle:(LoadDataCompleteHandle)complete {
    __weak typeof(self) weakSelf = self;
    [YZMovementsConvertTool convert11xuan5QianyiJsonToModelsWithFileName:@"11xuan5qianyi" complete:^(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas) {
        weakSelf.datas = allDatas[0];
        weakSelf.allIndexData = allDatas;
        weakSelf.topTitles = topTitles;
        weakSelf.leftTitles = leftTitles;
        dispatch_async(dispatch_get_main_queue(), ^{
            complete();
        });
    }];
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

    return CGSizeMake(kScreenWidth / 11, kScreenWidth / 11);
}



@end
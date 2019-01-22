//
// Created by 云舟02 on 2019-01-18.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import "YZMovementsConvertTool.h"
#import "YZMovementsModel.h"

@implementation YZMovementsConvertTool

+ (NSString *)stringFromFile:(NSString *)name {
    NSString *filePath = [[NSBundle mainBundle]
                                    pathForResource:name ofType:@"json"];
    NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return string;
}

#pragma mark 七乐彩
+ (void)convertQilecaiJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *datas = jsonDic[@"page"][@"jbzs"];
    NSMutableArray *leftTitles = [NSMutableArray array];
    NSMutableArray *allDatas = [NSMutableArray array];
    NSInteger redfbCount = 0;
    for (NSInteger i = 0, length = datas.count; i < length; ++i) {
        NSDictionary *singleRowData = datas[i];
        // 添加标题
        [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
        // 获取开奖号码
        NSArray *openCodes = singleRowData[@"opencode"];
        // 红球分布 --- 主要数据
        NSArray *redfb = singleRowData[@"redfb"];
        redfbCount = redfb.count;
        // 篮球
        NSString *blueCode = [singleRowData[@"bluecode"] lastObject];
        // 单独一行数据
        NSMutableArray *singleRowDataArr = [NSMutableArray array];
        for (NSInteger redfbIndex = 0, length = redfb.count; redfbIndex < length; redfbIndex++) {
            NSString *numberText = redfb[redfbIndex];
            YZMovementsModelBallColor color = YZMovementsModelBallColorRed;
            BgType bgType = BgTypeNone;
            if ([numberText integerValue] == 0) {
                numberText = [NSString stringWithFormat:@"%zd", redfbIndex + 1];
                bgType = BgTypeCircle;
                if ([blueCode integerValue] == [numberText integerValue]) {
                    color = YZMovementsModelBallColorBlue;
                }
            }
            YZMovementsModel *model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:bgType title:numberText row:i column:redfbIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
            model.ballColor = color;
            [singleRowDataArr addObject:model];
        }
        // 添加后面几个
        NSString *sanfq = [singleRowData[@"sanfq"] lastObject];
        [singleRowDataArr addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:sanfq row:i column:redfbCount lineSerialNumber:0 type:YZMovementsModelPositionDefault]];
        NSArray *sanfqArr = [sanfq componentsSeparatedByString:@":"];
        for (int sanfqindex = 0; sanfqindex < sanfqArr.count; ++sanfqindex) {
            [singleRowDataArr addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:sanfqArr[sanfqindex] row:i column:redfbCount + (sanfqindex * 2) + 2 lineSerialNumber:0 type:YZMovementsModelPositionDefault]];
        }

        [allDatas addObjectsFromArray:singleRowDataArr];
    }

    NSMutableArray *topTitles = [NSMutableArray arrayWithCapacity:34];
    NSArray *otherTitles = @[@"三区比", @"一区", @"二区", @"三区"];
    for (NSInteger titleIndex = 0; titleIndex < otherTitles.count + redfbCount; titleIndex++) {
        if (titleIndex < redfbCount) {
            [topTitles addObject:[YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:[NSString stringWithFormat:@"%zd", titleIndex + 1] row:0 column:titleIndex lineSerialNumber:0 type:YZMovementsModelPositionTop]];
        } else {
            [topTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:otherTitles[titleIndex - 30] row:0 column:redfbCount + ((titleIndex - redfbCount) * 2) lineSerialNumber:0 type:YZMovementsModelPositionTop]];
        }
    }
    complete(leftTitles, topTitles, allDatas);

}

+ (void)convertQilecaiDaxiaoJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"dxzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *topTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"reddx1",@"reddx2",@"reddx3",@"reddx4",@"reddx5",@"reddx6",@"reddx7"];
        [self addQileDataWithDatas:datas allDatas:allDatas leftTitles:leftTitles keys:keys segmentTitle:@[@"大",@"小"]];
        // 头部标题
        NSArray *upTitles = @[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"];
        for (NSInteger row = 0 ; row < 2 ; row ++) {
            if (row == 0) {
                for (int colume = 0; colume < 7; ++colume) {
                    [topTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:upTitles[colume] row:row column:colume * 2 lineSerialNumber:0 type:YZMovementsModelPositionTop]];
                }
            } else {
                for (int colume = 0; colume < 14; ++colume) {
                    NSString *title = colume % 2 == 0 ? @"大" : @"小";
                    [topTitles addObject:[YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:title row:row column:colume lineSerialNumber:0 type:YZMovementsModelPositionTop]];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topTitles, allDatas);
        });
    });
}

+ (void)convertQilecaiJiouJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jozs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *topTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"reddx1",@"reddx2",@"reddx3",@"reddx4",@"reddx5",@"reddx6",@"reddx7"];
        [self addQileDataWithDatas:datas allDatas:allDatas leftTitles:leftTitles keys:keys segmentTitle:@[@"奇",@"偶"]];
        // 头部标题
        NSArray *upTitles = @[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"];
        for (NSInteger row = 0 ; row < 2 ; row ++) {
            if (row == 0) {
                for (int colume = 0; colume < 7; ++colume) {
                    [topTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:upTitles[colume] row:row column:colume * 2 lineSerialNumber:0 type:YZMovementsModelPositionTop]];
                }
            } else {
                for (int colume = 0; colume < 14; ++colume) {
                    NSString *title = colume % 2 == 0 ? @"奇" : @"偶";
                    [topTitles addObject:[YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:title row:row column:colume lineSerialNumber:0 type:YZMovementsModelPositionTop]];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topTitles, allDatas);
        });
    });
}

+ (void)addQileDataWithDatas:(NSArray *)datas allDatas:(NSMutableArray *)allDatas leftTitles:(NSMutableArray *)leftTitles keys:(NSArray *)keys segmentTitle:(NSArray *)segmentTitle {
    for (NSInteger singleRowIndex = 0, length = datas.count ; singleRowIndex < length; singleRowIndex ++) {
        NSDictionary *singleRowData = datas[singleRowIndex];
        // 添加标题
        [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:singleRowIndex column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];

        // 处理其他数据
        for (NSInteger keyIndex = 0, length = keys.count; keyIndex < length; keyIndex ++) {
            NSArray *number = singleRowData[keys[keyIndex]]; // [@"0",@"52"]
            NSString *leftNumber = number[0];
            NSString *rightNumber = number[1];
            YZMovementsModel *leftModel;
            YZMovementsModel *rightModel;
            BgType leftType;
            BgType rightType;
            YZMovementsModelBallColor leftBallColor;
            YZMovementsModelBallColor rightBallColor;
            if ([leftNumber integerValue] == 0) {
                leftType = BgTypeFull;
                leftNumber = segmentTitle[0];
                leftBallColor = YZMovementsModelBallColorBig;
            } else {
                leftType = BgTypeNone;
            }
            if ([rightNumber integerValue] == 0) {
                rightType = BgTypeFull;
                rightNumber = segmentTitle[1];
                rightBallColor = YZMovementsModelBallColorSmall;
            } else {
                rightType = BgTypeNone;
            }
            leftModel = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:leftType title:leftNumber row:singleRowIndex column:keyIndex * 2 lineSerialNumber:0 type:YZMovementsModelPositionDefault];
            leftModel.ballColor = leftBallColor;
            rightModel = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:rightType title:rightNumber row:singleRowIndex column:keyIndex * 2 + 1 lineSerialNumber:0 type:YZMovementsModelPositionDefault];
            rightModel.ballColor = rightBallColor;
            [allDatas addObject:leftModel];
            [allDatas addObject:rightModel];
        }
    }
}

#pragma mark  七星彩
+ (void)convertJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jbzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"yilou1", @"yilou2", @"yilou3", @"yilou4", @"yilou5", @"yilou6", @"yilou7"];
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            // 获取开奖号码
            NSArray *openCodes = singleRowData[@"opencode"];
            // 所有的拼起来
            // 单个遗漏的数字个数
            NSInteger singleYilouCount = [singleRowData[keys[0]] count];
            NSMutableDictionary *singleRowYilou = [NSMutableDictionary dictionary];
            [singleRowData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (![keys containsObject:key]) {

                } else {
                    // 第几位 ( 0 - 6)
                    NSInteger yilouIndex = [keys indexOfObject:key];
                    // 当前这一位的开奖号码
                    NSString *currentOpenCode = openCodes[yilouIndex];
                    // 获取当前这一位的所有号码
                    NSArray *singleYilouArr = (NSArray *) obj;
                    for (NSInteger singleYilouIndex = 0, length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex++) {
                        NSString *number = singleYilouArr[singleYilouIndex];
//                        BOOL hasLinePoint = [number isEqualToString:currentOpenCode];
//                        BgType type = hasLinePoint ? BgTypeCircle : BgTypeNone;
                        YZMovementsModel *model;
                        if ([number isEqualToString:@"0"]) {
                            model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:YES bgType:BgTypeCircle title:currentOpenCode row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                        } else {
                            model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                        }
                        NSLog(@"当前index === >>>>>>> %zd", yilouIndex * singleYilouCount + singleYilouIndex);
                        if (singleRowYilou[key]) {
                            NSMutableArray *dataForKey = singleRowYilou[key];
                            [dataForKey addObject:model];
                            singleRowYilou[key] = dataForKey;
                        } else {
                            NSMutableArray *dataForKey = [NSMutableArray array];
                            [dataForKey addObject:model];
                            singleRowYilou[key] = dataForKey;
                        }
                    }
                }
            }];

            for (NSInteger index = 0, length = singleRowYilou.allKeys.count; index < length; index++) {
                [allDatas addObjectsFromArray:singleRowYilou[keys[index]]];
            }
        }
        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (int j = 0; j < 70; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd", j % 10] row:0 column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }
//
//        for (NSInteger i = 0 ; i < 2 ; i ++) {
//            YZMovementsModel *model;
//            if (i == 0) {
//                NSArray *titles = @[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"];
//                for (int j = 0; j < 7; ++j) {
//                    model = [[YZMovementsModel alloc] initWithWidth:10 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:titles[j] row:i column:j*10 lineSerialNumber:0 type:YZMovementsModelPositionTop];
//                    [topArr addObject:model];
//                }
//            } else {
//                for (int j = 0; j < 70; ++j) {
//                    model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd",j % 10] row:i column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
//                    [topArr addObject:model];
//                }
//            }
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas);
        });
    });

}


// 七星彩
+ (void)convertJsonToModelsWithFile:(NSString *)fileName
                        numberIndex:(NSInteger)numberIndex
                           complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jbzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"yilou1", @"yilou2", @"yilou3", @"yilou4", @"yilou5", @"yilou6", @"yilou7"];
        for (int k = 0; k < keys.count; ++k) {
            [allDatas addObject:[NSMutableArray array]];
        }
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            // 获取开奖号码
            NSArray *openCodes = singleRowData[@"opencode"];
            // 所有的拼起来
            [singleRowData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (![keys containsObject:key]) {

                } else {
                    // 第几位 ( 0 - 6)
                    NSInteger yilouIndex = [keys indexOfObject:key];
                    // 当前这一位的开奖号码
                    NSString *currentOpenCode = openCodes[yilouIndex];
                    // 获取当前这一位的所有号码
                    NSArray *singleYilouArr = (NSArray *) obj;
                    for (NSInteger singleYilouIndex = 0, length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex++) {
                        NSString *number = singleYilouArr[singleYilouIndex];
                        YZMovementsModel *model;
                        if ([number isEqualToString:@"0"]) {
                            model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:YES bgType:BgTypeCircle title:currentOpenCode row:i column:singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                        } else {
                            model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:i column:singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                        }
                        NSMutableArray *currentData = allDatas[yilouIndex];
                        [currentData addObject:model];
                        allDatas[yilouIndex] = currentData;
                    }
                }
            }];
        }
        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (int j = 0; j < 10; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd", j % 10] row:0 column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas);
        });
    });
}

#pragma mark   福彩
+ (void)convertFucai3DJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jbzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"yilou1", @"yilou2", @"yilou3", @"yilou"];
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            // 获取开奖号码
            NSArray *openCodes = singleRowData[@"opencode"];
            // 所有的拼起来
            // 单个遗漏的数字个数
            NSInteger singleYilouCount = [singleRowData[keys[0]] count];
            NSMutableDictionary *singleRowYilou = [NSMutableDictionary dictionary];
            [singleRowData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (![keys containsObject:key]) {

                } else {
                    // 第几位 ( 0 - 3)
                    NSInteger yilouIndex = [keys indexOfObject:key];
                    // 获取当前这一位的所有号码
                    NSArray *singleYilouArr = (NSArray *) obj;
                    for (NSInteger singleYilouIndex = 0, length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex++) {
                        NSString *number = singleYilouArr[singleYilouIndex];
                        // 当前这一位的开奖号码
                        NSString *currentOpenCode;
                        YZMovementsModel *model;
                        if ([key isEqualToString:@"yilou"]) {
                            // 不分位的时候不使用openCode, 开奖号码对应的位置添加背景,并且将0 赋值为开奖号码
                            if ([number integerValue] == 0) {
                                number = [NSString stringWithFormat:@"%zd", singleYilouIndex];
                                model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeCircle title:number row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                            } else {
                                model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                            }
                        } else {
                            // 个位十位百位的数据
                            currentOpenCode = openCodes[yilouIndex];
                            if ([number isEqualToString:@"0"]) {
                                model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:YES bgType:BgTypeCircle title:currentOpenCode row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                            } else {
                                model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                            }
                        }

                        NSLog(@"当前index === >>>>>>> %zd", yilouIndex * singleYilouCount + singleYilouIndex);
                        if (singleRowYilou[key]) {
                            NSMutableArray *dataForKey = singleRowYilou[key];
                            [dataForKey addObject:model];
                            singleRowYilou[key] = dataForKey;
                        } else {
                            NSMutableArray *dataForKey = [NSMutableArray array];
                            [dataForKey addObject:model];
                            singleRowYilou[key] = dataForKey;
                        }
                    }
                }
            }];

            for (NSInteger index = 0, length = singleRowYilou.allKeys.count; index < length; index++) {
                [allDatas addObjectsFromArray:singleRowYilou[keys[index]]];
            }
        }
        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (int j = 0; j < keys.count * 10; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd", j % 10] row:0 column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }
//
//        for (NSInteger i = 0 ; i < 2 ; i ++) {
//            YZMovementsModel *model;
//            if (i == 0) {
//                NSArray *titles = @[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"];
//                for (int j = 0; j < 7; ++j) {
//                    model = [[YZMovementsModel alloc] initWithWidth:10 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:titles[j] row:i column:j*10 lineSerialNumber:0 type:YZMovementsModelPositionTop];
//                    [topArr addObject:model];
//                }
//            } else {
//                for (int j = 0; j < 70; ++j) {
//                    model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd",j % 10] row:i column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
//                    [topArr addObject:model];
//                }
//            }
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas);
        });
    });
}


+ (void)convertFucai3DJsonToModelsWithFile:(NSString *)fileName
                               numberIndex:(NSInteger)numberIndex
                                  complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jbzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"yilou1", @"yilou2", @"yilou3", @"yilou"];
        for (int k = 0; k < keys.count; ++k) {
            [allDatas addObject:[NSMutableArray array]];
        }
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            [self addSingleRowDataWithLeftTitles:leftTitles allDatas:allDatas singleRowData:singleRowData keys:keys hasLine:YES row:i];
        }
        // 添加统计数据
        [self addFucaiBottomDataWithDict:jsonDic[@"page"][@"jbtj"] leftTitles:leftTitles allDatas:allDatas baseRow:leftTitles.count];

        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (int j = 0; j < keys.count * 10; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd", j % 10] row:0 column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas);
        });
    });
}

// 添加底部统计数据
+ (void)addFucaiBottomDataWithDict:(NSDictionary *)bottomDataDict
                        leftTitles:(NSMutableArray *)leftTitles
                          allDatas:(NSMutableArray *)allDatas
                           baseRow:(NSInteger)baseRow {
    // 添加底部统计标题
    NSArray *extraTitles = @[@"平均遗漏", @"最大遗漏", @"最大连出"];
    NSArray *keys = @[@"yilou1", @"yilou2", @"yilou3", @"yilou4"];
    NSArray *bottomKeys = @[@"avgyl", @"maxyl", @"maxlc"];
    for (NSInteger bottomKeyIndex = 0, length = bottomKeys.count; bottomKeyIndex < length; bottomKeyIndex++) {
        NSDictionary *singleRowData = bottomDataDict[bottomKeys[bottomKeyIndex]];
        [self addSingleRowDataWithLeftTitles:leftTitles allDatas:allDatas singleRowData:singleRowData keys:keys hasLine:NO row:bottomKeyIndex + baseRow];
    }
    for (NSInteger leftTitleIndex = 0, length = extraTitles.count; leftTitleIndex < length; leftTitleIndex ++ ) {
        // 添加标题
        [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:extraTitles[leftTitleIndex] row:baseRow + leftTitleIndex column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
    }

}

+ (void)addSingleRowDataWithLeftTitles:(NSMutableArray *)leftTitles
                              allDatas:(NSMutableArray *)allDatas
                         singleRowData:(NSDictionary *)singleRowData
                                  keys:(NSArray *)keys
                               hasLine:(BOOL)hasLine
                                   row:(NSInteger)row {

    // 获取开奖号码
    NSArray *openCodes = singleRowData[@"opencode"];
    // 所有的拼起来
    [singleRowData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![keys containsObject:key]) {

        } else {
            // 第几位 ( 0 - 3)
            NSInteger yilouIndex = [keys indexOfObject:key];
            // 获取当前这一位的所有号码
            NSArray *singleYilouArr = (NSArray *) obj;
            for (NSInteger singleYilouIndex = 0, length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex++) {
                NSString *number = singleYilouArr[singleYilouIndex];
                // 当前这一位的开奖号码
                NSString *currentOpenCode;
                YZMovementsModel *model;
                if (!hasLine) {
                    model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:row column:singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];

                } else {
                if ([key isEqualToString:@"yilou"]) {
                    // 不分位的时候不使用openCode, 开奖号码对应的位置添加背景,并且将0 赋值为开奖号码
                    if ([number integerValue] == 0) {
                        number = [NSString stringWithFormat:@"%zd", singleYilouIndex];
                        model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeCircle title:number row:row column:singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                    } else {
                        model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:row column: singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                    }
                } else {
                    // 个位十位百位的数据
                    currentOpenCode = openCodes[yilouIndex];
                    if ([number isEqualToString:@"0"]) {
                        model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:YES bgType:BgTypeCircle title:currentOpenCode row:row column:singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                    } else {
                        model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:row column: singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                    }
                }
                }

                NSMutableArray *currentData = allDatas[yilouIndex];
                [currentData addObject:model];
                allDatas[yilouIndex] = currentData;
            }
        }
    }];
}

// 福彩3D 大小形态分布
+ (void)convertFucai3DDaxiaoJsonToModelsWithFile:(NSString *)fileName
                                        complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"dxzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *topTitleArray = @[@"大大大",@"大大小",@"大小大",@"大小小",@"小大大",@"小大小",@"小小大",@"小小小"];
        NSArray *keys = @[@"dxxtyilou"];
        for (int k = 0; k < keys.count; ++k) {
            [allDatas addObject:[NSMutableArray array]];
        }
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            [self addDaxiaoSingleRowDataWithLeftTitles:leftTitles topTitles:topTitleArray allDatas:allDatas singleRowData:singleRowData keys:keys hasLine:NO row:i];
        }
        NSMutableArray *topArr = [NSMutableArray array];
        for (int j = 0, length = topTitleArray.count; j < length; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:2 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:topTitleArray[j] row:0 column:j * 2 lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas.lastObject);
        });
    });
}

// 福彩3D 质和形态分布
+ (void)convertFucai3DZhiheJsonToModelsWithFile:(NSString *)fileName
                                       complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"ZhiHezs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *topTitleArray = @[@"质质质",@"质质合",@"质合质",@"质合合",@"合质质",@"合质合",@"合合质",@"合合合"];
        NSArray *keys = @[@"yilou"];
        for (int k = 0; k < keys.count; ++k) {
            [allDatas addObject:[NSMutableArray array]];
        }
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            [self addDaxiaoSingleRowDataWithLeftTitles:leftTitles topTitles:topTitleArray allDatas:allDatas singleRowData:singleRowData keys:keys hasLine:NO row:i];
        }
        NSMutableArray *topArr = [NSMutableArray array];
        for (int j = 0, length = topTitleArray.count; j < length; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:2 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:topTitleArray[j] row:0 column:j * 2 lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas.lastObject);
        });
    });
}

// 福彩3D 奇偶形态分布
+ (void)convertFucai3DJiouJsonToModelsWithFile:(NSString *)fileName
                                        complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jozs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *topTitleArray = @[@"奇奇奇",@"奇奇偶",@"奇偶奇",@"奇偶偶",@"偶奇奇",@"偶奇偶",@"偶偶奇",@"偶偶偶"];
        NSArray *keys = @[@"yilou"];
        for (int k = 0; k < keys.count; ++k) {
            [allDatas addObject:[NSMutableArray array]];
        }
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            [self addDaxiaoSingleRowDataWithLeftTitles:leftTitles topTitles:topTitleArray allDatas:allDatas singleRowData:singleRowData keys:keys hasLine:NO row:i];
        }
        NSMutableArray *topArr = [NSMutableArray array];
        for (int j = 0, length = topTitleArray.count; j < length; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:2 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:topTitleArray[j] row:0 column:j * 2 lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas.lastObject);
        });
    });
}
+ (void)addDaxiaoSingleRowDataWithLeftTitles:(NSMutableArray *)leftTitles
                                   topTitles:(NSArray *)topTitles
                              allDatas:(NSMutableArray *)allDatas
                         singleRowData:(NSDictionary *)singleRowData
                                  keys:(NSArray *)keys
                               hasLine:(BOOL)hasLine
                                   row:(NSInteger)row {

    // 获取开奖号码
    NSArray *openCodes = singleRowData[@"opencode"];
    // 所有的拼起来
    [singleRowData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![keys containsObject:key]) {

        } else {
            // 第几位 ( 只有一位)
            NSInteger yilouIndex = [keys indexOfObject:key];
            // 获取当前这一位的所有号码
            NSArray *singleYilouArr = (NSArray *) obj;
            for (NSInteger singleYilouIndex = 0, length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex++) {
                NSString *number = singleYilouArr[singleYilouIndex];
                // 当前这一位的开奖号码
                NSString *currentOpenCode;
                YZMovementsModel *model;
                if (!hasLine) {
                    if ([number integerValue] == 0) {
                        number = topTitles[singleYilouIndex];
                    }
                    model = [YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:row column:singleYilouIndex * 2  lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                    // 直接在这里处理

                } else {
                    if ([key isEqualToString:@"yilou"]) {
                        // 不分位的时候不使用openCode, 开奖号码对应的位置添加背景,并且将0 赋值为开奖号码
                        if ([number integerValue] == 0) {
                            number = [NSString stringWithFormat:@"%zd", singleYilouIndex];
                            model = [YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeCircle title:number row:row column:singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                        } else {
                            model = [YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:row column: singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                        }
                    } else {
                        // 个位十位百位的数据
                        currentOpenCode = openCodes[yilouIndex];
                        if ([number isEqualToString:@"0"]) {
                            model = [YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:YES bgType:BgTypeCircle title:currentOpenCode row:row column:singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                        } else {
                            model = [YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:row column: singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                        }
                    }
                }

                NSMutableArray *currentData = allDatas[yilouIndex];
                [currentData addObject:model];
                allDatas[yilouIndex] = currentData;
            }
        }
    }];
}

// 福彩3D 遗漏分析
+ (void)convertFucai3DYilouDataToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *datas = jsonDic[@"page"][@"ylzs"];
        NSArray *baiweiDatas = datas[@"baiwei"];
        NSArray *shiweiDatas = datas[@"shiwei"];
        NSArray *geweiDatas = datas[@"gewei"];

        NSArray *titles = @[@"号码",@"平均",@"最大",@"上次",@"本次",@"欲出几率"];
        NSArray *keys = @[@"order",@"avgyl",@"maxyl",@"preyl",@"curyl",@"yuchu"];

        NSMutableArray *allDatas = [NSMutableArray array];
        allDatas[0] = [NSMutableArray array];
        allDatas[1] = [NSMutableArray array];
        allDatas[2] = [NSMutableArray array];
        [self addSingleYilouDataWithArr:baiweiDatas allDatas:allDatas key:0 titles:titles keys:keys];
        [self addSingleYilouDataWithArr:shiweiDatas allDatas:allDatas key:1 titles:titles keys:keys];
        [self addSingleYilouDataWithArr:geweiDatas allDatas:allDatas key:2 titles:titles keys:keys];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(nil,nil,allDatas);
        });
    });
}
+ (void)addSingleYilouDataWithArr:(NSArray *)array allDatas:(NSMutableArray *)allDatas key:(NSInteger)key titles:(NSArray *)titles keys:(NSArray *)keys {
    NSMutableArray *datas = allDatas[key];
    // 添加标题
    for (NSInteger titleIndex = 0, length = titles.count; titleIndex < length; titleIndex++ ) {
        YZMovementsModel *model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:titles[titleIndex] row:0 column:titleIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
        [datas addObject:model];
    }
    for (NSInteger i = 0, length = array.count; i < length; i++ ) {
        NSDictionary *singleLineData = array[i];
        for (int singleLineDataIndex = 0, singleLineLength = keys.count; singleLineDataIndex < singleLineLength; ++singleLineDataIndex) {
            if (keys[singleLineDataIndex]) {
                NSString *title = singleLineData[keys[singleLineDataIndex]];
                YZMovementsModel *model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:title row:i + 1 column:singleLineDataIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                if ([keys[singleLineDataIndex] isEqualToString:@"order"]) {
                    model.bgType = BgTypeCircle;
                }
                [datas addObject:model];
            }

        }
    }
    allDatas[key] = datas;
}

// 福彩3D 冷热分析
+ (void)convertFucai3DLengreDataToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *datas = jsonDic[@"page"][@"ylzs"];
        NSArray *baiweiDatas = datas[@"baiwei"];
        NSArray *shiweiDatas = datas[@"shiwei"];
        NSArray *geweiDatas = datas[@"gewei"];

        NSArray *titles = @[@"号码",@"柱状图",@"次数",@"比例"];
        NSArray *keys = @[@"order",@"gailv",@"count",@"gailv"];

        NSMutableArray *allDatas = [NSMutableArray array];
        allDatas[0] = [NSMutableArray array];
        allDatas[1] = [NSMutableArray array];
        allDatas[2] = [NSMutableArray array];
        [self addSingleLengreDataWithArr:baiweiDatas allDatas:allDatas key:0 titles:titles keys:keys];
        [self addSingleLengreDataWithArr:shiweiDatas allDatas:allDatas key:1 titles:titles keys:keys];
        [self addSingleLengreDataWithArr:geweiDatas allDatas:allDatas key:2 titles:titles keys:keys];
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(nil,nil,allDatas);
        });
    });
}

+ (void)addSingleLengreDataWithArr:(NSArray *)array allDatas:(NSMutableArray *)allDatas key:(NSInteger)key titles:(NSArray *)titles keys:(NSArray *)keys {
    NSMutableArray *datas = allDatas[key];
    // 添加标题
    for (NSInteger titleIndex = 0, length = titles.count; titleIndex < length; titleIndex++ ) {
        YZMovementsModel *model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:titles[titleIndex] row:0 column:titleIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
        if (titleIndex == 0) {
        } else if (titleIndex == 1) {
            model.width = 3;
        } else {
            model.column = titleIndex + 2;
        }
        [datas addObject:model];
    }
    for (NSInteger i = 0, length = array.count; i < length; i++ ) {
        NSDictionary *singleLineData = array[i];
        for (int singleLineDataIndex = 0, singleLineLength = keys.count; singleLineDataIndex < singleLineLength; ++singleLineDataIndex) {
            if (keys[singleLineDataIndex]) {
                NSString *title = singleLineData[keys[singleLineDataIndex]];
                YZMovementsModel *model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:title row:i + 1 column:singleLineDataIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                if (singleLineDataIndex == 0) {
                } else if (singleLineDataIndex == 1) {
                    model.percent = [title doubleValue];
                    model.isPercent = YES;
                    model.width = 3;
                } else {
                    model.column = singleLineDataIndex + 2;
                }
                if (singleLineDataIndex == 3) {
                    model.title = [NSString stringWithFormat:@"%.1f%%", [title doubleValue] * 100];
                }
                [datas addObject:model];
            }
        }
    }
    allDatas[key] = datas;
}

// 排列5
+ (void)convertPailie5DataToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSArray *datas = jsonDic[@"page"][@"jbzs"];
        NSMutableArray *leftTitles = [NSMutableArray array];
        NSMutableArray *allDatas = [NSMutableArray array];
        NSArray *keys = @[@"yilou1", @"yilou2", @"yilou3", @"yilou4", @"yilou5"];
        for (int k = 0; k < keys.count; ++k) {
            [allDatas addObject:[NSMutableArray array]];
        }
        for (int i = 0, length = datas.count; i < length; ++i) {
            NSDictionary *singleRowData = datas[i];
            // 添加标题
            [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
            // 获取开奖号码
            NSArray *openCodes = singleRowData[@"opencode"];
            // 所有的拼起来
            [singleRowData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if (![keys containsObject:key]) {

                } else {
                    // 第几位 ( 0 - 6)
                    NSInteger yilouIndex = [keys indexOfObject:key];
                    // 当前这一位的开奖号码
                    NSString *currentOpenCode = openCodes[yilouIndex];
                    // 获取当前这一位的所有号码
                    NSArray *singleYilouArr = (NSArray *) obj;
                    for (NSInteger singleYilouIndex = 0, length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex++) {
                        NSString *number = singleYilouArr[singleYilouIndex];
                        YZMovementsModel *model;
                        if ([number isEqualToString:@"0"]) {
                            model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:YES bgType:BgTypeCircle title:currentOpenCode row:i column:singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                        } else {
                            model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:number row:i column:singleYilouIndex lineSerialNumber:0 type:YZMovementsModelPositionDefault];
                        }
                        NSMutableArray *currentData = allDatas[yilouIndex];
                        [currentData addObject:model];
                        allDatas[yilouIndex] = currentData;
                    }
                }
            }];
        }
        NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
        for (int j = 0; j < 10; ++j) {
            YZMovementsModel *model;
            model = [[YZMovementsModel alloc]
                                       initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd", j % 10] row:0 column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
            [topArr addObject:model];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            complete(leftTitles, topArr, allDatas);
        });
    });
}

@end
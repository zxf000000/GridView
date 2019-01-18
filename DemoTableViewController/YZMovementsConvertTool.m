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
+ (void)convertQilecaiJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *datas = jsonDic[@"page"][@"jbzs"];
    NSMutableArray *leftTitles = [NSMutableArray array];
    NSMutableArray *allDatas = [NSMutableArray array];
    for (NSInteger i = 0, length = datas.count; i < length; ++i) {
        NSDictionary *singleRowData = datas[i];
        // 添加标题
        [leftTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:singleRowData[@"expect"] row:i column:0 lineSerialNumber:0 type:YZMovementsModelPositionLeft]];
        // 获取开奖号码
        NSArray *openCodes = singleRowData[@"opencode"];
        // 红球分布 --- 主要数据
        NSArray *redfb = singleRowData[@"redfb"];
        // 篮球
        NSString *blueCode = [singleRowData[@"bluecode"] lastObject];
        // 单独一行数据
        NSMutableArray *singleRowDataArr = [NSMutableArray array];
        for (NSInteger redfbIndex = 0, length = redfb.count; redfbIndex < length; redfbIndex++) {
            NSString *numberText = redfb[redfbIndex];
            YZMovementsModelBallColor color = YZMovementsModelBallColorRed;
            BgType bgType = BgTypeNone;
            if ([numberText integerValue] == 0) {
                numberText = [NSString stringWithFormat:@"%zd",redfbIndex + 1];
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
        [singleRowDataArr addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:sanfq row:i column:singleRowDataArr.count lineSerialNumber:0 type:YZMovementsModelPositionDefault]];
        NSArray *sanfqArr = [sanfq componentsSeparatedByString:@":"];
        for (int sanfqindex = 0; sanfqindex < sanfqArr.count; ++sanfqindex) {
            [singleRowDataArr addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:sanfqArr[sanfqindex] row:i column:singleRowDataArr.count + 2  lineSerialNumber:0 type:YZMovementsModelPositionDefault]];
        }

        [allDatas addObjectsFromArray:singleRowDataArr];
    }

    NSMutableArray *topTitles = [NSMutableArray arrayWithCapacity:34];
    NSArray *otherTitles = @[@"三区比",@"一区",@"二区",@"三区"];
    for (NSInteger titleIndex = 0 ; titleIndex < 34; titleIndex++) {
        if (titleIndex < 30) {
            [topTitles addObject:[YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:NO bgType:BgTypeNone title:[NSString stringWithFormat:@"%zd",titleIndex + 1] row:0 column:titleIndex lineSerialNumber:0 type:YZMovementsModelPositionTop]];
        } else {
            [topTitles addObject:[YZMovementsModel modelWithWidth:2 height:1 hasLinePoint:NO bgType:BgTypeNone title:otherTitles[titleIndex - 30] row:0 column:31 + (titleIndex - 31) * 2 lineSerialNumber:0 type:YZMovementsModelPositionTop]];
        }
    }
    complete(leftTitles,topTitles,allDatas);

}

// 七星彩
+ (void)convertJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete {
    NSString *jsonString = [YZMovementsConvertTool stringFromFile:fileName];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSArray *datas = jsonDic[@"page"][@"jbzs"];
    NSMutableArray *leftTitles = [NSMutableArray array];
    NSMutableArray *allDatas = [NSMutableArray array];
    NSArray *keys = @[@"yilou1",@"yilou2",@"yilou3",@"yilou4",@"yilou5",@"yilou6",@"yilou7"];
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
                NSArray *singleYilouArr = (NSArray *)obj;
                for (NSInteger singleYilouIndex = 0 , length = singleYilouArr.count; singleYilouIndex < length; singleYilouIndex ++) {
                    NSString *number = singleYilouArr[singleYilouIndex];
                    BOOL hasLinePoint = [number isEqualToString:currentOpenCode];
                    BgType type = hasLinePoint ? BgTypeCircle : BgTypeNone;
                    YZMovementsModel *model = [YZMovementsModel modelWithWidth:1 height:1 hasLinePoint:hasLinePoint bgType:type title:number row:i column:yilouIndex * singleYilouCount + singleYilouIndex lineSerialNumber:yilouIndex type:YZMovementsModelPositionDefault];
                    NSLog(@"当前index === >>>>>>> %zd",yilouIndex * singleYilouCount + singleYilouIndex);
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

        for (NSInteger index = 0, length = singleRowYilou.allKeys.count; index < length; index ++) {
            [allDatas addObjectsFromArray:singleRowYilou[keys[index]]];
        }
    }
    NSMutableArray *topArr = [NSMutableArray arrayWithCapacity:20];
    for (NSInteger i = 0 ; i < 2 ; i ++) {
        YZMovementsModel *model;
        if (i == 0) {
            NSArray *titles = @[@"第一位",@"第二位",@"第三位",@"第四位",@"第五位",@"第六位",@"第七位"];
            for (int j = 0; j < 7; ++j) {
                model = [[YZMovementsModel alloc] initWithWidth:10 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:titles[j] row:i column:j*10 lineSerialNumber:0 type:YZMovementsModelPositionTop];
                [topArr addObject:model];
            }
        } else {
            for (int j = 0; j < 70; ++j) {
                model = [[YZMovementsModel alloc] initWithWidth:1 height:1 hasLinePoint:NO bgType:(BgTypeNone) title:[NSString stringWithFormat:@"%zd",j % 10] row:i column:j lineSerialNumber:0 type:YZMovementsModelPositionTop];
                [topArr addObject:model];
            }
        }
    }
    complete(leftTitles,topArr,allDatas);

}

@end
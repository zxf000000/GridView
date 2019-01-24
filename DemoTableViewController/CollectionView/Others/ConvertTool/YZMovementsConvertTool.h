//
// Created by 云舟02 on 2019-01-18.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ConvertDataCompleteHandle)(NSArray *leftTitles, NSArray *topTitles, NSArray *allDatas);

@interface YZMovementsConvertTool : NSObject

+ (NSString *)stringFromFile:(NSString *)name;

// 七星彩
+ (void)convertJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

+ (void)convertJsonToModelsWithFile:(NSString *)fileName
                        numberIndex:(NSInteger)numberIndex
                           complete:(ConvertDataCompleteHandle)complete;

// 七乐彩
+ (void)convertQilecaiJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

+ (void)convertQilecaiDaxiaoJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

+ (void)convertQilecaiJiouJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

// 福彩3D
+ (void)convertFucai3DJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

+ (void)convertFucai3DJsonToModelsWithFile:(NSString *)fileName
                               numberIndex:(NSInteger)numberIndex
                                  complete:(ConvertDataCompleteHandle)complete;

// 福彩3D 大小形态分布
+ (void)convertFucai3DDaxiaoJsonToModelsWithFile:(NSString *)fileName
                                        complete:(ConvertDataCompleteHandle)complete;

// 福彩3D 奇偶形态分布
+ (void)convertFucai3DJiouJsonToModelsWithFile:(NSString *)fileName
                                      complete:(ConvertDataCompleteHandle)complete;

// 福彩3D 质和形态分布
+ (void)convertFucai3DZhiheJsonToModelsWithFile:(NSString *)fileName
                                       complete:(ConvertDataCompleteHandle)complete;
// 福彩3D 遗漏分析
+ (void)convertFucai3DYilouDataToModelsWithFileName:(NSString *)fileName
                                           complete:(ConvertDataCompleteHandle)complete;
// 福彩3D 冷热分析
+ (void)convertFucai3DLengreDataToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

// 排列5
+ (void)convertPailie5DataToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;
// 11选5
+ (void)convert11xuan5JsonToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;
// 11选5奇偶
+ (void)convert11xuan5HezhiJsonToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;
// 11选5前一分部
+ (void)convert11xuan5QianyiJsonToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

// 胜负彩 -- 号码分布
+ (void)convertShengfucaiJsonToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;
// 赛过统计
+ (void)convertShengfucaiSaiguoJsonToModelsWithFileName:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

@end
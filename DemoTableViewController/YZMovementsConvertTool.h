//
// Created by 云舟02 on 2019-01-18.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ConvertDataCompleteHandle)(NSArray *topTitles, NSArray *leftTitles, NSArray *allDatas);

@interface YZMovementsConvertTool : NSObject

+ (NSString *)stringFromFile:(NSString *)name;

+ (void)convertJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

+ (void)convertQilecaiJsonToModelsWithFile:(NSString *)fileName complete:(ConvertDataCompleteHandle)complete;

@end
//
// Created by 云舟02 on 2019-01-22.
// Copyright (c) 2019 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YZYilouViewControllerType) {
    YZYilouViewControllerTypeYilou,
    YZYilouViewControllerTypeLengre
};

@interface YZYilouViewController : UIViewController

- (instancetype)initWithType:(YZYilouViewControllerType)type;

@end
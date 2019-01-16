//
//  TestModel.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019/1/16.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, BgType) {
    BgTypeCircle,
    BgTypeSquare,
    BgTypeFull,
    BgTypeNone,
};
NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject

@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

@property (nonatomic, assign) BOOL hasLinePoint;

@property (nonatomic, assign) BgType bgType;

@property (nonatomic,copy) NSString  *title;

@property(nonatomic, assign) NSInteger row;
@property(nonatomic, assign) NSInteger column;

- (instancetype)initWithWidth:(NSInteger)width height:(NSInteger)height hasLinePoint:(BOOL)hasLinePoint bgType:(BgType)type title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END

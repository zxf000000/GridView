//
//  AppDelegate.h
//  DemoTableViewController
//
//  Created by 云舟02 on 2019-01-03.
//  Copyright © 2019 云舟02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

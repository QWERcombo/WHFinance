//
//  AppDelegate.h
//  WHFinance
//
//  Created by wanhong on 2017/6/22.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end


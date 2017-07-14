//
//  TBTabBarController.h
//  GoGoTree
//
//  Created by youqin on 16/8/30.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBTabBarController : UITabBarController

@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,strong)NSMutableDictionary *pushDic;


-(void)setupchildVc:(NSObject *)model;

@end

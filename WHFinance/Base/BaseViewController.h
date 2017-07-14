//
//  BaseViewController.h
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) AppDelegate * appDelegate;
@property (nonatomic,strong) UITableView *tabView;

@property (nonatomic,strong) NSString *titleStr;

@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSMutableArray *dataMuArr;

@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSMutableDictionary *dataMuDic;

@property (nonatomic,strong) NSString *theID;

@property(nonatomic,strong) UIView *backView;

@property(nonatomic,strong)NSString *vcType;//页面类型

@property (nonatomic,assign) BOOL isDirectionRight;//是否侧滑手势
@property (nonatomic,assign) BOOL present;//是否模态弹出
@property (nonatomic,assign) BOOL navMianColor;//导航条是否是主题色
@property(nonatomic,strong) UIImage *navIMG;//导航条特殊定制背景（透明）



- (BOOL) isBlankString:(NSString *)string ;//判断是否有空字符

-(UIView *)createReloadButton;

-(UIView *)createNothingView;


@end

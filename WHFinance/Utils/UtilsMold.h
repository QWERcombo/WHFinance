//
//  UtilsMold.h
//  GoGoTree
//
//  Created by youqin on 16/8/11.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import <Foundation/Foundation.h>

//Cell
#import "MessageListCell.h"
#import "WithdrawRecordCell.h"
#import "BillListCell.h"
#import "MineListCell.h"
#import "MineCustomerCell.h"
#import "MineCustomerListCell.h"
#import "OpenProductListCell.h"
#import "BindedCell.h"
#import "WithdrawCell.h"
#import "MyProfitDetailCell.h"
#import "BankCardChooseCell.h"

//View
#import "ABBannerView.h"
#import "SlideSwitchView.h"
 


@interface UtilsMold : NSObject

AS_SINGLETON(UtilsMold);

typedef void (^ShowBlock)(NSDictionary *clueDic);

@property (nonatomic, copy) ShowBlock _showBlock;


//cell
+ (UITableViewCell *)creatCell:(NSString *)type table:(UITableView *)tableView deledate:(UIViewController *)deledate model:(NSObject *)model data:(id)data andCliker:(ShowBlock)clue;
//cel高度
+ ( float)getCellHight:(NSString *)type data:(id)data model:(NSObject *)model indexPath:(NSIndexPath *)indexpath;
//view
- (UIView *)creatView:(NSString *)type data:(id)data  model:(NSObject *)model deleGate:(id)delegate andCliker:(ShowBlock)clue;

@end

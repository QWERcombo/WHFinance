//
//  ZZPhotoBrowerViewController.h
//  ZZPhotoKit
//
//  Created by 袁亮 on 16/5/27.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZResourceConfig.h"
#import "ZZPhoto.h"

@interface ZZPhotoBrowerViewController : UIViewController
typedef void (^ClikBlock)(NSString *clueStr);
@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, copy) void(^ReturnArrBlock)(NSArray *array);
@property (nonatomic,   strong) NSMutableArray *photoData;
@property (nonatomic, assign) NSInteger scrollIndex;
@property (nonatomic, assign) BOOL hasPageControl;//点点点
@property (nonatomic, assign) BOOL hasDelete;//删除按钮
@property (nonatomic, assign) BOOL hasCheck;//预览选中
@property (nonatomic, assign) BOOL isScan;//预览
@property (nonatomic, assign) BOOL isAllScan;//全部预览
-(void) showIn:(UIViewController *)controller with:(ClikBlock)club;

@end

//
//  BaseViewController+KeyBoard.h
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (KeyBoard)
/**
 设置键盘距离被编辑的view的bottom的距离（默认距离为10）； 如要使用，需先导入此category文件.
 界面销毁时，自动移除键盘监听通知，并结束本界面的编辑状态。
 键盘回收需各界面自己处理
 */
@property (nonatomic, assign) CGFloat lxlKeyboardOffsetEditingViewBottom; //键盘距离正在编辑的view的底部的距离
@end

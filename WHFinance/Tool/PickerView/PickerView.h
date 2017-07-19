//
//  PickerView.h
//  text
//
//  Created by Apple on 2017/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^QQStrResultBlock)(NSString *string);
@interface PickerView : UIView

+(void)showPickerView:(UIView *)view componentNum:(NSInteger)num typePickerID:(NSInteger)typeID selectStr:(NSString *)selectStr StrBlock:(QQStrResultBlock)strBlock;
@end

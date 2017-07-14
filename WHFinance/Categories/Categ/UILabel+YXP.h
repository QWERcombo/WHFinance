//
//  UILabel+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBAttributeModel : NSObject{

}

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end
@interface UILabel (YXP)
@property (nonatomic, assign) BOOL enabledTapEffect;

- (void)TB_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

-(NSMutableAttributedString *)changeAttributeForColorInFormer:(NSString *)former latter:(NSString *)latter reply:(NSString *)reply font:(UIFont *)font;

+ (id)lableWithText:(NSString *)text Font:(UIFont *)font TextColor:(UIColor *)textColor;

+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size;

//富文本
+(NSMutableAttributedString *)labGetAttributedStringFrom:(NSInteger )start toEnd:(NSInteger)end WithColor:(UIColor *)color andFont:(UIFont *)font allFullText:(NSString *)labelText;
@end

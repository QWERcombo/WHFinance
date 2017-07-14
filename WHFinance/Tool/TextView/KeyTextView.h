//
//  KeyTextView.h
//  GoGoTree
//
//  Created by youqin on 16/8/13.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyTextView;

@protocol KeyTextViewDelegate <NSObject>

-(void)sendText:(KeyTextView *)textView text:(NSString *)text andModel:(NSObject *)model;

-(void)keyTextViewDidChange:(NSString *)text;

@end

@interface KeyTextView : UIView

@property (weak, nonatomic) UITextView *textView;

@property (weak, nonatomic) UIButton *sendBtn;

@property (copy, nonatomic) NSString *placeholder;

@property (nonatomic, strong) UILabel *label;

@property (assign, nonatomic) id<KeyTextViewDelegate> deleagte;


+ (void)showKeyTextView:(NSObject *)date andTag:(NSInteger)tag delegate:(id)surView;

@end


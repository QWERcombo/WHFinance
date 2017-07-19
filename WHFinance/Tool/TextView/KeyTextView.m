//
//  KeyTextView.m
//  GoGoTree
//
//  Created by youqin on 16/8/13.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "KeyTextView.h"
//#import "CommentsVC.h"

static CGFloat ious_h = 160.0f;

@interface KeyTextView()<UITextViewDelegate>
@property (assign, nonatomic) CGFloat superHight;
@property (strong, nonatomic) UIView *iousView;
@property (strong, nonatomic) UIView *blackView;
@property (strong, nonatomic) UILabel *numLab;
@property (assign, nonatomic) id model;
////
@end


@implementation KeyTextView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        self.backgroundColor = [UIColor clearColor];
        
//        self.blackView = [UIView viewWithBackgroudColor:[[UIColor blackColor]colorWithAlphaComponent:0.5]];
        self.blackView.alpha = 0;
        UITapGestureRecognizer *tapPP = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPPAction:)];
        [self.blackView addGestureRecognizer:tapPP];
        [self addSubview:self.blackView];
        [self.blackView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.mas_top).offset(-50);
        }];
        self.iousView = [self iousVIew];
        self.iousView.frame = CGRectMake(0, SCREEN_HEIGHT, self.width, ious_h);
        [self addSubview:self.iousView ];
    }
    return self;
}

- (void) tapPPAction:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
}

-(UIView *)iousVIew
{
    UIView *iousView = [[UIView alloc] init];
    iousView.backgroundColor = [UIColor whiteColor];
    
    self.numLab = [UILabel lableWithText:@"0/140" Font:FONT_ArialMT(16) TextColor:[UIColor lightGrayColor]];
    [iousView addSubview:self.numLab];
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(iousView.mas_bottom).with.offset(-10);
        make.left.equalTo(iousView.mas_left).with.offset(20);
        make.height.equalTo(@20);
    }];
    
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitleColor:[UIColor Grey_PurColor] forState:UIControlStateNormal];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sednBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [iousView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(iousView.mas_bottom).with.offset(-5);
        make.right.equalTo(iousView.mas_right).with.offset(-20);
        make.height.equalTo(@30);
        make.width.equalTo(@60);
    }];
    
    
    UITextView *textView = [[UITextView alloc] init];
    textView.delegate    = self;
    textView.textColor   = [UIColor grayColor];
    textView.font = FONT_ArialMT(18);
    textView.layoutManager.allowsNonContiguousLayout = NO;
    [textView setCheekWithColor:[UIColor lightGrayColor] borderWidth:1.0 roundedRect:0];
    [iousView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iousView.mas_top).with.offset(20);
        make.bottom.equalTo(sendBtn.mas_top).with.offset(-5);
        make.left.equalTo(iousView.mas_left).with.offset(20);
        make.right.equalTo(iousView.mas_right).with.offset(-20);
    }];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectZero];
    self.label.enabled = YES;
    self.label.numberOfLines=1;
    self.label.frame = CGRectMake(5, 7, 200, 20);
    self.label.font =  FONT_ArialMT(17);
    self.label.textColor = [UIColor colorWithR:200 G:200 B:200 A:1];
    [textView addSubview:_label];
    
    self.textView = textView;
    
    
    return iousView;
}

- (void)sednBtnAction{
    if ([self.textView.text textLength] > 140) {
        
        [[UtilsData sharedInstance]showAlertTitle:@"评论字数超出限制" detailsText:nil time:1.5 aboutType:MBProgressHUDModeText state:NO];

        return;
    }
    if ([self.deleagte  respondsToSelector:@selector(sendText:text:andModel:)]) {
        [self.deleagte  sendText:self text:_textView.text andModel:self.model];
    }
    
    [_textView resignFirstResponder];
    _textView.text = _placeholder;
    _textView.textColor = [UIColor grayColor];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textView.text = _placeholder;
}

#pragma mark - == UITextViewDelegate ==
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _textView.text = @"";
    _textView.textColor = [UIColor blackColor];
    
}
- (void)textViewDidChange:(UITextView *)textView{
    NSInteger numWord = [textView.text textLength];
    NSString *wordStr = [NSString stringWithFormat:@"%lu/140",(long)numWord];
    if (numWord >140) {
        self.numLab.attributedText = [NSString changeFont:@[[NSString stringWithFormat:@"%ld",(long)numWord]] content:wordStr andColor:@[[UIColor redColor]] andFont:@[self.numLab.font]];
    }else{
        self.numLab.text = wordStr;
    }
    if ([self.deleagte  respondsToSelector:@selector(keyTextViewDidChange:)]) {
        [self.deleagte  keyTextViewDidChange:textView.text];
    }
    if (textView.text.length == 0) {
        [self.label setHidden:NO];
    } else {
        [self.label setHidden:YES];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
   }

- (void)textViewDidEndEditing:(UITextView *)textView{

}

//这个是汉语联想的时候的他会出现的，第一次暂时让其联想，下次输入就不能联想了，因为第一次联想它不给自己算lenth，下次再联想词汇就会算上上次输入的，这个是苹果自己的BUG 如果是textfiled，一样 检测每个字符的变化。
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if ([textView.text textLength]>=140)
    {
        return YES;
    }
    else
    {
        return YES;
    }
    return YES;
    
}


#pragma mark - == 键盘弹出事件 ==
- (void)keyboardWasShow:(NSNotification*)notification{
    
    CGRect keyBoardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self translationWhenKeyboardDidShow:keyBoardFrame.size.height];
}

- (void)keyboardWillBeHidden:(NSNotification*)notification{
    
    [self translationWhenKeyBoardDidHidden];
}

- (void)translationWhenKeyboardDidShow:(CGFloat)keyBoardHight{
    [UIView animateWithDuration:0.25 animations:^{
        self.blackView.alpha = 1;
//        NSLog(@"%f ~~%f",self.superHight,SCREEN_HEIGHT);
        self.iousView.frame = CGRectMake(0, self.superHight -(keyBoardHight+ious_h), self.width, ious_h);
    }];
}

- (void)translationWhenKeyBoardDidHidden{
    [UIView animateWithDuration:0.25 animations:^{
        self.iousView.frame = CGRectMake(0, SCREEN_HEIGHT, self.width, ious_h);
        self.blackView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (void)showKeyTextView:(NSObject *)date andTag:(NSInteger)tag delegate:(id)surView{
//    NSLog(@"%@----%@", date, surView);
    UIViewController *vc = (UIViewController *)surView;

    for (UIView *view in vc.view.subviews ) {
        if ([view isKindOfClass:[KeyTextView class]]) {
            [view removeFromSuperview];
        }
    }
    
//    KeyTextView *textView = nil;
//    if ([surView isKindOfClass:[ClubCircleListViewController class]]) {
//        textView = [[KeyTextView alloc] initWithFrame:CGRectMake(0, 50, vc.view.width, vc.view.height-50)];
//    } else {
//        textView = [[KeyTextView alloc] initWithFrame:CGRectMake(0, 0, vc.view.width, vc.view.height)];
//    }
//    textView.tag = tag;
//    textView.deleagte = surView;
//    if(date)textView.model = date;
//    if (date) {
//        CommentData *dic = (CommentData *)date;
//        if(dic.userName)textView.label.text = [NSString stringWithFormat:@"@%@", dic.userName];
//    }else{
//        textView.label.text = @"发表自己的评论";
//    }
//    textView.superHight = vc.view.height;
//    [textView.textView becomeFirstResponder];
//    [vc.view addSubview:textView];
    
}

@end

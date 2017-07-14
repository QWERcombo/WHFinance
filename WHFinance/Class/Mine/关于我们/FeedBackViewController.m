//
//  FeedBackViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UILabel *hintLab;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"意见反馈";
    
    [self createMainView];
}


- (void)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    [self.view addSubview:mainView];
    
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 150)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    
    self.textView = [UITextView new];
    self.textView.delegate = self;
    self.textView.font = FONT_ArialMT(15);
    [content addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content.mas_left).offset(13);
        make.right.equalTo(content.mas_right).offset(-13);
        make.top.equalTo(content.mas_top).offset(15);
        make.bottom.equalTo(content.mas_bottom).offset(-12.5);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.enabled = YES;
    label.text = @"5252";
    label.numberOfLines=0;
    CGSize labSize = [UILabel getSizeWithText:label.text andFont:[UIFont fontWithSize:15] andSize:CGSizeMake(SCREEN_WIGHT-40, 0)];
    label.frame = CGRectMake(5, 5, labSize.width, labSize.height+5);
    label.font =  [UIFont fontWithSize:15];
    label.textColor = [UIColor colorWithR:200 G:200 B:200 A:1];
    self.hintLab = label;
    [self.textView addSubview:self.hintLab];
    
    
    self.countLab = [UILabel lableWithText:@"(0/200)" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    [content addSubview:self.countLab];
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(content.mas_right).offset(-13);
        make.bottom.equalTo(content.mas_bottom).offset(-13);
        make.height.equalTo(@(12));
    }];
    
    
    UIButton *button = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"register_btn") andHighlightedImage:IMG(@"register_btn")];
    [mainView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(mainView.mas_left).offset(12.5);
        make.right.equalTo(mainView.mas_right).offset(-12.5);
        make.top.equalTo(content.mas_bottom).offset(20);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *ediTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ediTapAction:)];
    [mainView addGestureRecognizer:ediTap];
    
}


- (void)ediTapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
- (void)buttonAction:(UIButton *)sender {
    [self sendData];
    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"意见已提交，感谢您的反馈!" time:2 aboutType:MBProgressHUDModeCustomView state:YES];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController popViewControllerAnimated:YES];
//    });
}
- (void)sendData {
    [self.view endEditing:YES];
    NSLog(@"---%@", _textView.text);
}

#pragma mark - TextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (self.textView.text.length == 0 ) {
        [self.hintLab setHidden:NO];
    } else {
        [self.hintLab setHidden:YES];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    //NSLog(@"---%@", toBeString);
    NSInteger charLength = [toBeString textLength];
    _countLab.text = [NSString stringWithFormat:@"(%ld/30)", charLength];
    if (charLength >= 30) {
        _countLab.textColor = [UIColor redColor];
        return NO;
    } else {
        _countLab.textColor = [UIColor Black_WordColor];
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

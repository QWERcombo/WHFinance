//
//  WithdrawRecordViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "WithdrawRecordViewController.h"
#import "WithdrawViewController.h"
#import "TradeResultViewController.h"

@interface WithdrawRecordViewController ()<UITextFieldDelegate>{
    UIButton *codeBtn;
}
@property (nonatomic, strong) UITextField *codeTF;
@end

@implementation WithdrawRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认支付";
    [self.dataMuArr addObjectsFromArray:@[@"姓名",@"支付金额",@"支付卡号",@"所属银行",@"验证码"]];
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}


- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *hintLab = [UILabel lableWithText:@"    请确认" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:1]];
    hintLab.backgroundColor = [UIColor Grey_BackColor1];
    [mainView addSubview:hintLab];
    [hintLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(25));
        make.top.left.right.equalTo(mainView);
    }];
    
    UIView *content = [UIView new];
    [mainView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(mainView);
        make.top.equalTo(hintLab.mas_bottom);
        make.height.equalTo(@(225));
    }];
    
    
    for (NSInteger i=0; i<5; i++) {
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i, SCREEN_WIGHT, 45)];
        [content addSubview:blank];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 44, SCREEN_WIGHT-20, 1)];
        line.backgroundColor = [UIColor Grey_LineColor];
        if (i!=4) {
            [blank addSubview:line];
        }
        
        UILabel *left = [UILabel lableWithText:[self.dataMuArr objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_BackColor]];
        [blank addSubview:left];
        [left mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(14));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(10);
        }];
        
        NSArray *temp = @[@"张三",@"20.00",@"2656523131313(中国招商银行)",@"中国招商银行",@"请输入验证码"];
        if (i==4) {
            
            self.codeTF = [[UITextField alloc] init];
            self.codeTF.delegate = self;
            self.codeTF.placeholder = [temp objectAtIndex:i];
            self.codeTF.font = FONT_ArialMT(14);
            self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
            self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
            self.codeTF.textAlignment = NSTextAlignmentCenter;
            [self.codeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [blank addSubview:self.codeTF];
            [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(25));
                make.width.equalTo(@(150));
                make.centerY.equalTo(blank.mas_centerY);
                make.right.equalTo(blank.mas_right).offset(-10);
            }];
            
            
        } else {
            UILabel *right = [UILabel lableWithText:[temp objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
            [blank addSubview:right];
            right.textAlignment = NSTextAlignmentRight;
            [right mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(14));
                make.centerY.equalTo(blank.mas_centerY);
                make.right.equalTo(blank.mas_right).offset(-10);
                make.left.equalTo(left.mas_right).offset(15);
            }];
        }
        
    }
    
    
    
    UIButton *button = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    button.backgroundColor = [UIColor mianColor:1];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [mainView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(mainView.mas_left).offset(12.5);
        make.right.equalTo(mainView.mas_right).offset(-12.5);
        make.top.equalTo(content.mas_bottom).offset(20);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return mainView;
}


- (void)buttonAction:(UIButton *)sender {
    //提交无卡支付
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID,@"smsCode":@"000000"}] forKey:@"transc.doQuickPayment"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++++%@", resultDic);
        if ([resultDic[@"resultData"] integerValue]==2) {//成功
            TradeResultViewController *result = [TradeResultViewController new];
            [self.navigationController pushViewController:result animated:YES];
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


- (void)textFieldDidChange:(UITextField *)keyText {
    
    NSLog(@"%@", keyText.text);
    
}


- (void)codeAction:(UIButton *)sender {
    [self.view endEditing:YES];
//    [[PublicFuntionTool sharedInstance] getSmsCodeByPhoneString:self.phone];
    [self startTimer:sender];
}

- (void)startTimer:(UIButton *)btnCoder
{
    codeBtn.enabled = NO;
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                codeBtn.enabled = YES;
                [btnCoder setTitle:@"重新发送" forState:UIControlStateNormal];
            });
        }else{
            //            int minutes = timeout / 60;
            NSString *strTime = [NSString stringWithFormat:@"%d 秒",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btnCoder setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
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

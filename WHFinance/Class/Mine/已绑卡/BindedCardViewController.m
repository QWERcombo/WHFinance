//
//  BindedCardViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "BindedCardViewController.h"
#import "CardInformationViewController.h"
#import "JoinParterViewController.h"
#import "NoCardInfamationViewController.h"
#import "WithdrawRecordViewController.h"
#import "TradeResultViewController.h"

@interface BindedCardViewController (){
    UIButton *codeBtn;
    UIDatePicker *datap;
    UIView *backView;
}
@property (nonatomic, strong) LQXSwitch *switch_choose;
@property (nonatomic, assign) BOOL isReal; //是否是本人
@property (nonatomic, strong) NSString *orderID;
@end

@implementation BindedCardViewController
- (LQXSwitch *)switch_choose {
    if (!_switch_choose) {
        _switch_choose = [[LQXSwitch alloc] initWithFrame:CGRectMake(240, 65, 80, 20) onColor:[UIColor grayColor] offColor:[UIColor grayColor] font:[UIFont systemFontOfSize:12] ballSize:20];
        _switch_choose.onText = @"本人";
        _switch_choose.offText = @"非本人";
        [_switch_choose addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switch_choose;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"无卡支付";
    
    [self setUpSubviews];
}

- (void)setUpSubviews {
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
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




- (UIView *)createMainView  {//未认证状态
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    mainView.tag = 777;
    UIImageView *logo = [UIImageView new];
    [mainView addSubview:logo];
    logo.image = IMG(@"pay_way_nocard");
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(20);
        make.top.equalTo(mainView.mas_top).offset(27);
        make.width.equalTo(@(98));
        make.height.equalTo(@(24));
    }];
    UILabel *llll = [UILabel lableWithText:@"支付金额" Font:FONT_ArialMT(10) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:llll];
    [llll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(10));
        make.left.equalTo(logo.mas_left);
        make.top.equalTo(logo.mas_bottom).offset(5);
    }];
    UILabel *mmmm = [UILabel lableWithText:@"交易银行有积分，单笔最高两万" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:mmmm];
    [mmmm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.right.equalTo(mainView.mas_right).offset(-20);
        make.top.equalTo(logo.mas_top);
    }];
    
    UILabel *cashLab = [UILabel lableWithText:[NSString pointTailTwo:self.cashCount] Font:FONT_ArialMT(24) TextColor:[UIColor mianColor:1]];
    [mainView addSubview:cashLab];
    [cashLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(24));
        make.right.equalTo(mmmm.mas_right);
        make.top.equalTo(mmmm.mas_bottom).offset(10);
    }];
    
    
    //主要内容
    UIView *content = [UIView new];
    [mainView addSubview:content];
    content.backgroundColor = [UIColor whiteColor];
    content.layer.cornerRadius = 10;
    content.clipsToBounds = YES;
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(400));
        make.left.equalTo(mainView.mas_left).offset(10);
        make.right.equalTo(mainView.mas_right).offset(-10);
        make.top.equalTo(llll.mas_bottom).offset(17);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor colorWithR:221 G:221 B:221 A:1];
    [content addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(45));
        make.left.top.right.equalTo(content);
    }];
    
    UIView *vvv = [UIView joinUsWithStatus:NO];
    [topView addSubview:vvv];
    [vvv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.right.equalTo(topView.mas_right).offset(-5);
        make.height.equalTo(@(20));
    }];
    UITapGestureRecognizer *vvvtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vvvTap:)];
    [vvv addGestureRecognizer:vvvtap];
    
    UILabel *textLab = [UILabel lableWithText:@"普通级会员手续费0.02元\n创业合伙人手续费0.02元" Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:2]];
    textLab.numberOfLines = 2;
    [topView addSubview:textLab];
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView.mas_left).offset(10);
        make.top.equalTo(topView.mas_top).offset(0);
        make.bottom.equalTo(topView.mas_bottom).offset(5);
    }];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 5;
    NSRange rang = NSMakeRange(0, textLab.text.length/2);
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:textLab.text attributes:@{NSParagraphStyleAttributeName:para}];
    [attstr addAttribute:NSFontAttributeName value:FONT_ArialMT(11) range:rang];
    [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor mianColor:1] range:rang];
    textLab.attributedText = attstr;
    
    UILabel *cardHolder = [UILabel lableWithText:@"持卡人" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:cardHolder];
    [cardHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(24);
        make.left.equalTo(content.mas_left).offset(10);
        make.height.equalTo(@(12));
    }];
    UILabel *cardNum = [UILabel lableWithText:@"身份证号码" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:cardNum];
    [cardNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardHolder.mas_bottom).offset(20);
        make.left.equalTo(content.mas_left).offset(10);
        make.height.equalTo(@(12));
    }];
    if (!_isReal) {
        UILabel *nameLab = [UILabel lableWithText:[UserData currentUser].userName Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [content addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content.mas_left).offset(90);
            make.height.equalTo(@(12));
            make.top.equalTo(cardHolder.mas_top);
        }];
        
        UILabel *numberLab = [UILabel lableWithText:@"858585858585858585" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [content addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content.mas_left).offset(90);
            make.height.equalTo(@(12));
            make.top.equalTo(cardNum.mas_top);
        }];
        
    } else {
        UITextField *nameLab = [UITextField new];
        [content addSubview:nameLab];
        nameLab.placeholder = @"姓名";
        nameLab.tag = 1011;
        nameLab.font = FONT_ArialMT(12);
        nameLab.borderStyle = UITextBorderStyleRoundedRect;
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content.mas_left).offset(90);
            make.height.equalTo(@(30));
            make.centerY.equalTo(cardHolder.mas_centerY);
            make.width.equalTo(@(120));
        }];
        
        UITextField *numberLab = [UITextField new];
        numberLab.keyboardType = UIKeyboardTypeNumberPad;
        numberLab.borderStyle = UITextBorderStyleRoundedRect;
        [content addSubview:numberLab];
        numberLab.placeholder = @"请输入持卡人身份证号";
        numberLab.tag = 1012;
        numberLab.font = FONT_ArialMT(12);
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(content.mas_left).offset(90);
            make.height.equalTo(@(30));
            make.centerY.equalTo(cardNum.mas_centerY);
            make.width.equalTo(@(150));
        }];
        
        
    }
    
    
    self.switch_choose.frame = CGRectMake(220, 65, 75, 20);
    [content addSubview:self.switch_choose];
    
    
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor Grey_BackColor1];
    [content addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.equalTo(content.mas_left).offset(15);
        make.right.equalTo(content.mas_right).offset(-15);
        make.top.equalTo(cardNum.mas_bottom).offset(22);
    }];
    
    
    UIView *lastView = nil;
    for (NSInteger i=0; i<5; i++) {
        NSArray *placeholder = @[@"请输入卡号",@"信用卡有效期",@"信用卡背面后三位数",@"信用银行预留手机号",@"请输入短信验证码"];
        UITextField *tf = [[UITextField alloc] init];
        tf.font = FONT_ArialMT(12);
        tf.tag = 1000+i;
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.placeholder = [placeholder objectAtIndex:i];
        if (i==1) {
            tf.userInteractionEnabled = NO;
        }
        [content addSubview:tf];
        [tf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(30));
            if (i==4 || i==1) {
                make.width.equalTo(@(120));
            } else {
                make.right.equalTo(content.mas_right).offset(-10);
            }
            
            make.left.equalTo(content.mas_left).offset(95);
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom).offset(10);
            } else {
                make.top.equalTo(line.mas_bottom).offset(14);
            }
        }];
        
        lastView = tf;
        
        NSArray *array = @[@"信用卡号",@"信用卡有效期",@"CVV2",@"手机号码",@"验证码"];
        UILabel *label = [UILabel lableWithText:[array objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [content addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(12));
            make.left.equalTo(content.mas_left).offset(10);
            make.centerY.equalTo(tf.mas_centerY);
        }];
        
    }
    
    codeBtn = [UIButton buttonWithTitle:@"获取验证码" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [content addSubview:codeBtn];
    codeBtn.backgroundColor = [UIColor mianColor:1];
    codeBtn.layer.cornerRadius = 5;
    codeBtn.clipsToBounds = YES;
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(75));
        make.left.equalTo(content.mas_left).offset(220);
        make.bottom.equalTo(content.mas_bottom).offset(-60);
    }];
    
    UIButton *dateBtn = [UIButton buttonWithTitle:@"选择有效期" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [content addSubview:dateBtn];
    dateBtn.layer.cornerRadius = 5;
    dateBtn.clipsToBounds = YES;
    [dateBtn addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventTouchUpInside];
    dateBtn.backgroundColor = [UIColor mianColor:1];
    [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(30));
        make.width.equalTo(@(75));
        make.left.equalTo(content.mas_left).offset(220);
        make.bottom.equalTo(content.mas_bottom).offset(-180);
    }];
    
    
    UIButton *bottomBtn = [UIButton buttonWithTitle:@"提交支付" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [content addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    bottomBtn.backgroundColor = [UIColor mianColor:1];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(45));
        make.left.right.bottom.equalTo(content);
    }];
    
    return mainView;
}

- (void)dateAction:(UIButton *)sender {//获取日期
    backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    datap = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-200, SCREEN_WIGHT, 200)];
    datap.datePickerMode = UIDatePickerModeDate;
    datap.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [backView addSubview:datap];
    datap.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *dataTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dataTapAction:)];
    UIView *actionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-240, SCREEN_WIGHT, 40)];
    actionView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:actionView];
    UIButton *cancel = [UIButton buttonWithTitle:@"取消" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor mianColor:1] andNormaImage:nil andHighlightedImage:nil];
    cancel.frame = CGRectMake(15, 10, 50, 20);
    [actionView addSubview:cancel];
    UIButton *done = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor mianColor:1] andNormaImage:nil andHighlightedImage:nil];
    done.frame = CGRectMake(SCREEN_WIGHT-65, 10, 50, 20);
    [actionView addSubview:done];
    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [done addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *hintlab = [UILabel lableWithText:@"选择信用卡有效期" Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [actionView addSubview:hintlab];
    [hintlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(actionView.mas_centerY);
        make.centerX.equalTo(actionView.mas_centerX);
        make.height.equalTo(@(14));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIGHT, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [actionView addSubview:line];
    
    
    [backView addGestureRecognizer:dataTap];
    [self.view addSubview:backView];
    
}
- (void)dataTapAction:(UITapGestureRecognizer *)sender {
    [datap removeFromSuperview];
    [backView removeFromSuperview];
}
- (void)cancelAction:(UIButton *)sender {
    [datap removeFromSuperview];
    [backView removeFromSuperview];
}
- (void)doneAction:(UIButton *)sender {
    NSDateFormatter *fomatter = [NSDateFormatter new];
    fomatter.dateFormat = @"yyyy/MM/dd";
    NSString *dateStr = [fomatter stringFromDate:datap.date];
    UITextField *tf = [self.view viewWithTag:1001];
    tf.text = dateStr;
    [datap removeFromSuperview];
    [backView removeFromSuperview];
}

- (void)changeAction:(UISwitch *)sender {//本人||非本人
    //    NSLog(@"%d", sender.on);
    if (sender.on) {
        if ([self.isPartner isEqualToString:@"yes"]) {
            [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"不能为他人开合伙人" doneTitle:@"确定" cancelTitle:@"" haveCancel:NO doneAction:^{
                
            } controller:self];
            return;
        }
        self.isReal = YES;
    } else {
        self.isReal = NO;
    }
    UIView *vvvv = [self.view viewWithTag:777];
    [vvvv removeFromSuperview];
    UIView *vv = [self createMainView];//未认证
    [self.view addSubview:vv];
    
}

//获取验证码
- (void)codeAction:(UIButton *)sender {
    //    [[PublicFuntionTool sharedInstance] getSmsCodeByPhoneString:@""];
    [self startTimer:sender];
    UITextField *ttt = [self.view viewWithTag:1000];
    NSLog(@"%@---%@", ttt, ttt.text);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"transAmount":self.cashCount,@"subProductId":@"3",@"isSelf":[NSString stringWithFormat:@"%d", !self.switch_choose.on],@"transUserCardInfo":@{@"cardHolderName":@"李四",@"cardIdentityNo":@"440402198800000000",@"cardIdentityType":@"01",@"cardNo":[NSString stringWithFormat:@"62220240000198100%@", ttt.text],@"cardPhoneNo":@"13800130000",@"cvn":@"123",@"expDate":@"22"}}] forKey:@"transc.placeOrder"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        self.orderID = resultDic[@"resultData"];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}
- (void)startTimer:(UIButton *)btnCoder//获取验证码
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
            //                        int minutes = timeout / 60;
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
- (void)vvvTap:(UITapGestureRecognizer *)sender {//加入创业合伙人
    JoinParterViewController *join = [JoinParterViewController new];
    [self.navigationController pushViewController:join animated:YES];
}

- (void)payAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID,@"smsCode":@"000000"}] forKey:@"transc.doQuickPayment"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++++%@", resultDic);
        if (self.isReal) {//非本人
            NoCardInfamationViewController *infa = [NoCardInfamationViewController new];
            infa.orderID = self.orderID;
            [self.navigationController pushViewController:infa animated:YES];
        } else {//本人
//            [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"交易成功" time:2.0 aboutType:MBProgressHUDModeCustomView state:YES];
            if ([resultDic[@"resultData"] integerValue]==2) {//成功
                TradeResultViewController *result = [TradeResultViewController new];
                [self.navigationController pushViewController:result animated:YES];
            }
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
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

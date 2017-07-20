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
}
@property (nonatomic, strong) LQXSwitch *switch_choose;
@property (nonatomic, assign) BOOL isReal; //是否是本人
@property (nonatomic, strong) NSString *orderID;
@property (nonatomic, strong) NSString *cardHolder;//持卡人
@property (nonatomic, strong) NSString *identiCardNo;//身份证号
@property (nonatomic, strong) NSString *creditCardNo;//信用卡号
@property (nonatomic, strong) NSString *creditCardDate;//信用阿卡有效期
@property (nonatomic, strong) NSString *CVV2No;//cvv2
@property (nonatomic, strong) NSString *phoneNo;//手机号
@property (nonatomic, strong) NSString *codeNo;//验证码
@property (nonatomic, strong) NSString *orderTime;//订单时间
@property (nonatomic, strong) RealCertificateModel *model;
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
    self.title = @"无卡支付";
    
    [self getRealName];//获取持卡人信息
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
    
    UIView *vvv = [UIView joinUsWithStatus:[[UserData currentUser].isPartner integerValue]==1?YES:NO];
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
    if (self.isPartner) {
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
    } else {
        if (!_isReal) {
            UILabel *nameLab = [UILabel lableWithText:self.model.realName Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
            [content addSubview:nameLab];
            [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(content.mas_left).offset(90);
                make.height.equalTo(@(12));
                make.top.equalTo(cardHolder.mas_top);
            }];
            
            UILabel *numberLab = [UILabel lableWithText:self.model.identityCardNo Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
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
        NSArray *placeholder = @[@"请输入信用卡号",@"信用卡有效期",@"信用卡背面后三位数",@"信用银行预留手机号",@"请输入短信验证码"];
        UITextField *tf = nil;
        
        
        tf = [[UITextField alloc] init];
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
        tf.font = FONT_ArialMT(12);
        tf.tag = 1000+i;
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.placeholder = [placeholder objectAtIndex:i];
        if (i==1) {
            tf.userInteractionEnabled = NO;
        }
        
        
        
        
        
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

- (void)dateAction:(UIButton *)sender {//获取日期(年/月)
    [self.view endEditing:YES];
    //typePickerID == 1表示只有年显示
    //typePickerID == 2表示年和月显示
    //typePickerID == 3表示年,月,日显示
    //typePickerID == 4表示年,周显示
    [PickerView showPickerView:MY_WINDOW componentNum:2 typePickerID:2 selectStr:nil StrBlock:^(NSString *string) {
        UITextField *dateTF = [self.view viewWithTag:1001];
        dateTF.text = string;
    }];
}


- (void)changeAction:(LQXSwitch *)sender {//本人||非本人
    if ([self.isPartner isEqualToString:@"yes"]) {
        sender.on = NO;
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"不能为他人开合伙人" doneTitle:@"确定" cancelTitle:@"" haveCancel:NO doneAction:^{
        } controller:self];
        return;
    }
    
    if (sender.on) {
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
    if (![self checkInfomation]) {
        return;
    }
    
    [self startTimer:sender];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"transAmount":self.cashCount,@"subProductId":[self.isPartner isEqualToString:@"yes"]?@"65502":@"3",@"isSelf":[NSString stringWithFormat:@"%d", !self.switch_choose.on],@"transUserCardInfo":@{@"cardHolderName":self.cardHolder,@"cardIdentityNo":self.identiCardNo,@"cardIdentityType":@"01",@"cardNo":self.creditCardNo,@"cardPhoneNo":self.phoneNo,@"cvn":self.CVV2No,@"expDate":self.creditCardDate}}] forKey:@"transc.placeOrder"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        self.orderID = resultDic[@"resultData"];
        [[PublicFuntionTool sharedInstance] getOrderStatus:^(TransOrder *order) {
            self.orderTime = order.orderCreateTime;
        } byOrderID:self.orderID];
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
    if (![[UserData currentUser].isPartner isEqualToString:@"1"]) {
        JoinParterViewController *join = [JoinParterViewController new];
        [self.navigationController pushViewController:join animated:YES];
    }
}

- (void)payAction:(UIButton *)sender {
    UITextField *codetf = [self.view viewWithTag:1004];
    self.codeNo = codetf.text;
    if (!codetf.text.length || ![codetf.text deptNumInputShouldNumber]) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请正确输入验证码" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return;
    }
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"orderId":self.orderID,@"smsCode":self.codeNo}] forKey:@"transc.doQuickPayment"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"++++%@", resultDic);
        if (self.isReal) {//非本人
            NoCardInfamationViewController *infa = [NoCardInfamationViewController new];
            infa.orderID = self.orderID;
            infa.cashCount = [NSString stringWithFormat:@"￥%@", self.cashCount];
//            infa.payNameStr = self.cardHolder;
//            infa.cardNo = self.creditCardNo;
            infa.timeStr = self.orderTime;
            [self.navigationController pushViewController:infa animated:YES];
        } else {//本人
            if ([resultDic[@"resultData"] integerValue]==2) {//成功
                TradeResultViewController *result = [TradeResultViewController new];
                result.cashStr = self.cashCount;
                result.orderID = self.orderID;
                [self.navigationController pushViewController:result animated:YES];
            }
        }
        
        //更改本地合伙人状态
        if ([self.isPartner isEqualToString:@"yes"]) {
            NSMutableDictionary *partDic = [[NSMutableDictionary alloc] init];
            [partDic setObject:@"1" forKey:@"isPartner"];
            [[UserData currentUser] giveData:partDic];
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (BOOL)checkInfomation {
    NSLog(@"%d", self.switch_choose.on);
    UITextField *cardtf = [self.view viewWithTag:1000];
    UITextField *datetf = [self.view viewWithTag:1001];
    UITextField *cvvvtf = [self.view viewWithTag:1002];
    UITextField *phonetf = [self.view viewWithTag:1003];
    UITextField *holder = [self.view viewWithTag:1011];
    UITextField *holderIdenno = [self.view viewWithTag:1012];
    NSLog(@"%@\n%@\n%@\n%@", cardtf.text,datetf.text,cvvvtf.text,phonetf.text);
    if (self.isPartner) {
        self.cardHolder = holder.text;
        self.identiCardNo = holderIdenno.text;
    } else {
        if (self.switch_choose.on) {//非本人
            self.cardHolder = holder.text;
            self.identiCardNo = holderIdenno.text;
            NSLog(@"%@++++%@", self.cardHolder,self.identiCardNo);
        } else {//本人
            self.cardHolder = self.model.realName;
            self.identiCardNo = self.model.identityCardNo;
            
//        self.cardHolder = @"王五";
//        self.identiCardNo = @"440402198800000000";
        }
    }
    
    
    if (!cardtf.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请正确输入信用卡号" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return NO;
    }
    if (!datetf.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请正确输入信用卡有效期" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return NO;
    }
    if (cvvvtf.text.length!=3) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请正确输入CVV2号" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return NO;
    }
    if (![phonetf.text isValidateMobile]) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请正确输入手机号码" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return NO;
    }
    if (![self.cardHolder IsChinese]) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"持卡人姓名请填中文" time:2.0 aboutType:MBProgressHUDModeCustomView state:NO];
        return NO;
    }
    
    self.creditCardNo = cardtf.text;
    self.creditCardDate = datetf.text;
    self.CVV2No = cvvvtf.text;
    self.phoneNo = phonetf.text;
    
//    self.creditCardNo = @"6222024000019810099";
    return YES;
}

- (void)getRealName {//获取实名认证
    //status  0待审核 1成功 2审核中
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.getRealName"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---real---%@", resultDic);
        self.model = [[RealCertificateModel alloc] initWithDictionary:resultDic[@"resultData"] error:nil];
        [self.tabView reloadData];
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

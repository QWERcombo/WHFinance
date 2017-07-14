//
//  RegisterViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/23.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>{
    UIButton *codeBtn;
    UIImageView *checkImgv;
}
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *placeholderArray;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) NSString *phone;//手机号
@property (nonatomic, strong) NSString *checkcode;//验证码
@property (nonatomic, strong) NSString *code;//密码
@property (nonatomic, strong) NSString *confirmcode;//确认密码
@property (nonatomic, strong) NSString *referphone;//邀请手机号
@property (nonatomic, strong) NSString *codeToken;
@property (nonatomic, assign) BOOL isCheck;
@end

@implementation RegisterViewController

-(void)customViewWillAppear
{
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSFontAttributeName] = [UIFont fontWithSize:18];
    barAttrs[NSForegroundColorAttributeName] = [UIColor Black_WordColor];
    [self.navigationController.navigationBar setTitleTextAttributes:barAttrs];
}
-(void)customViewWillDisappear
{
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSFontAttributeName] = [UIFont fontWithSize:18];
    barAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:barAttrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.nameType isEqualToString:@"register"]) {
        self.title = @"注册";
    } else {
        self.title = @"忘记密码";
    }
    
    self.codeToken = @"aaaaaaaaaaaaaaaaaaaaaaaaa";
    UIBarButtonItem *backButton = [[UtilsData sharedInstance] itemWithImageName:@"MGoBack" highImageName:@"MGoBack" target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItems = @[backButton];
    self.nameArray = [NSArray arrayWithObjects:@"login_phone",@"login_code",@"login_phone",@"login_code",@"login_phone", nil];
    self.placeholderArray = [NSArray arrayWithObjects:@"请输入手机号码",@"请输入验证码",@"请输入8-12位数字与字母的组合",@"请再次输入密码",@"请输入邀请手机号", nil];
    [self setupSubViews];
}
- (void)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
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
    return SCREEN_HEIGHT;
}


- (UIView *)createMainView {
    self.mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    for (NSInteger i=0; i<5; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 10+50*i, SCREEN_WIGHT, 50)];
        blank.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 49, SCREEN_WIGHT-30, 1)];
        line.backgroundColor = [UIColor colorWithR:204 G:204 B:204 A:1];
        
        if ([self.nameType isEqualToString:@"register"]) {
            if (i!=4) {
                [blank addSubview:line];
            }
        } else {
            if (i!=3) {
                [blank addSubview:line];
            }
        }
        [self.mainView addSubview:blank];
        
        UIImageView *nameLab = [UIImageView new];
        nameLab.image = IMG([self.nameArray objectAtIndex:i]);
        [blank addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(12.5);
            make.height.equalTo(@(20));
        }];
        
        UITextField *tempTF = [[UITextField alloc] init];
        tempTF.tag = 1000+i;
        tempTF.secureTextEntry = NO;
        tempTF.delegate = self;
        tempTF.placeholder = [self.placeholderArray objectAtIndex:i];
        tempTF.font = FONT_ArialMT(14);
        [tempTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if (i==0 || i==1 || i==4) {
            tempTF.keyboardType = UIKeyboardTypeNumberPad;
        } else {
            tempTF.keyboardType = UIKeyboardTypeDefault;
        }
        [blank addSubview:tempTF];
        [tempTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(45);
            make.width.equalTo(@(210));
        }];
        
        
        if (i==1) {
            CGSize size = [UILabel getSizeWithText:@"获取验证码" andFont:FONT_ArialMT(15) andSize:CGSizeMake(0, 30)];
            codeBtn = [UIButton buttonWithTitle:@"获取验证码" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:[UIColor mianColor:1] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
            codeBtn.layer.cornerRadius = 10;
            codeBtn.clipsToBounds = YES;
            codeBtn.layer.borderColor = [UIColor mianColor:1].CGColor;
            codeBtn.layer.borderWidth = 1;
            
            [codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
            [blank addSubview:codeBtn];
            [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(blank.mas_right).offset(-15);
                make.centerY.equalTo(blank.mas_centerY);
                make.width.equalTo(@(size.width+20));
                make.height.equalTo(@(30));
            }];
        }
        
        
        if (![self.nameType isEqualToString:@"register"]) {
            if (i==3) {
                break;
            }
        }
        
    }
    
    
    NSString *tempStr = @"";
    if ([self.nameType isEqualToString:@"register"]) {
        tempStr = @"注册";
    } else {
        tempStr = @"确定，请重新登录";
    }
    
    if ([self.nameType isEqualToString:@"register"]) {
//        UIView *protocolsView = [[UIView alloc] initWithFrame:CGRectMake(15, 205, 110, 13)];
//         [self.mainView addSubview:protocolsView];
//        checkImgv = [UIImageView new];
//        checkImgv.image = IMG(@"login_check_y");
//        [protocolsView addSubview:checkImgv];
//        [checkImgv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.equalTo(@(13));
//            make.centerY.left.equalTo(protocolsView);
//        }];
//
//        UILabel *hintLab = [YXPUtil creatUILable:@"本人同意并确认" Font:FONT_ArialMT(12) TextColor:[UIColor colorWithR:102 G:102 B:102 A:1]];
//        [protocolsView addSubview:hintLab];
//        [hintLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(protocolsView);
//            make.left.equalTo(checkImgv.mas_right).offset(8);
//        }];
//
//        UITapGestureRecognizer *checkTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chechAction:)];
//        [protocolsView addGestureRecognizer:checkTap];
//
//        UIButton *protoBtn = [UIButton buttonWithTitle:@"《用户协议》" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor colorWithR:85 G:166 B:229 A:1] andHighlightedTitle:[UIColor colorWithR:185 G:166 B:229 A:1] andNormaImage:nil andHighlightedImage:nil];
//        [protoBtn addTarget:self action:@selector(proBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//        protoBtn.userInteractionEnabled = YES;
//        [_mainView addSubview:protoBtn];
//        [protoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(protocolsView.mas_right).offset(0);
//            make.centerY.equalTo(protocolsView.mas_centerY);
//            make.height.equalTo(@(13));
//        }];
        
    }
    
    
    UIButton *doneBtn = [UIButton buttonWithTitle:tempStr andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    if ([self.nameType isEqualToString:@"register"]) {
        doneBtn.frame = CGRectMake(12.5, 285, SCREEN_WIGHT-25, 40);
    } else {
        doneBtn.frame = CGRectMake(12.5, 235, SCREEN_WIGHT-25, 40);
    }
    doneBtn.backgroundColor = [UIColor mianColor:1];
    doneBtn.layer.cornerRadius = 5;
    doneBtn.clipsToBounds = YES;
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:doneBtn];
    
    
    
    UITapGestureRecognizer *doneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.mainView addGestureRecognizer:doneTap];
    
    
    return self.mainView;
}
- (void)textFieldDidChange :(UITextField *)theTextField {
    switch (theTextField.tag) {
        case 1000:
            self.phone = theTextField.text;
            break;
        case 1001:
            self.checkcode = theTextField.text;
            break;
        case 1002:
            self.code = theTextField.text;
            break;
        case 1003:
            self.confirmcode = theTextField.text;
            break;
        case 1004:
            self.referphone = theTextField.text;
            break;
        default:
            break;
    }
}

- (void)doneAction:(UIButton *)sender {
    NSLog(@"\n%@--\n%@--\n%@--\n%@", self.phone, self.checkcode, self.code, self.confirmcode);
//    if (![self.phone isValidateMobile]) {//验证手机号
//        [[UtilsData sharedInstance] showAlertTitle:@"请输入正确的手机号" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
//        return;
//    }
//    if (self.checkcode.length!=4) {//验证验证码
//        [[UtilsData sharedInstance] showAlertTitle:@"请输入正确的验证码" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
//        return;
//    }
//    if (![self.code isEqualToString:self.confirmcode]) {//验证密码是否一样
//        [[UtilsData sharedInstance] showAlertTitle:@"两次输入的密码不一致" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
//        return;
//    }
//    if (![self.confirmcode judgePassWordLegal]) {
//        [[UtilsData sharedInstance] showAlertTitle:@"请输入8-12位数字与字母的组合" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
//        return;
//    }
    
    if ([self.nameType isEqualToString:@"register"]) {//注册
        //key={"user.regin":{"userInfo":{"mobileNumber":"13631233543","password":"123456","userName":"sujianfei"},"smsCode":"123456","token":"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"}}
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"smsCode":self.checkcode,@"token":self.codeToken,@"referenceMobileNumber":self.referphone,@"userInfo":@{@"mobileNumber":self.phone,@"password":self.confirmcode,@"userName":self.phone}}] forKey:@"user.regin"];
        NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
        [dict setObject:json forKey:@"key"];
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            NSLog(@"+++++%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"注册成功,请登录" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
    } else {//忘记密码
//        key={"user.forgetPassword":{"smsCode":"1234","newPassword":"123455","userName":"sujianfei","token":"12a4309795c0ba2e8f370b4db3367bfbebdf3eb39ae76e4006f5723b4ab06a8a"}}
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
        [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"smsCode":@"1234",@"token":[UserData currentUser].userToken, @"userName":self.phone, @"newPassword":self.code}] forKey:@"user.forgetPassword"];
        NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
        [dict setObject:json forKey:@"key"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            NSLog(@"+++++%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"修改成功,请登录" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)codeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [[PublicFuntionTool sharedInstance] getSmsCodeByPhoneString:self.phone];
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


- (void)proBtnAction:(UIButton *)sender {
    NSLog(@"用户协议");
}
- (void)chechAction:(UITapGestureRecognizer *)sender {
    if (_isCheck) {
        checkImgv.image = IMG(@"login_check_y");
        _isCheck = NO;
    } else {
        checkImgv.image = IMG(@"login_check");
        _isCheck = YES;
    }
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

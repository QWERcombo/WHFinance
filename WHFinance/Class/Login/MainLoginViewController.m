//
//  MainLoginViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/22.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MainLoginViewController.h"
#import "RegisterViewController.h"
#import "CertificateViewController.h"
#import "MineViewController.h"

@interface MainLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *codeBtn_reme;
@property (nonatomic, strong) UIButton *codeBtn_forg;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIImageView *remCode;
@property (nonatomic, assign) BOOL isRemember;
@end
#define Login_Color_normol [UIColor colorWithR:204 G:204 B:204 A:1]

@implementation MainLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *login_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:login_tap];
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}


#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainLoginView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCREEN_HEIGHT;
}

- (UIView *)createMainLoginView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT)];
    mainView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image  = IMG(@"login_logo");
    [mainView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(79));
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(mainView.mas_top).offset(64+48);
    }];
    
    
    UIImageView *phoneImgv = [[UIImageView alloc] initWithFrame:CGRectMake(75/2, 64+48+79+60, 20, 20)];
    phoneImgv.image = IMG(@"login_phone");
    [mainView addSubview:phoneImgv];
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(59, CGRectGetMinY(phoneImgv.frame), SCREEN_WIGHT-75-30, 18)];
    self.phoneTF.font = FONT_ArialMT(18);
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.delegate = self;
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [mainView addSubview:self.phoneTF];
    UIView *line_p = [[UIView alloc] initWithFrame:CGRectMake(37.5, CGRectGetMaxY(phoneImgv.frame)+10, SCREEN_WIGHT-75, 1)];
    line_p.backgroundColor = Login_Color_normol;
    [mainView addSubview:line_p];
    
    UIImageView *codeImgv = [[UIImageView alloc] initWithFrame:CGRectMake(75/2, CGRectGetMaxY(line_p.frame)+20, 20, 20)];
    codeImgv.image = IMG(@"login_code");
    [mainView addSubview:codeImgv];
    self.codeTF = [[UITextField alloc] initWithFrame:CGRectMake(59, CGRectGetMinY(codeImgv.frame), SCREEN_WIGHT-75-30, 18)];
    self.codeTF.font = FONT_ArialMT(18);
    self.codeTF.placeholder = @"请输入密码";
    self.codeTF.delegate = self;
    self.codeTF.keyboardType = UIKeyboardTypeEmailAddress;
    [mainView addSubview:self.codeTF];
    UIView *line_c = [[UIView alloc] initWithFrame:CGRectMake(37.5, CGRectGetMaxY(codeImgv.frame)+10, SCREEN_WIGHT-75, 1)];
    line_c.backgroundColor = Login_Color_normol;
    [mainView addSubview:line_c];
    
    UIView *rememberCode = [[UIView alloc] initWithFrame:CGRectMake(37.5, CGRectGetMaxY(line_c.frame)+15, 75, 14)];
    self.remCode = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
    [rememberCode addSubview:self.remCode];
    if (self.isRemember) {
        self.remCode.image = IMG(@"login_check_y");
    } else {
        self.remCode.image = IMG(@"login_check");
    }
    self.codeBtn_reme = [UIButton buttonWithTitle:@"记住密码" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor colorWithR:102 G:102 B:102 A:1] andHighlightedTitle:nil andNormaImage:nil andHighlightedImage:nil];
    self.codeBtn_reme.userInteractionEnabled = NO;
    self.codeBtn_reme.frame = CGRectMake(19, 0, 56, 14);
    [rememberCode addSubview:self.codeBtn_reme];
    UITapGestureRecognizer *checkCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkTap:)];
    [rememberCode addGestureRecognizer:checkCode];
    [mainView addSubview:rememberCode];
    
    self.codeBtn_forg = [UIButton buttonWithTitle:@"忘记密码?" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:nil andNormaImage:nil andHighlightedImage:nil];
    self.codeBtn_forg.frame = CGRectMake(SCREEN_WIGHT-(195/2), CGRectGetMaxY(line_c.frame)+15, 65, 14);
    [self.codeBtn_forg addTarget:self action:@selector(forgetCluck:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:self.codeBtn_forg];
    
    
    self.loginBtn = [UIButton buttonWithTitle:@"登录" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:nil andNormaImage:IMG(@"") andHighlightedImage:nil];
    self.loginBtn.frame = CGRectMake(75/2, CGRectGetMaxY(rememberCode.frame)+85, SCREEN_WIGHT-75, 40);
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.backgroundColor = [UIColor mianColor:1];
    [self.loginBtn addTarget:self action:@selector(login_action:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:self.loginBtn];
    
    self.registBtn = [UIButton buttonWithTitle:@"注册账号" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor mianColor:1] andHighlightedTitle:nil andNormaImage:nil andHighlightedImage:nil];
    self.registBtn.frame = CGRectMake(SCREEN_WIGHT-110, CGRectGetMaxY(self.loginBtn.frame)+15, 70, 15);
    [self.registBtn addTarget:self action:@selector(register_action:) forControlEvents:UIControlEventTouchUpInside];
    
    [mainView addSubview:self.registBtn];
    
    return mainView;
}

#pragma mark - UITextField
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField==self.phoneTF) {
//        NSLog(@"---%@", textField.text);
    } else {
//        NSLog(@"+++%@", textField.text);
    }
}



#pragma mark - Action
- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)checkTap:(UITapGestureRecognizer *)sender {
    if (_isRemember) {
        self.remCode.image = IMG(@"login_check");
        _isRemember = NO;
    } else {
        self.remCode.image = IMG(@"login_check_y");
        _isRemember = YES;
    }
}

- (void)forgetCluck:(UIButton *)sender {
    RegisterViewController *forget = [RegisterViewController new];
    forget.nameType = @"forgetCode";
    forget.navIMG = [UIImage imageWithColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:forget animated:YES];
}

- (void)login_action:(UIButton *)sender {
    NSLog(@"登录---%@-----%@", self.phoneTF.text, self.codeTF.text);
//     [[UtilsData sharedInstance] postLoginNotice];
    if (!self.phoneTF.text.length || !self.codeTF.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"请正确填写用户名或密码!" detailsText:nil time:2 aboutType:MBProgressHUDModeText state:YES];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"password":self.codeTF.text,@"userName":self.phoneTF.text}] forKey:@"user.login"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        [[UserData currentUser] giveData:resultDic[@"resultData"]];
        [[UserData currentUser] giveData:@{@"uid":resultDic[@"resultData"][@"id"]}];
        [[UtilsData sharedInstance] postLoginNotice];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)register_action:(UIButton *)sender {
    RegisterViewController *forget = [RegisterViewController new];
    forget.nameType = @"register";
    forget.navIMG = [UIImage imageWithColor:[UIColor whiteColor]];
    [self.navigationController pushViewController:forget animated:YES];
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

//
//  ShareRegisterViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/7/3.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ShareRegisterViewController.h"

@interface ShareRegisterViewController ()<UITextFieldDelegate>{
    UIButton *codeBtn;
}
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *placeholderArray;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *checkcode;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *confirmcode;
@property (nonatomic, strong) NSString *codeToken;
@end

@implementation ShareRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"推广赚钱";
    self.nameArray = [NSArray arrayWithObjects:@"login_phone",@"login_code",@"login_phone",@"login_code", nil];
    self.placeholderArray = [NSArray arrayWithObjects:@"请输入手机号码",@"请输入验证码",@"请输入8-12位数字与字母的组合",@"请再次输入密码", nil];
    [self setUpSubviews];
}

- (void)setUpSubviews {
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.view.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *hint = [UILabel lableWithText:@"帮朋友开通后，系统将其默认您的下载" Font:FONT_ArialMT(14) TextColor:[UIColor colorWithR:253 G:120 B:45 A:1]];
    [mainView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.left.equalTo(mainView.mas_left).offset(13);
        make.top.equalTo(mainView.mas_top).offset(13);
    }];
    
    for (NSInteger i=0; i<4; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 10+50*i, SCREEN_WIGHT, 50)];
        blank.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 49, SCREEN_WIGHT-30, 1)];
        line.backgroundColor = [UIColor colorWithR:204 G:204 B:204 A:1];
        
        if (i!=3) {
            [blank addSubview:line];
        }
        [mainView addSubview:blank];
        
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
        if (i==0) {
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
        
    }
    
    
    
    UIButton *doneBtn = [UIButton buttonWithTitle:@"点击注册" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    doneBtn.frame = CGRectMake(12.5, 235, SCREEN_WIGHT-25, 40);
    doneBtn.backgroundColor = [UIColor mianColor:1];
    doneBtn.layer.cornerRadius = 5;
    doneBtn.clipsToBounds = YES;
    [doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:doneBtn];
    
    
    
    UITapGestureRecognizer *doneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [mainView addGestureRecognizer:doneTap];
    
    
    return mainView;
}

- (void)textFieldDidChange:(UITextField *)theTextField {
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
        default:
            break;
    }
}

- (void)codeAction:(UIButton *)sender {
    [self.view endEditing:YES];
    [self startTimer:sender];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"param":@{@"mobile":self.phone,@"type":@"register"}}] forKey:@"common.sendMsgCode"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++++%@", resultDic);
        if (resultDic) {
            [[UtilsData sharedInstance] showAlertTitle:@"短信验证码" detailsText:@" 已发送!" time:2 aboutType:MBProgressHUDModeText state:YES];
            self.codeToken = resultDic[@"resultData"];
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
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

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
- (void)doneAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
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

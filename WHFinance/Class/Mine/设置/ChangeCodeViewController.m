//
//  ChangeCodeViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "ChangeCodeViewController.h"

@interface ChangeCodeViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *hintArray1;
@end

@implementation ChangeCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    self.hintArray1 = @[@"请输入现在使用的密码",@"请输入8-12位数字与密码的组合",@"请再次输入密码",@"请再次输入密码"];
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
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
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    for (NSInteger i=0; i<3; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 10+50*i, SCREEN_WIGHT, 50)];
        blank.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 49, SCREEN_WIGHT-30, 1)];
        line.backgroundColor = [UIColor colorWithR:204 G:204 B:204 A:1];
        
        if (i!=2) {
            [blank addSubview:line];
        }
        [mainView addSubview:blank];
        
        UIImageView *nameLab = [UIImageView new];
        nameLab.image = IMG(@"login_code");
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
        tempTF.placeholder = [self.hintArray1 objectAtIndex:i];
        tempTF.font = FONT_ArialMT(14);
        [tempTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        tempTF.keyboardType = UIKeyboardTypeDefault;
        [blank addSubview:tempTF];
        [tempTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(45);
            make.width.equalTo(@(210));
        }];
        
    }
    
    
    UIButton *button = [UIButton buttonWithTitle:@"确定修改" andFont:FONT_ArialMT(19) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    button.backgroundColor = [UIColor mianColor:1];
    button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    [mainView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.equalTo(mainView.mas_left).offset(12.5);
        make.right.equalTo(mainView.mas_right).offset(-12.5);
        make.top.equalTo(mainView.mas_top).offset(210);
    }];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *ediTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ediTap:)];
    [mainView addGestureRecognizer:ediTap];
    
    return mainView;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"确定,请重新登录");
    [self.view endEditing:YES];
    UITextField *oldTF = [self.view viewWithTag:1000];
    UITextField *newTF = [self.view viewWithTag:1001];
    UITextField *confirmTF = [self.view viewWithTag:1002];
    NSLog(@"%@---%@+++%@", oldTF.text, newTF.text,confirmTF.text);
//    key={"user.modifyPassword":{"userToken":"12a4309795c0ba2e8f370b4db3367bfbebdf3eb39ae76e4006f5723b4ab06a8a","oldPassword":"123456","newPassword":"123455"}}
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken,@"oldPassword":oldTF.text,@"newPassword":newTF.text}] forKey:@"user.modifyPassword"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        
        if (resultDic) {
            [[UtilsData sharedInstance] showAlertTitle:@"修改成功请重新登录" detailsText:nil time:2 aboutType:MBProgressHUDModeCustomView state:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[UtilsData sharedInstance] postLogoutNotice];
            });
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
    
}
- (void)ediTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


- (void)textFieldDidChange :(UITextField *)theTextField {
    
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

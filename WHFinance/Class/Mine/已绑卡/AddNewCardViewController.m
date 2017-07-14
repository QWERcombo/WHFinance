//
//  AddNewCardViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/28.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "AddNewCardViewController.h"

@interface AddNewCardViewController (){
    UIButton *codeBtn;
    UIDatePicker *datap;
    UIView *backView;
}
@property (nonatomic, strong) NSArray *dataSource_one;
@property (nonatomic, strong) NSArray *dataSource_two;
@property (nonatomic, strong) NSArray *dataSource_one_temp;
@property (nonatomic, strong) NSArray *dataSource_two_temp;
@end

@implementation AddNewCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加新卡";
    self.dataSource_one = @[@"姓    名",@"身份证号"];
    self.dataSource_two = @[@"信用卡号",@"信用卡有效期",@"CVV2",@"手机号码",@"验证码"];
    self.dataSource_one_temp = @[@"张三",@"13131531313"];
    self.dataSource_two_temp = @[@"请输入信用卡号",@"请输入信用卡有效期",@"信用卡背后三个数字",@"18588585656",@"请输入验证码"];
    
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCREEN_HEIGHT;
}

- (UIView *)createMainView {
    UIView *mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    mainview.backgroundColor = [UIColor Grey_BackColor1];
    
    for (NSInteger i=0; i<2; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 10+45*i, SCREEN_WIGHT, 45)];
        blank.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [UILabel lableWithText:[self.dataSource_one objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left).offset(13);
            make.centerY.equalTo(blank.mas_centerY);
            make.height.equalTo(@(14));
        }];
        UILabel *detailLab = [UILabel lableWithText:[self.dataSource_one_temp objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(14));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(250/2);
        }];
        [mainview addSubview:blank];
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, 55, SCREEN_WIGHT-26, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [mainview addSubview:line];
    
    for (NSInteger i=0; i<5; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 110+45*i, SCREEN_WIGHT, 45)];
        blank.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [UILabel lableWithText:[self.dataSource_two objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left).offset(13);
            make.centerY.equalTo(blank.mas_centerY);
            make.height.equalTo(@(14));
        }];
        
        UITextField *inputTF = [UITextField new];
        inputTF.font = FONT_ArialMT(14);
        inputTF.tag = 1000+i;
        inputTF.placeholder = [self.dataSource_two_temp objectAtIndex:i];
        [blank addSubview:inputTF];
        [inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(14));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(blank.mas_left).offset(250/2);
            make.width.equalTo(@(150));
        }];
        
        if (i==4) {
            CGSize size = [UILabel getSizeWithText:@"获取验证码" andFont:FONT_ArialMT(15) andSize:CGSizeMake(0, 30)];
            codeBtn = [UIButton buttonWithTitle:@"获取验证码" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor colorWithR:204 G:204 B:204 A:1] andHighlightedTitle:[UIColor colorWithR:245 G:245 B:245 A:1] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
            codeBtn.layer.cornerRadius = 5;
            codeBtn.clipsToBounds = YES;
            codeBtn.layer.borderColor = [UIColor colorWithR:204 G:204 B:204 A:1].CGColor;
            codeBtn.layer.borderWidth = 1;
            
            [codeBtn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
            [blank addSubview:codeBtn];
            [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(blank.mas_right).offset(-15);
                make.centerY.equalTo(blank.mas_centerY);
                make.width.equalTo(@(size.width+10));
                make.height.equalTo(@(30));
            }];
        }
        if (i==1) {
            UIButton *button = [UIButton buttonWithTitle:@"" andFont:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
            [blank addSubview:button];
            [button addTarget:self action:@selector(dateAction:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor yellowColor];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.equalTo(@(20));
                make.centerY.equalTo(blank.mas_centerY);
                make.right.equalTo(blank.mas_right).offset(-15);
            }];
        }
        
        
        [mainview addSubview:blank];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, 110+45*i, SCREEN_WIGHT-26, 1)];
        line.backgroundColor = [UIColor Grey_LineColor];
        if (i!=0) {
        [mainview addSubview:line];
        }
        
        
    }
    UIButton *button = [UIButton buttonWithTitle:@"确定" andFont:FONT_ArialMT(18) andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"register_btn") andHighlightedImage:IMG(@"register_btn")];
    [button addTarget:self action:@selector(addNewAction:) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainview.mas_top).offset(355);
        make.height.equalTo(@(40));
        make.left.equalTo(mainview.mas_left).offset(13);
        make.right.equalTo(mainview.mas_right).offset(-13);
    }];
    
    UITapGestureRecognizer *ediTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ediTap:)];
    [mainview addGestureRecognizer:ediTap];
    
    
    return mainview;
}

- (void)addNewAction:(UIButton *)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"11" message:@"222\n2" preferredStyle:UIAlertControllerStyleAlert];
//    alert.view.frame = CGRectMake(0, 0, 100, 100);
//
//    UIImageView *image = [[UIImageView alloc] init];
//    image.backgroundColor = [UIColor mianColor:1];
//    [alert.view addSubview: image];
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.equalTo(@(64));
//        make.centerX.equalTo(alert.view.mas_centerX);
//        make.top.equalTo(alert.view.mas_top).offset(15);
//    }];
//
//    UIAlertAction *aaa = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [aaa setValue:[UIColor mianColor:1] forKey:@"titleTextColor"];
//    //修改标题
//    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:alert.title];
//    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, alert.title.length)];
//    [alert setValue:alertControllerStr forKey:@"attributedTitle"];
//    //修改提示
//    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:alert.message];
//    [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, alert.message.length)];
//    [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
//    [alert addAction:aaa];
//
//    [self.navigationController presentViewController:alert animated:YES completion:^{
//
//    }];
    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"添加完成" time:2 aboutType:MBProgressHUDModeCustomView state:YES];
    
}
- (void)ediTap:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
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

- (void)codeAction:(UIButton *)sender {
    [self startTimer:sender];
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

//
//  WithdrawViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/27.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "WithdrawViewController.h"
#import "WithdrawCompleteViewController.h"

@interface WithdrawViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) MHTextField *moneyTF;
@property (nonatomic, strong) UIButton *moneyBtn;
@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现";
    [self.dataMuArr addObjectsFromArray:@[@"姓名",@"会员等级",@"提取金额",@"结算卡号",@"所属银行"]];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
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
        
        NSArray *temp = @[@"张三",@"普通会员",@"20.00",@"2656523131313(中国招商银行)",@"中国招商银行"];
        UILabel *right = [UILabel lableWithText:[temp objectAtIndex:i] Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:right];
        right.textAlignment = NSTextAlignmentRight;
        [right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(14));
            make.centerY.equalTo(blank.mas_centerY);
            make.right.equalTo(blank.mas_right).offset(-10);
            make.left.equalTo(left.mas_left).offset(20);
        }];
        
        
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
    [[UtilsData sharedInstance] showAlertTitle:@"已提现" detailsText:nil time:2.0 aboutType:MBProgressHUDModeCustomView state:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
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

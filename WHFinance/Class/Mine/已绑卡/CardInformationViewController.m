//
//  CardInformationViewController.m
//  WHFinance
//
//  Created by 赵越 on 2017/7/1.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "CardInformationViewController.h"

@interface CardInformationViewController (){
    CustomTextField *tf;
}
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray *tempArr;
@property (nonatomic, assign) BOOL isEdite;
@end

@implementation CardInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改结算卡";
    self.nameArr = @[@"姓        名:",@"身份证号:",@"结算卡号:",@"选择银行:",@"银行支行:"];
    self.tempArr = @[@"张三",@"151515151515151551515115",@"￥200.00",@"6677 8899 8888 0090",@"招商银行"];
    
    UIButton *right_f = [UIButton buttonWithTitle:@"" andFont:nil andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
    right_f.frame = CGRectMake(0, 0, 30, 30);
    right_f.backgroundColor = [UIColor whiteColor];
    [right_f addTarget:self action:@selector(ediAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right_f];
    
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
    if (self.isEdite) {
        return [self createEditorMainView];
    } else {
        return [self createMainView];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCREEN_HEIGHT;
}

- (UIView *)createMainView {
    UIView *mainview = [[UIView alloc] initWithFrame:self.view.bounds];
    mainview.backgroundColor = [UIColor Grey_BackColor1];
    
    UILabel *left = [UILabel lableWithText:@"个人信息" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_OrangeColor]];
    left.frame = CGRectMake(20, 6.5, 50, 12);
    [mainview addSubview:left];
    UILabel *right = [UILabel lableWithText:@"已完善" Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    right.frame = CGRectMake(SCREEN_WIGHT-50, 6.5, 40, 12);
    [mainview addSubview:right];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIGHT, 135)];
    content.backgroundColor = [UIColor whiteColor];
    [mainview addSubview:content];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 1)];
    line1.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 134, SCREEN_WIGHT, 1)];
    line2.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line2];
    
    
    for (NSInteger i=0; i<5; i++) {
        
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 19.5*i+45, SCREEN_WIGHT, 12)];
        blank.backgroundColor = [UIColor whiteColor];
        [mainview addSubview:blank];
        
        UILabel *nameLab = [UILabel lableWithText:[self.nameArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [blank addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(blank.mas_left).offset(15);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
        }];
        UILabel *detailLab = [UILabel lableWithText:[self.tempArr objectAtIndex:i] Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
        [blank addSubview:detailLab];
        [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(blank.mas_right).offset(-12.5);
            make.height.equalTo(@(12));
            make.centerY.equalTo(blank.mas_centerY);
            make.left.equalTo(nameLab.mas_right).offset(5);
        }];
        
        
    }
    
    
    
    return mainview;
}

- (UIView *)createEditorMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 215)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 1)];
    line1.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line1];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 214, SCREEN_WIGHT, 1)];
    line2.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line2];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 40, SCREEN_WIGHT-20, 1)];
    line.backgroundColor = [UIColor Grey_LineColor];
    [content addSubview:line];
    
    UILabel *label = [UILabel lableWithText:@"请修改" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:1]];
    [content addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerX.equalTo(content.mas_centerX);
        make.top.equalTo(content.mas_top).offset(12.5);
    }];
    
    
    for (NSInteger i=0; i<2; i++) {
        
        NSString *temp = [NSString stringWithFormat:@"%@  %@", [self.nameArr objectAtIndex:i],[self.tempArr objectAtIndex:i]];
        UILabel *infoLab = [UILabel lableWithText:temp Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        [content addSubview:infoLab];
        infoLab.frame = CGRectMake(15, 19.5*i+55, SCREEN_WIGHT-30, 12);
        
    }
    
    UILabel *label1 = [UILabel lableWithText:@"结算卡号" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(12));
        make.left.equalTo(content.mas_left).offset(15);
        make.top.equalTo(line.mas_bottom).offset(63);
    }];
    
    tf = [[CustomTextField alloc] initWithFrame:CGRectMake(75, 93.5, SCREEN_WIGHT-140, 30) withPlaceHolder:@"" withSeparateCount:4 withFont:FONT_ArialMT(14)];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    [content addSubview:tf];
    
    
    
    
    for (NSInteger i=0; i<2; i++) {
        UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tf.frame)+10+40*i, SCREEN_WIGHT, 40)];
        
        UIView *linee = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIGHT-20, 1)];
        linee.backgroundColor = [UIColor Grey_LineColor];
        [blank addSubview:linee];
        
        UILabel *label = [UILabel lableWithText:[self.nameArr objectAtIndex:3+i] Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        label.frame = CGRectMake(15, 14, 55, 12);
        [blank addSubview:label];
        
        UILabel *showLab = [UILabel lableWithText:@"" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
        showLab.tag = 888+i;
        showLab.backgroundColor = [UIColor purpleColor];
        showLab.frame = CGRectMake(75, 14, 180, 12);
        [blank addSubview:showLab];
        
        UIButton *button = [UIButton buttonWithTitle:nil andFont:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"") andHighlightedImage:IMG(@"")];
        [blank addSubview:button];
        button.frame = CGRectMake(SCREEN_WIGHT-30, 10, 20, 20);
        button.backgroundColor = [UIColor mianColor:1];
        button.tag = 999+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [content addSubview:blank];
        
    }
    
    return mainView;
}




- (void)ediAction:(UIBarButtonItem *)sender {
    [[UtilsData sharedInstance] certificateController:self success:^{
        NSLog(@"修改");
        self.isEdite = YES;
        [self.tabView reloadData];
    }];
}

- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    
    
}

- (void)doneAction:(UIButton *)sender {
//    [[UserData currentUser] removeMe];
    [self.navigationController popViewControllerAnimated:YES];
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

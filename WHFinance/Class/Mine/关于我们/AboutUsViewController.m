//
//  AboutUsViewController.m
//  WHFinance
//
//  Created by wanhong on 2017/6/29.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "AboutUsViewController.h"
#import "FeedBackViewController.h"

@interface AboutUsViewController () {
    CGSize contentSize;
}
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSString *detaiStr;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
//    self.nameArray = @[@[@"微信公众号",@"武汉万洪"],@[@"版本更新",@"1.0.0"],@[@"意见反馈",@""]];
    self.detaiStr = @"关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们关于我们";
    contentSize = [UILabel getSizeWithText:self.detaiStr andFont:FONT_ArialMT(12) andSize:CGSizeMake(SCREEN_WIGHT-26, 0)];
    
    [self setUpSubviews];
}

- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSArray *array = [self.nameArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [array firstObject];
    cell.textLabel.font = FONT_ArialMT(14);
    cell.textLabel.textColor = [UIColor Grey_WordColor];
    cell.detailTextLabel.text = [array lastObject];
    cell.detailTextLabel.font = FONT_ArialMT(12);
    cell.detailTextLabel.textColor = [UIColor Grey_BackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UIView *line = [UIView new];
    [cell.contentView addSubview:line];
    line.backgroundColor = [UIColor Grey_LineColor];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(15);
        make.right.equalTo(cell.contentView.mas_right).offset(15);
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.height.equalTo(@(1));
    }];
    if (indexPath.row==2) {
        [line removeFromSuperview];
    }
    if (indexPath.row==0) {
        cell.detailTextLabel.textColor = [UIColor mianColor:1];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80+contentSize.height;
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 80+contentSize.height)];
    mainView.backgroundColor = [UIColor whiteColor];
    
    UILabel *name = [UILabel lableWithText:@"e万呗" Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [mainView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerX.equalTo(mainView.mas_centerX);
        make.top.equalTo(mainView.mas_top).offset(20);
    }];
    
    UILabel *detail = [UILabel lableWithText:self.detaiStr Font:FONT_ArialMT(12) TextColor:[UIColor mianColor:2]];
    detail.numberOfLines=0;
    [mainView addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).offset(12);
        make.left.equalTo(mainView.mas_left).offset(13);
        make.right.equalTo(mainView.mas_right).offset(-13);
    }];
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = detail.font.pointSize * 2;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle01.tailIndent = 0.0f;//行尾缩进
    paraStyle01.lineSpacing = 5.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.detaiStr attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    
    detail.attributedText = attrText;
    
    
    
    return mainView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        [self addWeixinView];
    }
    if (indexPath.row==1) {
        NSLog(@"version 1.0.0");
    }
    if (indexPath.row==2) {
        FeedBackViewController *back = [FeedBackViewController new];
        [self.navigationController pushViewController:back animated:YES];
    }
}

- (void)addWeixinView {
    UIView *back = [[UIView alloc] initWithFrame:self.view.bounds];
    back.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    back.tag = 1010;
    
    UIView *imgv = [UIView new];
    [back addSubview:imgv];
    imgv.backgroundColor = [UIColor mianColor:1];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(550/2));
        make.height.equalTo(@(500/2));
        make.center.equalTo(back);
    }];
    
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTap:)];
    [back addGestureRecognizer:backTap];
    [self.view addSubview:back];
}

- (void)backTap:(UITapGestureRecognizer *)sender {
    UIView *bbbb = [self.view viewWithTag:1010];
    [bbbb removeFromSuperview];
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

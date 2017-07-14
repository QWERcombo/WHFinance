//
//  FAQDetailViewController.m
//  WHFinance
//
//  Created by 赵越 on 2017/7/2.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "FAQDetailViewController.h"

@interface FAQDetailViewController (){
    CGSize contentSize;
}
@property (nonatomic, strong) NSString *detailStr;
@end

@implementation FAQDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"常见问题";
    self.name = @"如何进行XX";
    self.detailStr = @"常见问题如何进行XX常见问题如何进行XX常见问题如何进行XX常见问题如何进行XX常见问题如何进行XX常见问题如何进行XX常见问题如何进行XX";
    contentSize = [UILabel getSizeWithText:self.detailStr andFont:FONT_ArialMT(14) andSize:CGSizeMake(SCREEN_WIGHT-26, 0)];
    
    
    [self setupSubViews];
}

- (void)setupSubViews {
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.view addSubview:self.tabView];
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [self.dataMuArr objectAtIndex:indexPath.row];
    cell.textLabel.font = FONT_ArialMT(14);
    cell.textLabel.textColor = [UIColor Grey_WordColor];
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
    if (indexPath.row==self.dataMuArr.count-1) {
        [line removeFromSuperview];
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createMainView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 115+contentSize.height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"dididdididi");
}

- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, contentSize.height+115)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, contentSize.height+105)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    
    
    UIImageView *imgv = [UIImageView new];
    [content addSubview:imgv];
    imgv.image = IMG(@"");
    imgv.backgroundColor = [UIColor mianColor:1];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(content.mas_left).offset(13);
        make.top.equalTo(content.mas_top).offset(10);
    }];
    UILabel *titleLab = [UILabel lableWithText:@"问题解答" Font:FONT_ArialMT(15) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgv.mas_right).offset(13);
        make.top.equalTo(content.mas_top).offset(10);
        make.height.equalTo(@(15));
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(13, 40, SCREEN_WIGHT-26, 1)];
    line.backgroundColor = [UIColor Grey_BackColor1];
    [content addSubview:line];
    
    UILabel *question = [UILabel lableWithText:self.name Font:FONT_ArialMT(14) TextColor:[UIColor Grey_WordColor]];
    [content addSubview:question];
    [question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(14));
        make.left.equalTo(content.mas_left).offset(13);
        make.top.equalTo(line.mas_bottom).offset(15);
    }];
    
    UILabel *detail = [UILabel lableWithText:self.detailStr Font:FONT_ArialMT(14) TextColor:[UIColor Grey_OrangeColor]];
    detail.numberOfLines = 0;
    CGSize size = [UILabel getSizeWithText:self.detailStr andFont:FONT_ArialMT(14) andSize:CGSizeMake(SCREEN_WIGHT-26, 0)];
    [content addSubview:detail];
    [detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(question.mas_bottom).offset(15);
        make.width.equalTo(@(SCREEN_WIGHT-26));
        make.centerX.equalTo(content.mas_centerX);
        make.height.equalTo(@(size.height));
    }];
    
    
    return mainView;
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

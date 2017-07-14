//
//  MessageViewController.m
//  WHFinance
//
//  Created by 赵越 on 2017/6/26.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageDetailViewController.h"

@interface MessageViewController (){
    UIView *leftView;
    UIView *rightView;
    UILabel *read_yes_Lab;
    UILabel *read_no_Lab;
    UILabel *read_no_count;
}
@property (nonatomic, strong) UILabel *hint_no_read;
@property (nonatomic, strong) NSMutableArray *no_read_count;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";
    self.no_read_count = [NSMutableArray array];
    
    UILabel *messageBtn = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    messageBtn.font = FONT_ArialMT(12);
    messageBtn.textColor = [UIColor whiteColor];
    messageBtn.numberOfLines=0;
    messageBtn.textAlignment = NSTextAlignmentCenter;
    messageBtn.text = [self getDateAndWddkday];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:messageBtn];
    
    
    self.dataMuArr = [[DataForFMDB sharedDataBase] getAllMessage];
    
    [self setUpSubviews];
    [self getdataSource];
}
- (NSString *)getDateAndWddkday {//获取日期
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSString *DateTime = [NSString stringWithFormat:@"%@\n%@", [[PublicFuntionTool sharedInstance] getweekDayStringWithDate],[formatter stringFromDate:date]];
    return  DateTime;
}
- (void)setUpSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor Grey_BackColor1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return self.dataMuArr.count;
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListCell *cell = (MessageListCell *)[UtilsMold creatCell:@"MessageListCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
    if (indexPath.row==self.dataMuArr.count-1) {
        [cell.line removeFromSuperview];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MessageListCell" data:nil model:nil indexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageDetailViewController *withdraw = [MessageDetailViewController new];
    withdraw.dataModel = [self.dataMuArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:withdraw animated:YES];
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        MessageModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
        [self.dataMuArr removeObjectAtIndex:indexPath.row];
        [[DataForFMDB sharedDataBase] deleteStudent:model];
        [self.dataMuArr removeAllObjects];
        self.dataMuArr = [[DataForFMDB sharedDataBase] getAllMessage];
        [self.tabView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tabView reloadData];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createMainView];
    } else {
        if (self.dataMuArr.count) {
            return nil;
        } else {
            return [UIView showNothingViewWith:1];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 45;
    } else {
        if (self.dataMuArr.count) {
            return 0;
        } else {
            return SCREEN_WIGHT-64-55;
        }
    }
}


- (UIView *)createMainView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 55)];
    mainView.backgroundColor = [UIColor Grey_BackColor1];
    
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 45)];
    content.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:content];
    leftView = [UIView new];
    [content addSubview:leftView];
    leftView.backgroundColor = [UIColor mianColor:1];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(95));
        make.height.equalTo(@(2));
        make.left.equalTo(content.mas_left).offset((SCREEN_WIGHT-190)/2);
        make.bottom.equalTo(content.mas_bottom);
    }];
    rightView = [UIView new];
    [content addSubview:rightView];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(95));
        make.height.equalTo(@(2));
        make.left.equalTo(leftView.mas_right).offset(0);
        make.bottom.equalTo(content.mas_bottom);
    }];
    
    UIView *left = [UIView new];
    [content addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(leftView.mas_top);
        make.top.equalTo(content.mas_top);
        make.width.equalTo(@(95));
        make.centerX.equalTo(leftView.mas_centerX);
    }];
    read_yes_Lab = [UILabel lableWithText:@"已读" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:1]];
    [left addSubview:read_yes_Lab];
    [read_yes_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(left.mas_centerX);
        make.centerY.equalTo(left.mas_centerY);
        make.height.equalTo(@(15));
    }];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapAction:)];
    [left addGestureRecognizer:leftTap];
    
    
    UIView *right = [UIView new];
    [content addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(rightView.mas_top);
        make.top.equalTo(content.mas_top);
        make.width.equalTo(@(95));
        make.centerX.equalTo(rightView.mas_centerX);
    }];
    read_no_Lab = [UILabel lableWithText:@"未读" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:2]];
    [left addSubview:read_no_Lab];
    [read_no_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(right.mas_centerX);
        make.centerY.equalTo(right.mas_centerY);
        make.height.equalTo(@(15));
    }];
    
    if (self.no_read_count.count) {
        _hint_no_read = [[UILabel alloc] init];
        _hint_no_read.font = FONT_ArialMT(12);
        _hint_no_read.textColor = [UIColor whiteColor];
        _hint_no_read.backgroundColor = [UIColor mianColor:1];
        _hint_no_read.layer.cornerRadius = 10;
        _hint_no_read.clipsToBounds = YES;
        _hint_no_read.textAlignment = NSTextAlignmentCenter;
        _hint_no_read.text = SINT(self.no_read_count.count);
        [left addSubview:_hint_no_read];
        [_hint_no_read mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@(20));
            make.left.equalTo(read_no_Lab.mas_right).offset(5);
            make.centerY.equalTo(read_no_Lab.mas_centerY);
        }];
    }
    
    
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTapAction:)];
    [right addGestureRecognizer:rightTap];
    
    
    
    return mainView;
}



#pragma mark - Action
- (void)rightTapAction:(UITapGestureRecognizer *)sender {
    read_no_Lab.textColor = [UIColor mianColor:1];
    rightView.backgroundColor = [UIColor mianColor:1];
    read_yes_Lab.textColor = [UIColor mianColor:2];
    leftView.backgroundColor = [UIColor clearColor];
    
    [self.dataMuArr removeAllObjects];
    if (self.no_read_count.count) {
        [self.dataMuArr addObjectsFromArray:self.no_read_count];
    } else {
        [self.dataMuArr removeAllObjects];
    }
    [self.no_read_count removeAllObjects];
    
    [_hint_no_read removeFromSuperview];
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tabView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)leftTapAction:(UITapGestureRecognizer *)sender {
    read_no_Lab.textColor = [UIColor mianColor:2];
    rightView.backgroundColor = [UIColor clearColor];
    read_yes_Lab.textColor = [UIColor mianColor:1];
    leftView.backgroundColor = [UIColor mianColor:1];
    
    [self.dataMuArr removeAllObjects];
    self.dataMuArr = [[DataForFMDB sharedDataBase] getAllMessage];
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tabView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)getdataSource {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"lastMessageId":@"0",@"userToken":[UserData currentUser].userToken}] forKey:@"option.selectMessageBox"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"%@", resultDic);
//        MessageModel *model = [[MessageModel alloc] init];
//        model.tid = @"55";
//        model.title = @"233";
//        model.status = @"";
//        model.createTime = @"";
//        model.createAgentId = @"";
//        model.messageType = @"6";
//        model.context = @"tsadsskadklasdjkajklsdakjshdkahsdkahdka";
//        [[DataForFMDB sharedDataBase] addStudent:model];
//        [self.no_read_count addObject:model];
        NSArray *dataArr = resultDic[@"resultData"];
        for (NSDictionary *dict in dataArr) {
            MessageModel *message = [[MessageModel alloc] initWithDictionary:dict error:nil];
            [self.no_read_count addObject:message];
            //插入数据库
            [[DataForFMDB sharedDataBase] addStudent:message];
        }
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

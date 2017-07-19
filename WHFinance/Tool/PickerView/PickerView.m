//
//  PickerView.m
//  text
//
//  Created by Apple on 2017/4/21.
//  Copyright © 2017年 Apple. All rights reserved.
//  万能的时间选择器

#import "PickerView.h"
#define BACKGROUND_BLACK_COLOR [UIColor colorWithRed:0.412 green:0.412 blue:0.412 alpha:0.7]
static const int pickerViewHeight = 228;
static const int toolBarHeight = 44;
@interface PickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)QQStrResultBlock block;
@property(nonatomic,assign)NSInteger component;
@property(nonatomic,assign)NSInteger typeID;
@property(nonatomic,strong)NSArray *yearArray;
@property(nonatomic,strong)NSArray *monthArray;
@property(nonatomic,strong)NSArray *dayArray;
@property(nonatomic,strong)NSArray *weakArray;
@property(nonatomic,strong)NSString *pickerViewRowStr;
@property(nonatomic,strong)NSString *componentStr1;
@property(nonatomic,strong)NSString *componentStr2;
@property(nonatomic,strong)NSString *componentStr3;
@end
@implementation PickerView
+(void)showPickerView:(UIView *)view componentNum:(NSInteger)num typePickerID:(NSInteger)typeID selectStr:(NSString *)selectStr StrBlock:(QQStrResultBlock)strBlock{
    PickerView *pickerView = [[PickerView alloc]initWithFrame:view.bounds];
    pickerView.component = num;
    pickerView.typeID = typeID;
    pickerView.block = strBlock;
    [pickerView typeJudge];
    pickerView.componentStr1 = pickerView.yearArray[0];
    pickerView.componentStr2 = pickerView.monthArray[0];

    if (pickerView.typeID == 3) {
        pickerView.componentStr3 = pickerView.dayArray[0];
    }else{
        pickerView.componentStr2 = pickerView.weakArray[0];
    }

    [pickerView initView];

    if (pickerView.typeID == 1) {
        pickerView.pickerViewRowStr = [NSString stringWithFormat:@"%@",pickerView.yearArray[0]];


    }else if (pickerView.typeID == 2){
        pickerView.pickerViewRowStr = [NSString stringWithFormat:@"%@,%@",pickerView.yearArray[0],pickerView.monthArray[0]];


    }else if (pickerView.typeID == 3){
        pickerView.pickerViewRowStr = [NSString stringWithFormat:@"%@,%@,%@",pickerView.yearArray[0],pickerView.monthArray[0],pickerView.dayArray[0]];


    }else{
        pickerView.pickerViewRowStr = [NSString stringWithFormat:@"%@,%@",pickerView.yearArray[0],pickerView.weakArray[0]];


    }
    [view addSubview:pickerView];
}
-(void)initView{
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - pickerViewHeight, SCREEN_WIGHT, pickerViewHeight)];
    containerView.backgroundColor = [UIColor whiteColor];
    UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIGHT -70, 5, 30, 30)];
    btnOK.titleLabel.font = FONT_ArialMT(14);
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor mianColor:1] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(pickerViewBtnOk:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:btnOK];
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(30, 5, 30, 30)];
    btnCancel.titleLabel.font = FONT_ArialMT(14);
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor mianColor:1] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:btnCancel];
    UILabel *hintLab = [UILabel lableWithText:@"请选择信用卡有效期" Font:FONT_ArialMT(14) TextColor:[UIColor mianColor:1]];
    hintLab.frame = CGRectMake((SCREEN_WIGHT-120)/2, 5, 140, 30);
    hintLab.textAlignment = NSTextAlignmentCenter;
    [containerView addSubview:hintLab];
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIGHT, pickerViewHeight - toolBarHeight)];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containerView addSubview:pickerView];
    self.backgroundColor = BACKGROUND_BLACK_COLOR;
    [self addSubview:containerView];

}
- (void)pickerViewBtnOk:(UIButton *)btn{
    if (self.typeID == 1) {
        self.pickerViewRowStr = [NSString stringWithFormat:@"%@",self.componentStr1];

        self.block(self.pickerViewRowStr);
    }else if (self.typeID == 2){
        self.pickerViewRowStr = [NSString stringWithFormat:@"%@/%@",self.componentStr1,self.componentStr2.length?self.componentStr2:@"01"];

        self.block(self.pickerViewRowStr);
    }else if (self.typeID == 3){
        self.pickerViewRowStr = [NSString stringWithFormat:@"%@,%@,%@",self.componentStr1,self.componentStr2,self.componentStr3];

        self.block(self.pickerViewRowStr);
    }else{
        self.pickerViewRowStr = [NSString stringWithFormat:@"%@,%@",self.componentStr1,self.componentStr2];
        
        self.block(self.pickerViewRowStr);
    }

    [self removeFromSuperview];

}
- (void)pickerViewBtnCancel:(UIButton *)btn{
    [self removeFromSuperview];
}
#pragma mark - PickerDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.component*2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (self.typeID == 1) {
        if (component == 0) {

            return self.yearArray.count;
        }else{
            return 1;
        }

    }else if (self.typeID == 2){
        if (component == 0) {
            return self.yearArray.count;
        }else if(component == 1){
            return 1;
        }else if (component == 2){
            return self.monthArray.count;
        }else{
            return 1;
        }
    }else if (self.typeID == 3){
        if (component == 0) {
            return self.yearArray.count;
        }else if (component == 1){
            return 1;

        }else if(component == 2){
            return self.monthArray.count;
        }else if(component == 3){
            return 1;
        }else if (component == 4){
            return self.dayArray.count;
        }else{
            return 1;
        }
    }else{
        if (component == 0) {
            return self.yearArray.count;
        }else if(component == 1){
            return 1;
        }else if (component == 2){
            return self.weakArray.count;
        }else{
            return 1;
        }
    }

}
#pragma mark - PickerDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.typeID == 1) {
        if (component == 0) {
            _componentStr1 = self.yearArray[row];
        }
    }else if (self.typeID == 2){
        if (component == 0) {
            _componentStr1 = self.yearArray[row];
        }else if (component == 2){
            _componentStr2 = self.monthArray[row];
        }
    }else if (self.typeID == 3){
        if (component == 0) {
            _componentStr1 = self.yearArray[row];
        }else if (component == 2){
            _componentStr2 = self.monthArray[row];
        }else if (component == 4){
            _componentStr3 = self.dayArray[row];
        }
    }else{
        if (component == 0) {
            _componentStr1 = self.yearArray[row];
        }else if (component == 2){
            _componentStr2 = self.weakArray[row];
        }
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (self.typeID == 1) {
        if (component == 0) {
            NSString *str = self.yearArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else{
            NSString *str = @"年";
            return [self singleLine:pickerView rowStr:str];
        }
    }else if (self.typeID == 2) {
        if (component == 0) {
            NSString *str =self.yearArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else if(component == 1){
            NSString *str = @"年";
            return [self singleLine:pickerView rowStr:str];
        }else if (component == 2) {
            NSString *str = self.monthArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else{
            NSString *str = @"月";
            return [self singleLine:pickerView rowStr:str];
        }
    }else if (self.typeID == 3) {
        if (component == 0) {
            NSString *str = self.yearArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else if(component == 1){
            NSString *str = @"年";
            return [self singleLine:pickerView rowStr:str];
        }else if (component == 2) {
            NSString *str = self.monthArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else if(component == 3){
            NSString *str = @"月";
            return [self singleLine:pickerView rowStr:str];
        }else if (component == 4) {
            NSString *str = self.dayArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else{
            NSString *str = @"日";
            return [self singleLine:pickerView rowStr:str];
        }
    }else{
        if (component == 0) {
            NSString *str = self.yearArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else if (component == 1){
            NSString *str = @"年";
            return [self singleLine:pickerView rowStr:str];
        }else if (component == 2){
            NSString *str = self.weakArray[row];
            return [self singleLine:pickerView rowStr:str];
        }else{
            NSString *str = @"周";
            return [self singleLine:pickerView rowStr:str];
        }
    }
}
-(UILabel *)singleLine:(UIPickerView *)pickerView rowStr:(NSString *)rowStr{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor redColor];
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = rowStr;
    genderLabel.font = [UIFont systemFontOfSize:15];
    genderLabel.textColor = [UIColor blackColor];
    return genderLabel;
}
-(void)typeJudge{
    if (self.typeID == 1) {
        self.yearArray = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021"];
        
    }else if (self.typeID == 2){
        self.yearArray = @[@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023",@"2024",@"2025"];
        self.monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
        
    }else if (self.typeID == 3){
        self.yearArray = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021"];
        self.monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
        self.dayArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"];
        
    }else if (self.typeID == 4){
        self.yearArray = @[@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021"];
        self.weakArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52"];
        
    }
}
@end

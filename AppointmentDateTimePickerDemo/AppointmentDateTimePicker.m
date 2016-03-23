//
//  AppointmentDateTimePicker.m
//  AppointmentDateTimePickerDemo
//
//  Created by yangli on 23/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import "AppointmentDateTimePicker.h"
#import "UIColor+Hex.h"

@interface AppointmentDateTimePicker () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIControl *touchLayer;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;
@property (nonatomic, strong) UILabel *hintLabel;

@property (nonatomic, strong) NSMutableArray *appointDateArray;
@property (nonatomic, strong) NSMutableArray *appointHoursArray;
@property (nonatomic, strong) NSMutableArray *appointOtherDayHoursArray;
@property (nonatomic, strong) NSString *todayDate;
@property (nonatomic, strong) NSString *resultData;

@end

@implementation AppointmentDateTimePicker

- (id)init
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        // Initialization code
        self.allowsTouchToDismiss = YES;
//        self.backgroundColor = [UIColor colorWithHexValue:0xeeeeee];
//        self.alpha = 1;
        
        [self calculatePickViewData];
    }
    return self;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 45;
}

- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont systemFontOfSize:15];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    switch (component) {
        case 0:
        {
            title = self.appointDateArray[row];
        }
            break;
        case 1:
        {
            NSString *dateStr = [self.appointDateArray[[self.pickerView selectedRowInComponent:0]] componentsSeparatedByString:@" "][0];
            if ([dateStr isEqualToString:self.todayDate]) {
                title = self.appointHoursArray[row];
            }
            else {
                title = self.appointOtherDayHoursArray[row];
            }
        }
            break;
            
        default:
            break;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            [pickerView reloadComponent:1];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger number = 0;
    switch (component) {
        case 0:
        {
            number = [self.appointDateArray count];
        }
            break;
        case 1:
        {
            NSString *dateStr = [self.appointDateArray[[self.pickerView selectedRowInComponent:0]] componentsSeparatedByString:@" "][0];
            if ([dateStr isEqualToString:self.todayDate]) {
                number = [self.appointHoursArray count];
            }
            else {
                number = [self.appointOtherDayHoursArray count];
            }
        }
            break;
            
        default:
            break;
    }
    return number;
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

#pragma mark - Public

- (void)show
{
    [self addSubview:self.touchLayer];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.touchLayer.alpha = 0.5;
                     }
                     completion:^(BOOL finished) {
                         if (self.allowsTouchToDismiss) {
                             [self.touchLayer addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
                         }
                     }
     ];
    
    [self addSubview:self.pickerView];
    [self addSubview:self.hintLabel];
    [self addSubview:self.headerView];
    [self.headerView addSubview:self.cancelButton];
    [self.headerView addSubview:self.okButton];
    
    [self layoutIfNeeded];
}

- (void)hide
{
    if (self.allowsTouchToDismiss) {
        [self.touchLayer removeTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
    }
    
    [UIView animateWithDuration:0.1
                     animations:^{
                         self.touchLayer.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *item in self.subviews) {
                             [item removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

# pragma mark - Getter

- (UIControl *)touchLayer {
    if (_touchLayer == nil) {
        _touchLayer = [[UIControl alloc] initWithFrame:self.bounds];
        _touchLayer.backgroundColor = [UIColor blackColor];
        _touchLayer.alpha = 0.5;
    }
    return _touchLayer;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 120, self.frame.size.width, 120)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UILabel *)hintLabel {
    if (_hintLabel == nil) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.pickerView.frame.origin.y - 40, self.frame.size.width, 40)];
        _hintLabel.text = @"        请选择抵店时间，服务顾问会为您安排车辆服务";
        _hintLabel.textColor = [UIColor colorWithHexValue:0x333333];
        _hintLabel.font = [UIFont systemFontOfSize:13];
        _hintLabel.backgroundColor = [UIColor colorWithHexValue:0xf7eeaa];
    }
    return _hintLabel;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.hintLabel.frame.origin.y - 40, self.frame.size.width, 40)];
        [_headerView setBackgroundColor:[UIColor colorWithHexValue:0x363539]];
    }
    return _headerView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, self.headerView.bounds.size.height)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor colorWithHexValue:0x666666] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancelButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)okButton {
    if (_okButton == nil) {
        _okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.headerView.frame.size.width - 60, 0, 60, self.headerView.bounds.size.height)];
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor colorWithHexValue:0x33a7e9] forState:UIControlStateNormal];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _okButton.tag = 101;
        [_okButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

#pragma mark - Private

- (IBAction)buttonPressed:(UIButton *)sender
{
    sender.enabled = NO;
    [self hide];
    switch (sender.tag) {
        case 101:
        {
            NSString *date = [self.appointDateArray[[self.pickerView selectedRowInComponent:0]] componentsSeparatedByString:@" "][0];
            NSString *hour;
            if ([date isEqualToString:self.todayDate]) {
                hour = self.appointHoursArray[[self.pickerView selectedRowInComponent:1]];
            }
            else {
                hour = self.appointOtherDayHoursArray[[self.pickerView selectedRowInComponent:1]];
            }
            
            NSString * dateAndHour = [NSString stringWithFormat:@"%@ %@",date,[hour componentsSeparatedByString:@":"][0]];
            dateAndHour = [NSString stringWithFormat:@"%@:00:00",dateAndHour];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date0 = [dateFormatter dateFromString:dateAndHour];
            NSString *timestamp = [NSString stringWithFormat:@"%ld000",(long)[date0 timeIntervalSince1970]];
            
            [self.appointmentDateTimePickerDelegate appointmentDateTimePicker:self didDismissWithData:timestamp];
        }
            break;
            
        default:
            break;
    }
}

- (void)calculatePickViewData {
    
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setDateFormat:@"HH"];
    self.appointHoursArray = [[NSMutableArray alloc] init];
    self.appointOtherDayHoursArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 8; i < 18; i ++) {
        [self.appointOtherDayHoursArray addObject:[NSString stringWithFormat:@"%ld:00-%ld:00",(long)i,(long)i + 1]];
    }
    
    NSInteger hour = [[hourFormatter stringFromDate:[NSDate date]] integerValue];
    if (hour >= 17 || hour < 8) {
        for (NSInteger i = 8; i < 18; i ++) {
            [self.appointHoursArray addObject:[NSString stringWithFormat:@"%ld:00-%ld:00",(long)i,(long)i + 1]];
        }
    }
    else {
        for (NSInteger i = hour + 1; i < 18; i ++) {
            [self.appointHoursArray addObject:[NSString stringWithFormat:@"%ld:00-%ld:00",(long)i,(long)i + 1]];
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.todayDate = [dateFormatter stringFromDate:[NSDate date]];
    self.appointDateArray = [[NSMutableArray alloc] init];
    
    if (hour >= 17) {
        for (int i = 0; i < 10; i ++) {
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow: (i + 1) * 24 * 60 * 60];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
            
            [self.appointDateArray addObject:[NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:date],[self weekday:[comps weekday]]]];
        }
    }
    else {
        for (int i = 0; i < 11; i ++) {
            NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow: i * 24 * 60 * 60];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
            
            [self.appointDateArray addObject:[NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:date],[self weekday:[comps weekday]]]];
        }
    }
}

- (NSString *)weekday:(NSInteger) weekdayId {
    
    NSString *weekdayStr;
    switch (weekdayId) {
        case 1:
        {
            weekdayStr = @"周日";
        }
            break;
        case 2:
        {
            weekdayStr = @"周一";
        }
            break;
        case 3:
        {
            weekdayStr = @"周二";
        }
            break;
        case 4:
        {
            weekdayStr = @"周三";
        }
            break;
        case 5:
        {
            weekdayStr = @"周四";
        }
            break;
        case 6:
        {
            weekdayStr = @"周五";
        }
            break;
        case 7:
        {
            weekdayStr = @"周六";
        }
            break;
            
        default:
            break;
    }
    return weekdayStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

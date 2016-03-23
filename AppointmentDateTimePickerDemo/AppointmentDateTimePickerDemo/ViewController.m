//
//  ViewController.m
//  AppointmentDateTimePickerDemo
//
//  Created by yangli on 23/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import "ViewController.h"
#import "AppointmentDateTimePicker.h"

@interface ViewController () <AppointmentDateTimePickerDelegate>

@property (nonatomic, strong) UIButton *makeAppointButton;
@property (nonatomic, strong) AppointmentDateTimePicker *appointDateTimePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.makeAppointButton = [[UIButton alloc] initWithFrame:CGRectMake(15, self.view.bounds.size.height / 2 - 30, self.view.bounds.size.width - 30, 60)];
    [self.makeAppointButton setTitle:@"Make An Appointment" forState:UIControlStateNormal];
    [self.makeAppointButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.makeAppointButton.layer.cornerRadius = 5.0;
    self.makeAppointButton.layer.borderWidth = 1.0;
    self.makeAppointButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.makeAppointButton addTarget:self action:@selector(toMakeAnAppointment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.makeAppointButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AppointmentDateTimePickerDelegate

- (void)appointmentDateTimePicker:(AppointmentDateTimePicker *)appointmentDateTimePicker didDismissWithData:(id)data {
    NSLog(@"appointmentDateTimePicker,data = %@",data);
}

#pragma mark - Action

- (IBAction)toMakeAnAppointment:(id)sender {
    self.appointDateTimePicker = [[AppointmentDateTimePicker alloc] init];
    [self.view addSubview:self.appointDateTimePicker];
    self.appointDateTimePicker.appointmentDateTimePickerDelegate = self;
    [self.appointDateTimePicker show];
}

@end

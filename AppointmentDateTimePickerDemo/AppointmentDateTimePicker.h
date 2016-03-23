//
//  AppointmentDateTimePicker.h
//  AppointmentDateTimePickerDemo
//
//  Created by yangli on 23/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppointmentDateTimePicker;

@protocol AppointmentDateTimePickerDelegate <NSObject>

@optional
- (void) appointmentDateTimePicker:(AppointmentDateTimePicker *) appointmentDateTimePicker didDismissWithData:(id)data;

@end

@interface AppointmentDateTimePicker : UIView

@property (nonatomic, assign) BOOL allowsTouchToDismiss;
@property (nonatomic,weak) id<AppointmentDateTimePickerDelegate> appointmentDateTimePickerDelegate;

- (void)show;
- (void)hide;

@end

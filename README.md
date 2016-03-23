# AppointmentDateTimePicker
用于预约时间的空间，特色：可预约8：00-18：00之间任一1小时区间时间，若当天时间大于17：00，则只能预约未来10天的工作时间段，其他则可预约11天（包含当天）的工作时间段

# Usage
```
#import "AppointmentDateTimePicker.h"
```
```
@property (nonatomic, strong) AppointmentDateTimePicker *appointDateTimePicker;
```
implement the AppointmentDateTimePickerDelegate
```
#pragma mark - AppointmentDateTimePickerDelegate

- (void)appointmentDateTimePicker:(AppointmentDateTimePicker *)appointmentDateTimePicker didDismissWithData:(id)data {
    NSLog(@"appointmentDateTimePicker,data = %@",data);
}
```
So easy,and you can edit the code also

# Demo Screen Shot
![image](https://github.com/liya328/AppointmentDateTimePicker/blob/master/AppointmentDateTimePickerDemo/AppointmentDateTimePickerDemo.png)

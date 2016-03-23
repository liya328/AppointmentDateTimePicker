//
//  UIColor+Hex.h
//  AppointmentDateTimePickerDemo
//
//  Created by yangli on 23/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (instancetype)colorWithHexValue:(NSUInteger)hex;
+ (instancetype)colorWithHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

@end

//
//  UIColor+Hex.m
//  AppointmentDateTimePickerDemo
//
//  Created by yangli on 23/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (instancetype)colorWithHexValue:(NSUInteger)hex
{
    return [self colorWithHexValue:hex alpha:1.0];
}

+ (instancetype)colorWithHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

@end

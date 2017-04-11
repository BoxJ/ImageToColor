//
//  UIColor+toString.m
//  FotoPlace
//
//  Created by jingliang on 2017/3/31.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import "UIColor+toString.h"

@implementation UIColor (toString)
-(NSString *)toColorString
{
    CGFloat r, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int rgb = (int) (r * 255.0f)<<16 | (int) (g * 255.0f)<<8 | (int) (b * 255.0f)<<0;
    return [NSString stringWithFormat:@"0x%06x", rgb];
}
@end

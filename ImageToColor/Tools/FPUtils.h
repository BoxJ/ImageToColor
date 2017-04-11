//
//  FPUtils.h
//  FotoPlace
//
//  Created by wenke on 16/6/27.
//  Copyright © 2016年 Fotoplace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FPUtils : NSObject
+ (instancetype)shareUtils;

-(UIColor *)hexStringToColor:(NSString *)stringToConvert;

@end

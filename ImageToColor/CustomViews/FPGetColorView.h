//
//  FPGetColorView.h
//  FotoPlace
//
//  Created by jingliang on 2017/3/24.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
@interface FPGetColorView : UIView
@property(nonatomic,copy)NSString *jpgImageName;
@property(nonatomic, copy) void (^didUpdate)(CGPoint point,UIColor *color);
@end

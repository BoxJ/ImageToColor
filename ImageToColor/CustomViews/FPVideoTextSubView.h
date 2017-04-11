//
//  FPVideoTextSubView.h
//  FotoPlace
//
//  Created by jingliang on 2017/3/24.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "VideoText.h"
@interface FPVideoTextSubView : UIView
@property(nonatomic,assign)TextMenuType showType;
@property(nonatomic,strong)VideoText *model;
@property(nonatomic,copy)void (^didColorChanged)(TextMenuType showType,UIColor *color);
@property(nonatomic,copy)void (^didSliderValueChanged)(TextMenuType showType,CGFloat value);
@end

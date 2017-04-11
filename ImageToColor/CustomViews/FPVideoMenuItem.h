//
//  FPVideoMenuItemView.h
//  FotoPlace
//
//  Created by jingliang on 2017/3/21.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
@interface FPVideoMenuItem : UIView
-(instancetype)initWithShowStyle:(VideoMenuStyle)style;
-(instancetype)initWithFrame:(CGRect)frame showStyle:(VideoMenuStyle)style;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)UIImage *coverImage;
@property(nonatomic,assign)BOOL hiddenCoverImage;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIColor *themeColor;
/*-----调整用----*/
@property(nonatomic,assign)CGRect progressRect;
@property(nonatomic,assign)CGFloat progressAlpha;
@property(nonatomic,assign)CGFloat progressBgAlpha;

@property(nonatomic,assign)VideoMenuStyle showStyle;
@end

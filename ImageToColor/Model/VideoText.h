//
//  VideoText.h
//  FotoPlace
//
//  Created by jingliang on 2017/3/25.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VideoText : NSObject
-(instancetype)initWithModel:(VideoText *)model;
//文字
@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)CGFloat fontSize;
//颜色
@property(nonatomic,strong)UIColor *textColor;
//描边
@property(nonatomic,assign)CGFloat strokeWidth;
@property(nonatomic,strong)UIColor *strokeColor;
//阴影
@property(nonatomic,assign)CGSize shadowOffset;
@property(nonatomic,assign)CGFloat shadowBlurRadius;
@property(nonatomic,strong)UIColor *shadowColor;
//背景色
@property(nonatomic,strong)UIColor *backgroundColor;
//透明度
@property(nonatomic,assign)CGFloat alpha;
-(NSAttributedString *)getAttributeStringFromSelf;
@end

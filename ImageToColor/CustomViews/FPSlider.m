//
//  FPSlider.m
//  FotoPlace
//
//  Created by Jingliang on 15/11/5.
//  Copyright (c) 2015年 Fotoplace. All rights reserved.
//

#import "FPSlider.h"
@interface FPSlider ()
{
    UIControl *_bgLine;
    UIControl *_leftLine;
    UIControl *_rightLine;
}
@end
@implementation FPSlider
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        _bgLine=[[UIControl alloc] initWithFrame:CGRectMake(0,(CGRectGetHeight(frame)-1.0)/2.0,CGRectGetWidth(frame),1.0)];
        _bgLine.backgroundColor=GETFOURFIVECOLOR;
        [self addSubview:_bgLine];
        _leftLine=[[UIControl alloc] initWithFrame:CGRectMake(0,(CGRectGetHeight(frame)-1.0)/2.0,CGRectGetWidth(frame)/2.0,1.0)];
        _leftLine.backgroundColor=HexRGB(0x666666);
        [self addSubview:_leftLine];
        _rightLine=[[UIControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)/2.0,(CGRectGetHeight(frame)-1.0)/2.0,CGRectGetWidth(frame)/2.0,1.0)];
        _rightLine.backgroundColor=HexRGB(0x666666);
        [self addSubview:_rightLine];
    }
    return self;
}
-(void)updateView
{
    if (self.minimumValue<0) {
        _leftLine.hidden=NO;
        if (self.value>(self.minimumValue+self.maximumValue)/2.0) {
            _leftLine.frame=CGRectMake(0,(CGRectGetHeight(self.bounds)-1.0)/2.0,CGRectGetWidth(self.bounds)/2.0,1.0);
            _rightLine.frame=CGRectMake(CGRectGetWidth(self.bounds)/2.0+(self.value/self.maximumValue/2.0*CGRectGetWidth(self.bounds)),(CGRectGetHeight(self.bounds)-1.0)/2.0,CGRectGetWidth(self.bounds)/2.0,1.0);
        }
        else
        {
         
            _leftLine.frame=CGRectMake((self.value/self.maximumValue/2.0*CGRectGetWidth(self.bounds)),(CGRectGetHeight(self.bounds)-1.0)/2.0,CGRectGetWidth(self.bounds)/2.0,1.0);
            _rightLine.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0,(CGRectGetHeight(self.bounds)-1.0)/2.0,CGRectGetWidth(self.bounds)/2.0,1.0);
        }
    }
    else
    {
        _leftLine.hidden=YES;
        _rightLine.frame=CGRectMake(((self.value-self.minimumValue)/(self.maximumValue-self.minimumValue))*CGRectGetWidth(self.bounds),(CGRectGetHeight(self.bounds)-1.0)/2.0,CGRectGetWidth(self.bounds),1.0);
    }
}
//- (CGRect)trackRectForBounds:(CGRect)bounds {
//    return CGRectMake(0,(CGRectGetHeight(bounds)-1.0)/2.0,CGRectGetWidth(bounds),1.0);
//}
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(1.2,(CGRectGetHeight(bounds)-1.0)/2.0,CGRectGetWidth(bounds)-2.4,1.0);
}
@end

//
//  FPGetColorView.m
//  FotoPlace
//
//  Created by jingliang on 2017/3/24.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import "FPGetColorView.h"
#import "UIImage+Color.h"
@interface FPGetColorView ()
{
    CGFloat imageWidth;
    CGFloat imageHeight;
    UIImage *_image;
    BOOL _canCallBack;
    BOOL _isColorFull;
}
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImageView *pickimgView;
@property(nonatomic,strong)UIView *indicateView;
@end
@implementation FPGetColorView
-(instancetype)init
{
    self=[super init];
    if (self) {
        [self initView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
-(void)initView
{
    _canCallBack=NO;
    _isColorFull=NO;
    if (!self.imageView) {
        self.imageView=[[UIImageView alloc] init];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    if (!self.pickimgView) {
        self.pickimgView=[[UIImageView alloc] initWithImage:ImageFromNamed(@"video_pick")];
        self.pickimgView.contentMode=UIViewContentModeScaleAspectFill;
//        self.pickimgView.bounds=CGRectMake(0, 0, 50.0, 50.0);
        _pickimgView.hidden=YES;
//        _pickimgView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
        [_imageView addSubview:_pickimgView];
    }
    if (!self.indicateView) {
//        self.indicateView=[[UIView alloc] initWithFrame:CGRectMake(8.0,4.0, 34.0, 34.0)];
        self.indicateView=[[UIView alloc] initWithFrame:CGRectMake(6.0,2.5,25.0,25.0)];
        _indicateView.layer.cornerRadius=12.5;
        _indicateView.clipsToBounds=YES;
        [_pickimgView addSubview:_indicateView];
    }
}
-(void)setJpgImageName:(NSString *)jpgImageName
{
    _canCallBack=NO;
    if (_jpgImageName.length && jpgImageName.length && [_jpgImageName isEqualToString:jpgImageName]) {
        _canCallBack=YES;
        return;
    }
    if (jpgImageName.length)
    {
        _jpgImageName=jpgImageName;
        _image=ImageFromNameJpg(jpgImageName);
        if (_image) {
            _canCallBack=YES;
            _imageView.image=_image;
            imageWidth=_image.size.width;
            imageHeight=_image.size.height;
            if ([jpgImageName isEqualToString:@"colours"]) {
                _isColorFull=YES;
            }
            else
            {
                _isColorFull=NO;
            }
            if (_isColorFull) {
                _imageView.contentMode=UIViewContentModeScaleAspectFill;
                //        750*350
                
                CGFloat viewScale=CGRectGetWidth(self.bounds)/CGRectGetHeight(self.bounds);
                CGFloat realScale=imageWidth/imageHeight;
                CGRect rect=_imageView.bounds;
                if (viewScale>realScale) {
                    rect.size.height=CGRectGetHeight(self.bounds);
                    rect.size.width=rect.size.height*realScale;
                }
                else
                {
                    rect.size.width=CGRectGetWidth(self.bounds);
                    rect.size.height=rect.size.width/realScale;
                }
                _imageView.bounds=rect;
                _imageView.center=CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)-CGRectGetHeight(rect)+CGRectGetHeight(rect)/2.0);
            }
            else
            {
                _imageView.contentMode=UIViewContentModeScaleToFill;
                _imageView.frame=self.bounds;
            }
//            imageWidth=_image.size.width;
//            imageHeight=_image.size.height;
////        750*350
//            _imageView.image=_image;
//            
//            CGFloat viewScale=CGRectGetWidth(self.bounds)/CGRectGetHeight(self.bounds);
//            CGFloat realScale=imageWidth/imageHeight;
//            CGRect rect=_imageView.bounds;
//            if (viewScale>realScale) {
//                rect.size.height=CGRectGetHeight(self.bounds);
//                rect.size.width=rect.size.height*realScale;
//            }
//            else
//            {
//                rect.size.width=CGRectGetWidth(self.bounds);
//                rect.size.height=rect.size.width/realScale;
//            }
//            _imageView.bounds=rect;
//            _imageView.center=CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)-CGRectGetHeight(rect)+CGRectGetHeight(rect)/2.0);
        }
        else
        {
            _imageView.image=nil;
        }
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_canCallBack) {
        return;
    }
    [self callBackWithTouch:[touches anyObject]];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!_canCallBack) {
        return;
    }
    [self callBackWithTouch:[touches anyObject]];
}
-(void)touchesCanCelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _pickimgView.hidden=YES;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _pickimgView.hidden=YES;
}
-(void)callBackWithTouch:(UITouch *)touch
{
    CGFloat xScale=imageWidth/_imageView.frame.size.width;
    CGFloat yScale=imageHeight/_imageView.frame.size.height;
    CGPoint point = [touch locationInView:_imageView];
    if (!CGRectContainsPoint(CGRectInset(_imageView.bounds, 2.0, 2.0), point)) {
        return;
    }
    _pickimgView.hidden=NO;
    CGPoint realPoint=CGPointMake(point.x*xScale, point.y*yScale);
    UIColor *color=[_image colorAtPixel:realPoint];
    _pickimgView.center=CGPointMake(point.x, point.y-50.0);
    _indicateView.backgroundColor=color;
    if (_didUpdate && color) {
        _didUpdate(point,color);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

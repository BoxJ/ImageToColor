//
//  FPVideoMenuItemView.m
//  FotoPlace
//
//  Created by jingliang on 2017/3/21.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import "FPVideoMenuItem.h"
@interface FPVideoMenuItem ()
{
    __weak UIImageView *_isNewImageView;
    __weak UIImageView *_imageView;
    __weak UIImageView *_selectCoverView;
    __weak UILabel *_titleLabel;
    __weak UILabel *_markView;
    __weak UIView *_themeColorView;
    
    __weak UIView *_progressBgView;
    __weak UIView *_progressView;
}
@end
@implementation FPVideoMenuItem
-(instancetype)initWithShowStyle:(VideoMenuStyle)style
{
    self=[super init];
    if (self) {
        [self initViewWithStyle:style];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame showStyle:(VideoMenuStyle)style
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initViewWithStyle:style];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViewWithStyle:VideoMenuStyle_Base];
    }
    return self;
}
-(void)initViewWithStyle:(VideoMenuStyle)style
{
    self.showStyle=style;
}
-(void)setShowStyle:(VideoMenuStyle)showStyle
{
    if (_showStyle==showStyle) {
        return;
    }
    _showStyle=showStyle;
    if (_showStyle==VideoMenuStyle_Down) {
        CGRect frame=self.frame;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,20.0,20.0)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.center=CGPointMake(CGRectGetWidth(frame)/2.0, 15.0);
        imageView.alpha=0.7;
        _imageView=imageView;
        [self addSubview:imageView];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,frame.size.height-15.0, frame.size.width,15.0)];
        titleLabel.textColor=HexRGB(0xffffff);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=GETDEFAULTFONT(10.0);
        _titleLabel=titleLabel;
        [self addSubview:titleLabel];
    }
    else if (_showStyle==VideoMenuStyle_TextDown)
    {
        CGRect frame=self.frame;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,27.0,27.0)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.center=CGPointMake(CGRectGetWidth(frame)/2.0, 26.0);
        imageView.alpha=0.7;
        _imageView=imageView;
        [self addSubview:imageView];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame), frame.size.width,20.0)];
        titleLabel.textColor=HexRGB(0xa0a0a0);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=GETDEFAULTFONT(11.0);
        _titleLabel=titleLabel;
        [self addSubview:titleLabel];
    }
    else if (_showStyle==VideoMenuStyle_Filter)
    {
        CGRect frame=self.frame;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame),CGRectGetWidth(self.frame))];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius=2.0;
        imageView.clipsToBounds=YES;
        _imageView=imageView;
        [self addSubview:imageView];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame), frame.size.width,CGRectGetHeight(self.frame)-CGRectGetHeight(imageView.frame))];
        titleLabel.textColor=HexRGB(0xffffff);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=GETDEFAULTFONT(10.0);
        _titleLabel=titleLabel;
        [self addSubview:titleLabel];
        UIView *themeColorView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame)-2.5, CGRectGetWidth(imageView.frame), 2.5)];
        _themeColorView=themeColorView;
        [imageView addSubview:themeColorView];
        UIImageView *selectCoverView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0.0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
        imageView.layer.cornerRadius=2.0;
        imageView.clipsToBounds=YES;
        selectCoverView.contentMode=UIViewContentModeCenter;
        selectCoverView.backgroundColor=GETFOURFIVECOLOR;
        _selectCoverView=selectCoverView;
        [imageView addSubview:selectCoverView];
    }
    else if (_showStyle==VideoMenuStyle_Adjust)
    {
        CGRect frame=self.frame;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame),CGRectGetWidth(self.frame))];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.layer.cornerRadius=2.0;
        imageView.backgroundColor=HexRGB(0x25272a);
        imageView.clipsToBounds=YES;
        imageView.alpha=0.7;
        _imageView=imageView;
        [self addSubview:imageView];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame), frame.size.width,CGRectGetHeight(self.frame)-CGRectGetHeight(imageView.frame))];
        titleLabel.textColor=HexRGB(0xffffff);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=GETDEFAULTFONT(10.0);
        _titleLabel=titleLabel;
        [self addSubview:titleLabel];
        
        CGFloat hei=2.5;
        UIView *progressBgView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame)-hei, CGRectGetWidth(imageView.frame), hei)];
        progressBgView.backgroundColor=ColorFromRGBAlpha(176, 176, 176, 0.1);
        _progressBgView=progressBgView;
        _progressBgAlpha=progressBgView.alpha=0.0;
        [imageView addSubview:progressBgView];
        
        UIView *progressView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(imageView.frame)-hei, CGRectGetWidth(imageView.frame), hei)];
        progressView.backgroundColor=ColorFromRGBAlpha(255, 255, 255, 0.2);
        _progressView=progressView;
        _progressAlpha=progressView.alpha=0.0;
        [imageView addSubview:progressView];
        _progressRect=progressView.frame;
    }
    else if (_showStyle==VideoMenuStyle_Transform)
    {
        CGRect frame=self.frame;
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame),CGRectGetWidth(self.frame))];
        imageView.contentMode=UIViewContentModeCenter;
        imageView.layer.cornerRadius=2.0;
        imageView.clipsToBounds=YES;
        imageView.backgroundColor=HexRGB(0x25272a);
        _imageView=imageView;
        [self addSubview:imageView];
        UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame), frame.size.width,CGRectGetHeight(self.frame)-CGRectGetHeight(imageView.frame))];
        titleLabel.textColor=HexRGB(0xffffff);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font=GETDEFAULTFONT(10.0);
        _titleLabel=titleLabel;
        [self addSubview:titleLabel];
        UIImageView *selectCoverView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0.0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
        imageView.layer.cornerRadius=2.0;
        imageView.clipsToBounds=YES;
        selectCoverView.contentMode=UIViewContentModeCenter;
        selectCoverView.backgroundColor=HexRGBAlpha(0x24a5e5, 0.4);
        _selectCoverView=selectCoverView;
        [imageView addSubview:selectCoverView];
    }
}
-(void)setImage:(UIImage *)image
{
    _image = _imageView.image = image;
}
-(void)setTitle:(NSString *)title
{
    _title = _titleLabel.text = title;
}
-(void)setCoverImage:(UIImage *)coverImage
{
    _coverImage = _selectCoverView.image = coverImage;
}
-(void)setThemeColor:(UIColor *)themeColor
{
    _themeColor = _themeColorView.backgroundColor = themeColor;
}
-(void)setHiddenCoverImage:(BOOL)hiddenCoverImage
{
    _hiddenCoverImage = _selectCoverView.hidden = hiddenCoverImage;
}
-(void)setProgressRect:(CGRect)progressRect
{
    _progressRect=_progressView.frame=progressRect;
}
-(void)setProgressBgAlpha:(CGFloat)progressBgAlpha
{
    _progressBgAlpha=_progressBgView.alpha=progressBgAlpha;
}
-(void)setProgressAlpha:(CGFloat)progressAlpha
{
    _progressAlpha=_progressView.alpha=progressAlpha;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

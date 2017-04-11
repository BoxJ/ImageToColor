//
//  FPVideoTextSubView.m
//  FotoPlace
//
//  Created by jingliang on 2017/3/24.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import "FPVideoTextSubView.h"
#import "FPSlider.h"
#import "FPGetColorView.h"
@interface FPVideoTextSubView ()
{
    CGFloat _xStart;
    CGFloat _yStart;
    CGFloat _xOffset;
    CGFloat _itemWidth;
    NSInteger _currentIndex;
}
@property(nonatomic,strong)UIScrollView *contentView;
@property(nonatomic,strong)FPGetColorView *getColorView;
@property(nonatomic,strong)UIView *sliderView;
@property(nonatomic,strong)FPSlider *adjustSlider;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *numberLabel;

@property(nonatomic,strong)NSMutableArray *colorArray;
@property(nonatomic,strong)NSMutableArray *bgColorArray;
@property(nonatomic,strong)NSMutableArray *textColorArray;
@end
@implementation FPVideoTextSubView
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
    WS(ws);
    _currentIndex=-1;
    self.contentView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 12.0, CGRectGetWidth(self.bounds), 60.0)];
    _contentView.showsHorizontalScrollIndicator=NO;
    [self addSubview:_contentView];
    if (!self.colorArray) {
        self.colorArray=[[NSMutableArray alloc] initWithObjects:[UIColor blueColor],[UIColor redColor],[UIColor purpleColor],[UIColor grayColor],[UIColor yellowColor],[UIColor whiteColor], nil];
    }
    if (!self.textColorArray) {
        self.textColorArray=[[NSMutableArray alloc] initWithObjects:@"colours",@"text#000000",@"text#808080",@"text#ffffff",@"text#F23D3D",@"text#FF9326",@"text#FFEC19",@"text#7FBF26",@"text#24A5E5",@"text#BF41D9",@"text#99521F",nil];
    }
    if (!self.bgColorArray) {
        self.bgColorArray=[[NSMutableArray alloc] initWithObjects:@"none",@"colours",@"text#000000",@"bg#808080",@"bg#ffffff",@"bg#B20000",@"bg#CC5500",@"bg#F2B600",@"bg#338033",@"bg#223773",@"bg#8932A6",@"bg#66250F",nil];
    }
    _xStart=14.0;
    _yStart=0.0;
    _xOffset=20.0;
    _itemWidth=60.0;
    for (int i=0; i<12; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_xStart+(_itemWidth+_xOffset)*i, _yStart, _itemWidth, _itemWidth);
        button.tag=1000+i;
        button.backgroundColor=HexRGB(0x25272a);
        button.hidden=YES;
        button.layer.cornerRadius=2.0;
        button.clipsToBounds=YES;
        [button addTarget:self action:@selector(colorDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:button];
    }
    
    _getColorView=[[FPGetColorView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_contentView.frame)+14.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-CGRectGetMaxY(_contentView.frame)-14.0)];
    _getColorView.hidden=YES;
    _getColorView.didUpdate=^(CGPoint point,UIColor *color){
        if (ws.didColorChanged) {
            ws.didColorChanged(ws.showType,color);
        }
    };
    [self addSubview:_getColorView];
    
    self.sliderView=[[UIView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_contentView.frame)+10.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-CGRectGetMaxY(_contentView.frame)-10.0)];
    _sliderView.hidden=YES;
    [self addSubview:_sliderView];
    UIView *downView=[[UIView alloc] init];
    downView.backgroundColor=HexRGBAlpha(0x3d3d3d,0.3);
    [_sliderView addSubview:downView];
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45.0);
    }];
    _titleLabel=[[UILabel alloc] init];
    _titleLabel.textColor=HexRGB(0xffffff);
    _titleLabel.font=[UIFont systemFontOfSize:11.0];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.text=@"哇咔咔";
    [downView addSubview:_titleLabel];
    _numberLabel=[[UILabel alloc] init];
    _numberLabel.textColor=HexRGB(0xffffff);
    _numberLabel.font=[UIFont systemFontOfSize:11.0];
    _numberLabel.textAlignment=NSTextAlignmentCenter;
    _numberLabel.text=@"+30";
    [downView addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.0);
        make.right.mas_equalTo(0.0);
        make.bottom.mas_equalTo(-45.0/2.0);
        make.height.mas_equalTo(18.0);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.0);
        make.right.mas_equalTo(0.0);
        make.top.mas_equalTo(45.0/2.0);
        make.height.mas_equalTo(18.0);
    }];
    
    _adjustSlider=[[FPSlider alloc] initWithFrame:CGRectMake(38.0,0.0, IPHONE_WIDTH-2*38.0,CGRectGetHeight(_sliderView.frame)-45.0)];
    _adjustSlider.minimumTrackTintColor=[UIColor clearColor];
    _adjustSlider.maximumTrackTintColor=[UIColor clearColor];
    [_adjustSlider setThumbImage:ImageFromNamed(@"progress_icon") forState:UIControlStateNormal];
    _adjustSlider.minimumValue=0.0;
    _adjustSlider.value=12.0;
    _adjustSlider.maximumValue=60.0;
    [_adjustSlider addTarget:self action:@selector(adjustSliderDidChange:) forControlEvents:UIControlEventValueChanged];
    //    [_adjustSlider addTarget:self action:@selector(adjustSliderDidend:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    _adjustSlider.clipsToBounds=YES;
    [_sliderView addSubview:_adjustSlider];
}
#pragma mark - Setter
-(void)setShowType:(TextMenuType)showType
{
    if (_showType==showType) {
        return;
    }
    _currentIndex=-1;
    _showType=showType;
    _contentView.hidden=_getColorView.hidden=_sliderView.hidden=YES;
    if (_showType==TextMenuType_Color) {
        _contentView.hidden=_getColorView.hidden=NO;
        NSString *string=_textColorArray[0];
        if ([string isEqualToString:@"video_size"]) {
            [_textColorArray removeObjectAtIndex:0];
        }
        for (int i=0; i<12; i++) {
            UIButton *button=[_contentView viewWithTag:1000+i];
            button.hidden=YES;
            button.layer.borderColor=[UIColor clearColor].CGColor;
            button.layer.borderWidth=0.0;
            if (i==0) {
                [self colorDidClick:button];
            }
            if (i<_textColorArray.count) {
                button.hidden=NO;
                if (i==0) {
                    [button setImage:ImageFromNameJpg(_textColorArray[i]) forState:UIControlStateNormal];
                }
                else
                {
                    NSString *textColorStr=_textColorArray[i];
                    if ([textColorStr containsString:@"text"]) {
                        textColorStr=[textColorStr stringByReplacingOccurrencesOfString:@"text" withString:@""];
                    }
                    [button setImage:nil forState:UIControlStateNormal];
                    UIColor *color = [[FPUtils shareUtils] hexStringToColor:textColorStr];
                    if (color) {
                        button.backgroundColor=color;
                    }
                }
            }
        }
        [_contentView setContentSize:CGSizeMake(2.0*_xStart+(_itemWidth+_xOffset)*_textColorArray.count-_xOffset, CGRectGetHeight(_contentView.frame))];
    }
    else if (_showType==TextMenuType_Stroke || _showType==TextMenuType_Shadow)
    {
        _contentView.hidden=_getColorView.hidden=NO;
        NSString *string=_textColorArray[0];
        if (![string isEqualToString:@"video_size"]) {
            [_textColorArray insertObject:@"video_size" atIndex:0];
        }
        for (int i=0; i<12; i++) {
            UIButton *button=[_contentView viewWithTag:1000+i];
            button.hidden=YES;
            button.layer.borderColor=[UIColor clearColor].CGColor;
            button.layer.borderWidth=0.0;
            if (i==1) {
                [self colorDidClick:button];
            }
            if (i<_textColorArray.count) {
                button.hidden=NO;
                if (i==0) {
                    [button setImage:ImageFromNamed(_textColorArray[i]) forState:UIControlStateNormal];
                }
                else if (i==1)
                {
                    [button setImage:ImageFromNameJpg(_textColorArray[i]) forState:UIControlStateNormal];
                }
                else
                {
                    NSString *textColorStr=_textColorArray[i];
                    if ([textColorStr containsString:@"text"]) {
                        textColorStr=[textColorStr stringByReplacingOccurrencesOfString:@"text" withString:@""];
                    }
                    [button setImage:nil forState:UIControlStateNormal];
                    UIColor *color = [[FPUtils shareUtils] hexStringToColor:textColorStr];
                    if (color) {
                        button.backgroundColor=color;
                    }
                }
            }
        }
        [_contentView setContentSize:CGSizeMake(2.0*_xStart+(_itemWidth+_xOffset)*_textColorArray.count-_xOffset, CGRectGetHeight(_contentView.frame))];
    }
    else if (_showType==TextMenuType_Background)
    {
        _contentView.hidden=_getColorView.hidden=NO;
        for (int i=0; i<12; i++) {
            UIButton *button=[_contentView viewWithTag:1000+i];
            button.hidden=YES;
            if (i<_bgColorArray.count) {
                button.hidden=NO;
                button.layer.borderColor=[UIColor clearColor].CGColor;
                button.layer.borderWidth=0.0;
                if (i==1) {
                    [self colorDidClick:button];
                }
                if (i==0) {
                    [button setImage:ImageFromNamed(_bgColorArray[i]) forState:UIControlStateNormal];
                }
                else if (i==1) {
                    [button setImage:ImageFromNameJpg(_bgColorArray[i]) forState:UIControlStateNormal];
                }
                else
                {
                    NSString *textColorStr=_bgColorArray[i];
                    if ([textColorStr containsString:@"bg"]) {
                        textColorStr=[textColorStr stringByReplacingOccurrencesOfString:@"bg" withString:@""];
                    }
                    [button setImage:nil forState:UIControlStateNormal];
                    UIColor *color = [[FPUtils shareUtils] hexStringToColor:textColorStr];
                    if (color) {
                        button.backgroundColor=color;
                    }
                }
            }
        }
        [_contentView setContentSize:CGSizeMake(2.0*_xStart+(_itemWidth+_xOffset)*_bgColorArray.count-_xOffset, CGRectGetHeight(_contentView.frame))];
    }
    else if (_showType==TextMenuType_Alpha)
    {
        _sliderView.hidden=NO;
        _adjustSlider.value=self.model.alpha*100;
        _adjustSlider.maximumValue=100.0;
        _adjustSlider.minimumValue=0.0;
        _titleLabel.text=@"Alpha";
        _numberLabel.text=[NSString stringWithFormat:@"%ld",(long)_adjustSlider.value];
        [_adjustSlider updateView];
    }
}
-(void)setModel:(VideoText *)model
{
    _model=model;
}
#pragma mark - 事件
-(void)colorDidClick:(UIButton *)button
{
    NSInteger index=button.tag-1000;
    if (_currentIndex!=-1) {
        UIButton *buttonOld=[_contentView viewWithTag:1000+_currentIndex];
        buttonOld.layer.borderColor=[UIColor clearColor].CGColor;
        buttonOld.layer.borderWidth=0.0;
    }
//    if (index!=0) {
        button.layer.borderColor=GETFOURFIVECOLOR.CGColor;
        button.layer.borderWidth=3.0;
//    }
    if (_showType==TextMenuType_Background) {
        _getColorView.jpgImageName=_bgColorArray[index];
        if (index==0) {
            if (_didColorChanged) {
                _didColorChanged(_showType,[UIColor clearColor]);
            }
        }
    }
    else
    {
        _getColorView.jpgImageName=_textColorArray[index];
        if ((_showType == TextMenuType_Stroke || _showType == TextMenuType_Shadow) && index==0) {
            if (_showType==TextMenuType_Stroke) {
                _adjustSlider.value=self.model.strokeWidth*100;
                _adjustSlider.maximumValue=100.0;
                _adjustSlider.minimumValue=-100.0;
                _titleLabel.text=@"描边";
                _numberLabel.text=[NSString stringWithFormat:@"%ld",(long)_adjustSlider.value];
            }
            else
            {
                _adjustSlider.value=self.model.shadowBlurRadius*100;
                _adjustSlider.maximumValue=100.0;
                _adjustSlider.minimumValue=0.0;
                _titleLabel.text=@"阴影";
                _numberLabel.text=[NSString stringWithFormat:@"%ld",(long)_adjustSlider.value];
            }
            [_adjustSlider updateView];
            _sliderView.hidden=NO;
        }
        else
        {
            _sliderView.hidden=YES;
        }
    }
    _currentIndex=index;
}
-(void)adjustSliderDidChange:(FPSlider *)slider
{
    [_adjustSlider updateView];
    _numberLabel.text=[NSString stringWithFormat:@"%ld",(long)_adjustSlider.value];
    if (_didSliderValueChanged) {
        CGFloat value=slider.value;
        _didSliderValueChanged(_showType,value);
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

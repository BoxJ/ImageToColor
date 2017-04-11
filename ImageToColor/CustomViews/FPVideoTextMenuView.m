//
//  FPVideoTextMenuView.m
//  FotoPlace
//
//  Created by jingliang on 2017/3/24.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import "FPVideoTextMenuView.h"
#import "FPVideoMenuItem.h"
@interface FPVideoTextMenuView ()
@property(nonatomic,strong)NSMutableArray *imageTitleArray;
@property(nonatomic,strong)NSMutableArray *imageSelectTitleArray;
@end
@implementation FPVideoTextMenuView
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
    self.backgroundColor=HexRGB(0x16181a);
    NSMutableArray *titleArray=[[NSMutableArray alloc] initWithObjects:@"",@"颜色",@"描边",@"阴影",@"背景",@"透明度", nil];
    _imageTitleArray=[[NSMutableArray alloc] initWithObjects:@"video_keyboard",@"video_color_normal",@"video_stroke_normal",@"video_shadow_normal",@"video_background_normal",@"video_transparency_normal", nil];
    _imageSelectTitleArray=[[NSMutableArray alloc] initWithObjects:@"video_keyboard",@"video_color_choose",@"video_stroke_choose",@"video_shadow_choose",@"video_background_choose",@"video_transparency_choose", nil];
    UIButton *keyboardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    keyboardButton.frame=CGRectMake(0, 0, 63.0, CGRectGetHeight(self.bounds));
    [keyboardButton setImage:ImageFromNamed(_imageTitleArray[0]) forState:UIControlStateNormal];
    keyboardButton.tag=200;
    [keyboardButton addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:keyboardButton];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(keyboardButton.frame), 16.0, 1.0, CGRectGetHeight(self.bounds)-32.0)];
    line.backgroundColor=HexRGBAlpha(0xffffff, 0.2);
    [self addSubview:line];
    CGFloat xStart=CGRectGetMaxX(line.frame);
    CGFloat downMenuItemWidth=(IPHONE_WIDTH-xStart)/(titleArray.count-1);
    CGFloat itemHeight=CGRectGetHeight(self.bounds);
    for (int i=1; i<titleArray.count; i++) {
        FPVideoMenuItem *menuItem=[[FPVideoMenuItem alloc] initWithFrame:CGRectMake(xStart +downMenuItemWidth*(i-1), 0, downMenuItemWidth, itemHeight)];
        menuItem.tag=100+i;
        menuItem.showStyle=VideoMenuStyle_TextDown;
        menuItem.title=titleArray[i];
        [self addSubview:menuItem];
        menuItem.image=ImageFromNamed(_imageTitleArray[i]);
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=200+i;
        button.frame=menuItem.frame;
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
}
#pragma mark - Setter
-(void)setSelectType:(TextMenuType)selectType
{
    if (_selectType==selectType) {
        return;
    }
    _selectType=selectType;
    for (int i=0; i<_imageTitleArray.count; i++) {
        if (i==0) {
//            UIButton *button=[self viewWithTag:200];
//            [button setImage:ImageFromNamed(_imageTitleArray[0]) forState:UIControlStateNormal];
        }
        else
        {
            FPVideoMenuItem *menuItem=[self viewWithTag:100+i];
            menuItem.image=ImageFromNamed(_imageTitleArray[i]);
            if ((_selectType-1)==i) {
                menuItem.image=ImageFromNamed(_imageSelectTitleArray[i]);
            }
        }
    }
}
#pragma mark - 事件
-(void)itemClick:(UIButton *)button
{
    NSInteger index=button.tag-200+1;
    if (_selectType==index) {
//        if (_selectType!=TextMenuType_None) {
//            self.selectType=TextMenuType_None;
//            if (_didSelectTextMenuTypeRepeat) {
//                _didSelectTextMenuTypeRepeat(index);
//            }
//        }
        return;
    }
    self.selectType=index;
    if (_didSelectTextMenuType) {
        _didSelectTextMenuType(index);
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

//
//  Common.h
//  ImageToColor
//
//  Created by jingliang on 2017/4/11.
//  Copyright © 2017年 井良. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#ifdef DEBUG
#define DLog(format, ...) NSLog((@"\n[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...) /* */
#endif
#define IPHONE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NEWSCALE (IPHONE_WIDTH/320.0)
#define NEWSCALEIPHONE6 (IPHONE_WIDTH/375.0)
#define NEWSCALEIPHONE6HEIGHT (IPHONE_HEIGHT/667.0)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define ImageFromNamed(str) [UIImage imageNamed:(str)]
#define ImageFromName(str) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(str) ofType:@"png"]]
#define ImageFromNameJpg(str) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(str) ofType:@"jpg"]]
#define ImageFromNamePDF(str) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(str) ofType:@"pdf"]]

#define GETFOURFIVECOLOR               HexRGB(0x24a5e5)
#define ColorFromRGB(a,b,c) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:1]
#define ColorFromRGBAlpha(a,b,c,x) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:(x)]
#define GETDEFAULTFONT(a) [UIFont systemFontOfSize:(a)]
#define NAVHEIGHTFOUR 44.0

typedef NS_ENUM(NSInteger,TextMenuType) {
    TextMenuType_None =0,  /**< 无-默认 */
    TextMenuType_Input =1,  /**< 输入 */
    TextMenuType_Color=2,     /**< 颜色 */
    TextMenuType_Stroke=3,     /**< 描边 */
    TextMenuType_Shadow=4,     /**< 阴影 */
    TextMenuType_Background=5,     /**< 背景 */
    TextMenuType_Alpha=6,     /**< 透明度 */
};

typedef NS_ENUM(NSInteger,VideoMenuStyle) {
    VideoMenuStyle_Base =0,  /**< 默认 */
    VideoMenuStyle_Down =1,  /**< 底部菜单 */
    VideoMenuStyle_Theme =2,  /**< 模板 */
    VideoMenuStyle_Filter=3,     /**< 滤镜 */
    VideoMenuStyle_Music=4,     /**< 音乐 */
    VideoMenuStyle_Adjust=5,     /**< 调整 */
    VideoMenuStyle_Subtitle=6,     /**< 字幕 */
    VideoMenuStyle_Editing=7,     /**< 剪辑 */
    VideoMenuStyle_TextDown=8,     /**< 文字底部 */
    VideoMenuStyle_Transform=9,     /**< 转场 */
};

#import "Masonry.h"
#import "FPUtils.h"

#endif /* Common_h */

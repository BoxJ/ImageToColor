//
//  VideoText.m
//  FotoPlace
//
//  Created by jingliang on 2017/3/25.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import "VideoText.h"

@implementation VideoText
-(instancetype)initWithModel:(VideoText *)model
{
    self=[super init];
    if (self) {
        _text=model.text;
        _fontSize=model.fontSize;
        _textColor=model.textColor;
        _strokeWidth=model.strokeWidth;
        _strokeColor=model.strokeColor;
        _shadowOffset=model.shadowOffset;
        _shadowBlurRadius=model.shadowBlurRadius;
        _shadowColor=model.shadowColor;
        _backgroundColor=model.backgroundColor;
        _alpha=model.alpha;
    }
    return self;
}
-(NSAttributedString *)getAttributeStringFromSelf
{
    if (self.text.length) {
        NSString *string=self.text;
        NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc] initWithString:string];
        if (self.textColor) {
            [attributeString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.fontSize],NSForegroundColorAttributeName:_textColor} range:NSMakeRange(0, string.length)];
        }
        if (self.backgroundColor) {
            [attributeString addAttributes:@{NSBackgroundColorAttributeName:_backgroundColor} range:NSMakeRange(0, string.length)];
        }
        if (_shadowBlurRadius>0.0) {
            NSShadow *shadow = [NSShadow new];
            shadow.shadowColor = _shadowColor;
            shadow.shadowOffset = CGSizeMake(_shadowBlurRadius,_shadowBlurRadius);
            shadow.shadowBlurRadius =_shadowBlurRadius;
            [attributeString addAttributes:@{NSShadowAttributeName:shadow} range:NSMakeRange(0, string.length)];
        }
        if (_strokeWidth>0.0) {
             [attributeString addAttributes:@{NSStrokeWidthAttributeName:[NSNumber numberWithFloat:_strokeWidth],NSStrokeColorAttributeName:_strokeColor} range:NSMakeRange(0, string.length)];
        }
        return attributeString;
    }
    return [[NSAttributedString alloc] initWithString:@""];
}
@end

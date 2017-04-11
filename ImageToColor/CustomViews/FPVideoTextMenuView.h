//
//  FPVideoTextMenuView.h
//  FotoPlace
//
//  Created by jingliang on 2017/3/24.
//  Copyright © 2017年 Fotoplace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
@interface FPVideoTextMenuView : UIView
@property(nonatomic,assign)TextMenuType selectType;
@property(nonatomic,copy)void (^didSelectTextMenuType)(TextMenuType type);
@property(nonatomic,copy)void (^didSelectTextMenuTypeRepeat)(TextMenuType type);
@end

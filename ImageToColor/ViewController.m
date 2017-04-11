//
//  ViewController.m
//  ImageToColor
//
//  Created by jingliang on 2017/4/11.
//  Copyright © 2017年 井良. All rights reserved.
//

#import "ViewController.h"

#import "FPVideoTextMenuView.h"
#import "FPVideoTextSubView.h"

#import "VideoText.h"
@interface ViewController ()<UITextViewDelegate>
{
    BOOL _canMoveDownView;
    BOOL _resginFromTapDown;
}
@property(nonatomic,strong)UIView *playView;
@property(nonatomic,strong)UILabel *playLabel;
@property(nonatomic,strong)UITextView *inputTextView;
@property(nonatomic,strong)FPVideoTextMenuView *downMenuView;
@property(nonatomic,strong)FPVideoTextSubView *subMenuView;

@property(nonatomic,strong)VideoText *textModel;
@end
@implementation ViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.inputTextView becomeFirstResponder];
    self.downMenuView.selectType=TextMenuType_Input;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    _canMoveDownView=YES;
    _resginFromTapDown=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    [self initModel];
    [self initView];
}
-(void)initModel
{
    if (!self.textModel) {
        self.textModel=[[VideoText alloc] init];
        _textModel.text=@"看看颜色哈";
        _textModel.fontSize=30.0;
        _textModel.textColor=[UIColor whiteColor];
        _textModel.strokeWidth=0.5;
        _textModel.strokeColor=[UIColor blueColor];
        _textModel.shadowBlurRadius=0.5;
        _textModel.shadowOffset=CGSizeMake(2.0, 2.0);
        _textModel.shadowColor=[UIColor redColor];
        _textModel.backgroundColor=[UIColor clearColor];
        _textModel.alpha=1.0;
    }
}
-(void)initView
{
    WS(ws);
    self.view.backgroundColor=HexRGB(0x16181f);
    self.inputTextView=[[UITextView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH, 0.0, IPHONE_WIDTH, IPHONE_HEIGHT/2.0)];
    _inputTextView.delegate=self;
    _inputTextView.inputAccessoryView=[UIView new];
    _inputTextView.returnKeyType=UIReturnKeyDone;
    _inputTextView.text=self.textModel.text;
    [self.view addSubview:_inputTextView];
    
    self.playView=[[UIView alloc] initWithFrame:CGRectMake(18.0, NAVHEIGHTFOUR, IPHONE_WIDTH-36.0, IPHONE_WIDTH-36.0)];
    _playView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.playView];
    _playLabel=[[UILabel alloc] initWithFrame:_playView.bounds];
    _playLabel.font=GETDEFAULTFONT(24.0);
    _playLabel.textAlignment=NSTextAlignmentCenter;
    _playLabel.textColor=[UIColor whiteColor];
    [_playView addSubview:_playLabel];
    
    self.downMenuView=[[FPVideoTextMenuView alloc] initWithFrame:CGRectMake(0.0, IPHONE_HEIGHT, IPHONE_WIDTH, 64.0)];
    _downMenuView.didSelectTextMenuType=^(TextMenuType type){
        [ws updateViewWithType:type];
    };
    [self.view addSubview:_downMenuView];
    [self updateTextView];
    
}
-(void)updateTextView
{
    _playLabel.attributedText=[self.textModel getAttributeStringFromSelf];
}
#pragma mark - UI变化
-(void)updateViewWithType:(TextMenuType)type
{
    WS(ws);
    BOOL isInput = self.inputTextView.isFirstResponder;
    if (type==TextMenuType_Input) {
        if (self.subMenuView) {
            _subMenuView.hidden=YES;
        }
        if (!isInput) {
            _resginFromTapDown=YES;
            [self.inputTextView becomeFirstResponder];
        }
    }
    else
    {
        _resginFromTapDown=NO;
        if (!_subMenuView) {
            _subMenuView=[[FPVideoTextSubView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_downMenuView.frame), IPHONE_WIDTH, IPHONE_HEIGHT-CGRectGetMaxY(_downMenuView.frame))];
            _subMenuView.hidden=YES;
            _subMenuView.didColorChanged=^(TextMenuType type,UIColor *color){
                if (type==TextMenuType_Background) {
                    ws.playLabel.backgroundColor=color;
                    ws.textModel.backgroundColor=color;
                }
                else
                {
                    if (type==TextMenuType_Color) {
                        ws.textModel.textColor=color;
                    }
                    else if (type==TextMenuType_Stroke)
                    {
                        ws.textModel.strokeColor=color;
                    }
                    else if (type==TextMenuType_Shadow)
                    {
                        ws.textModel.shadowColor=color;
                    }
                    [ws updateTextView];
                }
            };
            _subMenuView.didSliderValueChanged=^(TextMenuType type,CGFloat value){
                if (type==TextMenuType_Alpha) {
                    ws.playLabel.alpha=value/100.0;
                    ws.textModel.alpha=value/100.0;
                }
                else
                {
                    if (type==TextMenuType_Stroke)
                    {
                        ws.textModel.strokeWidth=value/30.0;
                    }
                    else if (type==TextMenuType_Shadow)
                    {
                        ws.textModel.shadowBlurRadius=value/10.0;
                    }
                    [ws updateTextView];
                }
            };
            [self.view addSubview:_subMenuView];
        }
        _subMenuView.hidden=NO;
        if (isInput) {
            [self.inputTextView resignFirstResponder];
        }
        //        self.downMenuView.selectType=type;
        self.subMenuView.model=self.textModel;
        self.subMenuView.showType=type;
    }
    
}
#pragma mark - 监听键盘
-(void)keyboardWillChangeFrame:(NSNotification*)notif{
    if (_canMoveDownView) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        //UIKeyboardFrameEndUserInfoKey
        NSValue *keyboardBoundsValue = [[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notif userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardEndRect = [keyboardBoundsValue CGRectValue];
        CGRect downRect=_downMenuView.frame;
        if ((IPHONE_HEIGHT-keyboardEndRect.size.height-CGRectGetHeight(downRect))<CGRectGetMinY(downRect)) {
            downRect.origin.y=IPHONE_HEIGHT-keyboardEndRect.size.height-CGRectGetHeight(downRect);
            _downMenuView.frame=downRect;
        }
        else
        {
            _canMoveDownView=NO;
        }
    }
    
}
-(void)keyboardHide
{
    if (_resginFromTapDown) {
        self.downMenuView.selectType=TextMenuType_None;
    }
}
#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    NSString *string=[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (string.length) {
        self.textModel.text=string;
        [self updateTextView];
    }
    else
    {
        self.textModel.text=@"";
        [self updateTextView];
    }
}
#pragma mark -
-(void)dealloc
{
    DLog(@"文字编辑释放");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

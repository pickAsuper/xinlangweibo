//
//  LCComposeToolBar.m
//  新浪微博
//
//  Created by lichao on 15/8/8.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposeToolBar.h"
@interface LCComposeToolBar()
@property (nonatomic ,strong)UIButton *btn;

@end


@implementation LCComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self addChildButtonWithImageName:@"compose_camerabutton_background" type:LCComposeToolBarTypeCamera];
        [self addChildButtonWithImageName:@"compose_toolbar_picture" type:LCComposeToolBarTypePicture];
        [self addChildButtonWithImageName:@"compose_mentionbutton_background" type:LCComposeToolBarTypeMetion];
        
        [self addChildButtonWithImageName:@"compose_trendbutton_background" type:LCComposeToolBarTypeTrend];
        [self addChildButtonWithImageName:@"compose_emoticonbutton_background" type:LCComposeToolBarTypeEmotion];
    }
    return self;
}

-(void)addChildButtonWithImageName:(NSString *)imageName type:(LCComposeToolBarType )type{
    UIButton *btn =[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]] forState:UIControlStateHighlighted];
    
   
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
     btn.tag = type;
    [self addSubview:btn];
    
    self.btn =btn;



}

-(void)btnClick:(UIButton *)btn{
    if (self.buttonClick) {
        self.buttonClick(btn.tag);
    }
    
}
-(void)layoutSubviews{
     [super layoutSubviews];
    NSInteger count =self.subviews.count;
  
    CGFloat ChildW= self.width/count;
    
    for (int i = 0 ; i < count; i++) {
        UIButton *btn =self.subviews[i];
        btn.width=ChildW;
        btn.x =i * ChildW;
        btn.height =self.height;

    }

}

@end

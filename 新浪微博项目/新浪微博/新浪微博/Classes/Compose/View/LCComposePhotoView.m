//
//  LCComposePhotoView.m
//  新浪微博
//
//  Created by lichao on 15/8/10.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCComposePhotoView.h"
@interface LCComposePhotoView ()
@property (nonatomic ,weak)UIButton *delButton;

@end
@implementation LCComposePhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.userInteractionEnabled =YES;
        self.backgroundColor =randomColor;
       UIButton *delButton = [[UIButton alloc]init];
        [delButton setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
        [delButton sizeToFit];
        [delButton addTarget:self action:@selector(delButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delButton];
        self.delButton =delButton;
    }
    return self;
}
-(void)delButton:(UIButton *)btn{
  [UIView animateWithDuration:0.25 animations:^{
      self.alpha =0;
  }completion:^(BOOL finished) {
      [self removeFromSuperview];
  }];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.delButton.x =self.width-self.delButton.width;
    
}
@end

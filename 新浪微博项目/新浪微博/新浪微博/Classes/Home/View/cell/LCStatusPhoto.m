//
//  LCStatusPhoto.m
//  新浪微博
//
//  Created by lichao on 15/8/4.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusPhoto.h"
#import "UIImageView+WebCache.h"

@interface LCStatusPhoto ()

@property (nonatomic ,strong)UIImageView *gifImage;


@end

@implementation LCStatusPhoto

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //图片显示的样式
        self.contentMode =UIViewContentModeScaleAspectFill ;
          //把多余的地方裁剪掉
        self.clipsToBounds =YES;
        
        //在.gif 图片格式上 添加一张git图片
        UIImageView *gifImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];

         [self addSubview:gifImage];
        
        self.gifImage = gifImage;
        
        
    }
    return self;
}
//布局子控件 UIImageView *gifImage
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifImage.x =self.width -self.gifImage.width;
    self.gifImage.y = self.height -self.gifImage.height;

}


-(void)setPhoto:(LCPhoto *)photo{
    _photo =photo;
    
    if ([photo.thumbnail_pic hasSuffix:@".gif"]) {
        self.gifImage.hidden =NO;
    }else{
        self.gifImage.hidden =YES;
    }
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    

}

@end

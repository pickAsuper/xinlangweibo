//
//  LCStatusCell.m
//  新浪微博
//
//  Created by lichao on 15/8/1.
//  Copyright (c) 2015年 ___Super___. All rights reserved.
//

#import "LCStatusCell.h"
#import "LCStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "LCUser.h"
#import "LCStatus.h"
#import "LCStatusToolBar.h"
#import "LCStatusPhotos.h"


@interface LCStatusCell ()

@property(nonatomic,strong)UIView *originalView;

//头像
@property(nonatomic,strong)UIImageView *headImage;

//会员
@property(nonatomic,strong)UIImageView *vipImage;

//微博昵称
@property(nonatomic,strong)UILabel *nameLabel;

//微博内容
@property(nonatomic,strong)UILabel *contentLabel;

//微博发布时间
@property(nonatomic,strong)UILabel *createLabel;

//发布来源
@property(nonatomic,strong)UILabel *sourceLabel;

//发布缩略图
@property(nonatomic,strong)LCStatusPhotos *phonoView;


//底部的view(包括了转发 评论 赞)
@property (nonatomic ,strong)LCStatusToolBar *statusToolBar;

 /** 转发微博整体的view */
@property (nonatomic, weak) UIView *retweetView;

 /** 转发微博的内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/**
 *  转发微博的相册
 */
@property (nonatomic, weak) LCStatusPhotos *retweetPhoto;


@end


@implementation LCStatusCell


- (void)setStatusFrame:(LCStatusFrame *)statusFrame{
   
    _statusFrame =statusFrame;
    // 给子控件赋值
     // 给子控件设置位置
    self.originalView.frame =statusFrame.originalViewF;
    //发布者的头像
    NSString *userProfile =self.statusFrame.status.user.profile_image_url;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userProfile]];
    self.headImage.frame = statusFrame.headImageF;
    
    //是否是会员
    if (statusFrame.status.user.isVip) {
        //是会员
        self.vipImage.hidden =NO;
        
        self.vipImage.image =[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%zd",statusFrame.status.user.mbrank]];
        
        self.vipImage.frame =statusFrame.vipImageF;
        self.nameLabel.textColor =[UIColor orangeColor];
        
    }else{
        self.vipImage.hidden=YES;
        self.nameLabel.textColor =[UIColor blackColor];
    }
    
    
    //发布者是谁
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text =statusFrame.status.user.screen_name;
    
    //发布微博内容
    self.contentLabel.text = statusFrame.status.text;
    self.contentLabel.frame =statusFrame.contentLabelF;
    
    //发布微博消息时间
//    self.createLabel.text =statusFrame.status.created_at;
//    self.createLabel.frame =statusFrame.createLabelF;

    //直接调用get方法 >> 这样cell上的时间就回更改
    self.createLabel.text =statusFrame.status.created_at;
    CGSize createLabelSize =[self.createLabel.text sizeWithFont:self.createLabel.font];
    self.createLabel.frame =(CGRect){statusFrame.createLabelF.origin,createLabelSize};
    
    
    
    
    //发布消息的来源
    self.sourceLabel.text =statusFrame.status.source;
  //  NSLog(@"source%@",statusFrame.status.source);
    self.sourceLabel.frame =statusFrame.sourceLabelF;
    
    //如果有缩略图就赋值 >>注意在cell里面有if 必须要有else 要不然cell会显示出问题
    if (statusFrame.status.thumbnail_pic) {
        self.phonoView.hidden =NO;
        self.phonoView.pic_url =statusFrame.status.pic_urls;
        self.phonoView.frame = statusFrame.photoViewF;
  
    }else{
        self.phonoView.hidden =YES;
    }
    
    //是否有转发微博
    if (statusFrame.status.retweeted_status) {
        self.retweetView.hidden = NO; //显示
        self.retweetView.frame =statusFrame.retweetViewF;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@%@",statusFrame.status.user.screen_name,statusFrame.status.text];
           //转发的内容就是 @原创人名 和 原创的内容
       
        self.retweetContentLabel.text =retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        if (statusFrame.status.retweeted_status.pic_urls) {
            self.retweetPhoto.hidden =NO; //显示配图
            self.retweetPhoto.frame =statusFrame.retweetPhotoF;
            
            self.retweetPhoto.pic_url =statusFrame.status.retweeted_status.pic_urls;
         
        }else{
        
            self.retweetPhoto.hidden= YES; //隐藏配图
        }
    }else{
      
        self.retweetView.hidden=YES; //隐藏整个视图
        
    }

    
    self.statusToolBar.frame =statusFrame.statusToolBarF;
    self.statusToolBar.status =statusFrame.status;
     
    
    
}




-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      // 必须先初始化父控件 >>必须要有super init...
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
      // 添加子控件
        [self setUpOriginalView];
       
    
        //添加底部的view (转发 赞)
        LCStatusToolBar *statusToolBar =[[LCStatusToolBar alloc]init];
        [self.contentView addSubview:statusToolBar];
        self.statusToolBar =statusToolBar;
        
        [self  setUpRetweetView];
        
        
    }
    return self;
}

//添加子控件
-(void)setUpOriginalView{
   
    UIView *originalView =[[UIView alloc]init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor =[UIColor whiteColor];
    self.originalView =originalView;
    
    
    
    //添加头像
    UIImageView *headImage =[[UIImageView alloc]init];
    [originalView addSubview:headImage];
    self.headImage =headImage;
    
    //添加会员图标
    UIImageView *vipImage =[[UIImageView alloc]init];
    [originalView addSubview:vipImage];
    self.vipImage =vipImage;
    
    
    //添加名字的控件
    UILabel *nameLabel =[UILabel new];
    nameLabel.font =SYS_FONT(NAME_LABEL_SIZE);
    [originalView addSubview:nameLabel];
    self.nameLabel =nameLabel;
    
    //添加时间的控件
    UILabel *createLabel =[UILabel new];
    createLabel.font =SYS_FONT(CREATE_TIME_SIZE);
    [originalView addSubview:createLabel];
    self.createLabel =createLabel;
    
    //添加来源
    UILabel *sourceLabel =[UILabel new];
    sourceLabel.font =SYS_FONT(CREATE_TIME_SIZE);
    [originalView addSubview:sourceLabel];
    self.sourceLabel =sourceLabel;
    
    
    //添加内容添加原创微博的内容
    UILabel *contentLabel =[UILabel new];
    contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
    contentLabel.numberOfLines =0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //添加缩略图 一个显示图片的imageView
    LCStatusPhotos *phonoView =[[LCStatusPhotos alloc]init];
    [originalView addSubview:phonoView];
    self.phonoView = phonoView;

}

//设置转发微博的view 及子控件
-(void)setUpRetweetView{
    
    //创建转发微博的 整体 View
    UIView *retweetView =[[UIView alloc]init];
    retweetView .backgroundColor =RGB(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView =retweetView;
    
     //转发微博的内容
    UILabel *retweetContentLabel =[[UILabel alloc]init];
    retweetContentLabel.numberOfLines =0;
    retweetContentLabel.font =SYS_FONT(CONTENT_LABEL_SIZE);
    //把转发微博的内容添加到 整体 View 上
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel =retweetContentLabel;
    
    //创建转发微博的配图
    LCStatusPhotos *retweetPhoto = [[LCStatusPhotos alloc]init];
    [retweetView addSubview:retweetPhoto];
    self.retweetPhoto =retweetPhoto;
    

}


+(instancetype)cellWithTableView:(UITableView *)tableView{
   
    LCStatusCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor =[UIColor clearColor];
    
    return cell;
}



@end

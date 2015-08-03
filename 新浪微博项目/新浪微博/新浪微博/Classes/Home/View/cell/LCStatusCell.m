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

@interface LCStatusCell ()

//头像
@property(nonatomic,strong)UIImageView *headImage;

//微博昵称
@property(nonatomic,strong)UILabel *nameLabel;

//微博内容
@property(nonatomic,strong)UILabel *contentLabel;

//微博发布时间
@property(nonatomic,strong)UILabel *createLabel;

//发布来源
@property(nonatomic,strong)UILabel *sourceLabel;

//发布缩略图
@property(nonatomic,strong)UIImageView *phonoView;


//底部的view(包括了转发 评论 赞)
@property (nonatomic ,strong)LCStatusToolBar *statusToolBar;


@end


@implementation LCStatusCell


- (void)setStatusFrame:(LCStatusFrame *)statusFrame{
   
    _statusFrame =statusFrame;
    // 给子控件赋值
     // 给子控件设置位置
   
    //发布者的头像
    NSString *userProfile =self.statusFrame.status.user.profile_image_url;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:userProfile]];
    self.headImage.frame = statusFrame.headImageF;
    
    //发布者是谁
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text =statusFrame.status.user.screen_name;
    
    //发布微博内容
    self.contentLabel.text = statusFrame.status.text;
    self.contentLabel.frame =statusFrame.contentLabelF;
    
    //发布微博消息时间
    self.createLabel.text =statusFrame.status.created_at;
    self.createLabel.frame =statusFrame.createLabelF;
    
    //发布消息的来源
    self.sourceLabel.text =statusFrame.status.source;
    self.sourceLabel.frame =statusFrame.sourceLabelF;
    
    //如果有缩略图就赋值 >>注意在cell里面有if 必须要有else 要不然cell会显示出问题
    if (statusFrame.status.thumbnail_pic) {
        self.phonoView.hidden =NO;
        self.phonoView.frame =statusFrame.photoViewF;
        NSString *url = self.statusFrame.status.thumbnail_pic;
        [self.phonoView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        
    }else{
        self.phonoView.hidden =YES;
    }
    
    self.statusToolBar.frame =statusFrame.statusToolBarF;
    
     
    
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
      // 必须先初始化父控件 >>必须要有super init...
    
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
      // 添加子控件
        
        //添加头像
        UIImageView *headImage =[[UIImageView alloc]init];
        [self.contentView addSubview:headImage];
        self.headImage =headImage;
        
        //添加名字的控件
        UILabel *nameLabel =[UILabel new];
        //设置名字大小
        nameLabel.font =SYS_FONT(NAME_LABEL_SIZE);
        [self.contentView addSubview:nameLabel];
        self.nameLabel =nameLabel;
        
        //添加时间的控件
        UILabel *createLabel =[UILabel new];
        //设置名字大小
        createLabel.font =SYS_FONT(NAME_LABEL_SIZE);
        [self.contentView addSubview:createLabel];
        self.createLabel =createLabel;
        
        //添加来源
        UILabel *sourceLabel =[UILabel new];
        //设置名字大小
        sourceLabel.font =SYS_FONT(NAME_LABEL_SIZE);
        [self.contentView addSubview:sourceLabel];
        self.sourceLabel =sourceLabel;
        
        
        //添加内容控件
        UILabel *contentLabel =[UILabel new];
        contentLabel.font = SYS_FONT(CONTENT_LABEL_SIZE);
        contentLabel.numberOfLines =0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        //添加缩略图 一个显示图片的imageView
        UIImageView *phonoView =[[UIImageView alloc]init];
        [self.contentView addSubview:phonoView];
        self.phonoView = phonoView;
    
        //添加底部的view (转发 赞)
        LCStatusToolBar *statusToolBar =[[LCStatusToolBar alloc]init];
        [self.contentView addSubview:statusToolBar];
        self.statusToolBar =statusToolBar;
        
        
        
        
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
   
    LCStatusCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
 
    
    return cell;
}



@end

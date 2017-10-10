//
//  DGTouchUnlockView.h
//  TouchUnLock
//
//  Created by JasonLee on 2017/9/21.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGTouchUnlockConfiguration;
@protocol DGTouchUnlockViewDelegate;

@interface DGTouchUnlockView : UIView

@property(nonatomic, strong)DGTouchUnlockConfiguration *configuration;
@property(nonatomic, weak)id <DGTouchUnlockViewDelegate>delegate;

-(instancetype)initWithConfiguration:(DGTouchUnlockConfiguration *)configuration;
+(instancetype)viewWithConfiguration:(DGTouchUnlockConfiguration *)configuration;
@end

@protocol DGTouchUnlockViewDelegate<NSObject>
-(void)touchUnlockViewDidFinishedWithTouchView:(DGTouchUnlockView *)view andPassword:(NSString *)password;
@end

@interface DGTouchUnlockConfiguration : NSObject
@property (nonatomic , assign) int colNum;      //列数
@property (nonatomic , assign) int rowNum;      //行数
@property (nonatomic , strong) UIImage *normalImage; //正常状态图片
@property (nonatomic , strong) UIImage *selectedImage; //正常状态图片
@property (nonatomic , strong) UIColor *lineColor;     //连线颜色
@property (nonatomic , assign) CGFloat lineWidth;       //连线宽度
@property (nonatomic , assign) CGFloat btnWidth;        //点的宽度
@property (nonatomic , assign) CGFloat btnHeight;        //点的高度
@end



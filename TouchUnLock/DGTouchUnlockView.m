//
//  DGTouchUnlockView.m
//  TouchUnLock
//
//  Created by JasonLee on 2017/9/21.
//  Copyright © 2017年 JasonLee. All rights reserved.
//

#import "DGTouchUnlockView.h"
static const int COL_NUM = 3; //default 列数
static const int ROW_NUM = 3; //default 行数
static const CGFloat BTN_WIDTH = 50;
static const CGFloat BTN_HEIGHT = 50;
static const CGFloat LINE_WIDTH = 4;    //default 线宽
@implementation DGTouchUnlockView
{
    NSMutableArray *_btnArray;
    NSMutableArray *_selectBtnArray;
}

+(instancetype)viewWithConfiguration:(DGTouchUnlockConfiguration *)configuration{
    DGTouchUnlockView *view = [[DGTouchUnlockView alloc] initWithConfiguration:configuration];
    view.configuration = configuration;
    [view defaultConfiguration];
    [view createTouchButton];
    return view;
}
-(id)initWithConfiguration:(DGTouchUnlockConfiguration *)configuration{
    self = [super init];
    if (self) {
        _btnArray = [NSMutableArray arrayWithCapacity:0];
        _selectBtnArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
-(void)defaultConfiguration{
    self.configuration = !self.configuration ? [[DGTouchUnlockConfiguration alloc] init] : self.configuration;
    self.configuration.colNum = self.configuration.colNum == 0 ? COL_NUM : self.configuration.colNum;
    self.configuration.rowNum = self.configuration.rowNum == 0 ? ROW_NUM : self.configuration.rowNum;
    self.configuration.btnWidth = self.configuration.btnWidth == 0 ? BTN_WIDTH : self.configuration.btnWidth;
    self.configuration.btnHeight = self.configuration.btnHeight == 0 ? BTN_HEIGHT : self.configuration.btnHeight;
    self.configuration.lineWidth = self.configuration.lineWidth == 0 ? LINE_WIDTH : self.configuration.lineWidth;
    self.configuration.lineColor = !self.configuration.lineColor ? [UIColor colorWithRed:248/255.0 green:200/255.0 blue:179/255.0 alpha:1] : self.configuration.lineColor;
    self.configuration.normalImage = !self.configuration.normalImage ? [UIImage imageNamed:@"DGTouchUnlock_normal"] : self.configuration.normalImage;
    self.configuration.selectedImage = !self.configuration.selectedImage ? [UIImage imageNamed:@"DGTouchUnlock_selected"] : self.configuration.selectedImage;
}
-(void)createTouchButton{
    
    for (int i = 0; i < self.configuration.rowNum *self.configuration.colNum; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.tag = 10 + i;
        [btn setImage:self.configuration.normalImage forState:UIControlStateNormal];
        [btn setImage:self.configuration.selectedImage forState:UIControlStateSelected];
        btn.clipsToBounds = YES;
        [self addSubview:btn];
        [_btnArray addObject:btn];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addTouchButtonWith:touches];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addTouchButtonWith:touches];
    [self removeShapeLayer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < _selectBtnArray.count; i++) {
        UIButton *btn = (UIButton *)_selectBtnArray[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else{
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:[[touches anyObject] locationInView:self]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = self.configuration.lineColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = self.configuration.lineWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.path = path.CGPath;
    [self.layer insertSublayer:shapeLayer atIndex:1];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSString *password = @"";
    for (UIButton *btn in _selectBtnArray) {
        password = [password stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
        btn.selected = NO;
    }
    if ([self.delegate respondsToSelector:@selector(touchUnlockViewDidFinishedWithTouchView: andPassword:)]) {
        [self.delegate touchUnlockViewDidFinishedWithTouchView:self andPassword:password];
    }
    [_selectBtnArray removeAllObjects];
    [self removeShapeLayer];
}
-(void)removeShapeLayer{
    for (int  i = 0; i < self.layer.sublayers.count; i++) {
        if ([self.layer.sublayers[i] isKindOfClass:[CAShapeLayer class]]) {
            [self.layer.sublayers[i] removeFromSuperlayer];
        }
    }
}
-(void)addTouchButtonWith:(NSSet<UITouch *> *)touches{
    UITouch *touche = [touches anyObject];
    CGPoint point = [touche locationInView:self];
    for (int i = 0; i < _btnArray.count; i++) {
        UIButton *btn = [_btnArray objectAtIndex:i];
        if (CGRectContainsPoint(btn.frame, point)) {
            if (![_selectBtnArray containsObject:btn]) {
                [_selectBtnArray addObject:btn];
                btn.selected = YES;
            }
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat col = (self.frame.size.height - self.configuration.colNum * self.configuration.btnWidth) / (self.configuration.colNum + 1);
    CGFloat row = (self.frame.size.width - self.configuration.rowNum * self.configuration.btnHeight) / (self.configuration.rowNum + 1);
    for (int i = 0; i < _btnArray.count; i++) {
        UIButton *btn = _btnArray[i];
        btn.frame = CGRectMake(col + (col + self.configuration.btnWidth) * (i % self.configuration.colNum), row + (row + self.configuration.btnHeight) * (i / self.configuration.colNum), self.configuration.btnWidth, self.configuration.btnHeight);
    }
}

@end


@implementation DGTouchUnlockConfiguration

@end

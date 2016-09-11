//
//  HHRoundView.m
//  RoundButton
//
//  Created by LOVE on 16/9/11.
//  Copyright © 2016年 LOVE. All rights reserved.
//

#import "HHRoundView.h"
@interface HHRoundView (){
    CGFloat width;
    CGFloat height;

}
/* 中心按钮的中心点*/
@property(nonatomic,assign)CGPoint buttonCenter;
/* 半径*/
@property(nonatomic,assign)CGFloat radius;
/* 圆心夹角*/
@property(nonatomic,assign)CGFloat angle;
@end

@implementation HHRoundView

#pragma mark - init Method
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self createRoundbutton];
    }
    
    return self;
}
#pragma mark - create Control Method
-(void)createRoundbutton{
    width = self.frame.size.width;
    height = self.frame.size.height;
    CGFloat otherbuttoncount = 7;  //里圆总个数
    
    self.angle = 2* M_PI/otherbuttoncount;
    CGFloat margin = 20; //间距
    self.radius = 90; //圆心距
    
    CGFloat r =  self.radius * sinf(self.angle/2.0)- margin/2.0; //小圆半径
    
//   外圆
    UIButton *buttonCenter = [UIButton buttonWithType:UIButtonTypeCustom];
[self createbtn:buttonCenter frame:CGRectMake(width/2-80/2,width/2-80, 80, 80) title:@"个人秀" image:@"earth.png" tag:100 target:self action:@selector(buttonClick:)];
    self.buttonCenter = buttonCenter.center;
    NSArray *arrayData = @[@"年轻",@"90后",@"活泼",@"文艺小青年",@"乐观",@"幽默",@"美食"];
    for (int i  = 0; i<otherbuttoncount; i++) {//   里圆
        
        UIButton *otherbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self  createbtn:otherbtn frame:CGRectMake(0, 0, 2*r, 2*r) title:arrayData[i] image:@"bg1" tag:200+i target:self action:@selector(buttonClick:)];
        otherbtn.center = self.buttonCenter;
//        otherbtn.layer.cornerRadius = r;
        if (i == 0) {//默认选中第0个
            otherbtn.selected = YES;
        }
        [otherbtn setBackgroundImage:[UIImage imageNamed:@"bg1"] forState:UIControlStateNormal];
        [otherbtn setBackgroundImage:[UIImage imageNamed:@"bg2"] forState:UIControlStateSelected];
        
      //把中心按钮永远放在父视图最上层
        [self bringSubviewToFront:buttonCenter];
    }
}
#pragma mark - SEL Methods
-(void)buttonClick:(UIButton*)button{
    
    if (button.tag==100) {
        if (button.selected == NO) {
            [UIView animateWithDuration:0.3 animations:^{
                button.center  = self.buttonCenter;
            }];
            
            [UIView animateWithDuration:1 animations:^{
               
                for (int i = 0; i<7; i++) {
                    UIButton *btn = (UIButton *)[self viewWithTag:i+200];
                    CGFloat x = self.radius * cosf(self.angle * i) +self. buttonCenter.x;
                    CGFloat y = self.radius * sinf(self.angle * i) + self.buttonCenter.y;
                    btn.center = CGPointMake(x ,y);
                    btn.alpha = 1;
                }
            }];
        }else{
            
            [UIView animateWithDuration:1 animations:^{
                for (int i=0; i<7; i++) {
                    UIButton *btn = (UIButton *)[self viewWithTag:i+200];
                    btn.center = self.buttonCenter;
                    btn.alpha = 0;
                }
            }];
        }
        button.selected = !button.selected;
        
    }else if(button.tag>=200&&button.tag<207){
        button.selected = YES;
        [self selectChangedWithTag:button.tag];
        [self selectbuttonIndex:button.tag-200.0];
        
    }
}
-(void)selectChangedWithTag:(NSInteger)tag{
    
    for (int i =200; i<207; i++) {
        if (i==tag) {

        }else{
            UIButton *btn = (UIButton*)[self viewWithTag:i];
            btn.selected = NO;
        
        }
    }
}
//通过拿到对应的index 进行不同的操作
-(void)selectbuttonIndex:(NSInteger)index{
    
    NSLog(@"%zd",index);
}
#pragma mark - Encapsulation Method
-(UIButton *)createbtn:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title image:(NSString*)image tag:(NSInteger)tag target:(id)target action:(SEL)action{
    btn.frame = frame;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

@end

//
//  ViewController.m
//  RoundButton
//
//  Created by LOVE on 16/9/11.
//  Copyright © 2016年 LOVE. All rights reserved.
//

#import "ViewController.h"

#import "HHRoundView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HHRoundView *roundView = [[HHRoundView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:roundView];
    
   
}



@end

//
//  ViewController.m
//  ScrollVerticalyLabelDemo
//
//  Created by zhaoP on 2016/12/16.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "ViewController.h"
#import "ScrollVerticalyLabel.h"
@interface ViewController ()
@property (nonatomic,strong) ScrollVerticalyLabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_label = [[ScrollVerticalyLabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
	_label.textFont = [UIFont systemFontOfSize:18];
	_label.textColor = [UIColor greenColor];
//	_label.scrollDirection = ScrollVerticalyDirectionDown;
	[self.view addSubview:_label];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	_label.text = [NSString stringWithFormat:@"第%d条文字",arc4random_uniform(200)];
}


@end

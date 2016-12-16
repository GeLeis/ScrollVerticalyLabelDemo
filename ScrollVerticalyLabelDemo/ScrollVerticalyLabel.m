//
//  ScrollVerticalyLabel.m
//  ScrollVerticalyLabelDemo
//
//  Created by zhaoP on 2016/12/16.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "ScrollVerticalyLabel.h"

@interface ScrollVerticalyLabel ()<CAAnimationDelegate>
@property (nonatomic,strong) CATextLayer *currentTextLayer;//当前文字层
@property (nonatomic,strong) CATextLayer *nextTextLayer;//下一个被赋值的文字层
@property (nonatomic,assign) CGFloat scrollHeight;
@end

@implementation ScrollVerticalyLabel

- (instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		_currentTextLayer = [CATextLayer layer];
		_currentTextLayer.alignmentMode = kCAAlignmentCenter;
		_currentTextLayer.frame = CGRectMake(0, 0, self.layer.frame.size.width, self.layer.frame.size.height);
		_currentTextLayer.foregroundColor = [UIColor blackColor].CGColor;
		_nextTextLayer = [CATextLayer layer];
		
		_nextTextLayer.alignmentMode = kCAAlignmentCenter;
		_nextTextLayer.frame = CGRectMake(0, self.layer.frame.size.height, self.layer.frame.size.width, self.layer.frame.size.height);
		_nextTextLayer.foregroundColor = [UIColor blackColor].CGColor;
		_currentTextLayer.fontSize = 16;
		_nextTextLayer.fontSize = 16;
		[self.layer addSublayer:_currentTextLayer];
		[self.layer addSublayer:_nextTextLayer];
		self.layer.masksToBounds = YES;
		self.scrollDirection = ScrollVerticalyDirectionUp;
	}
	return self;
}

-(void)setTextColor:(UIColor *)textColor{
	_textColor = textColor;
	_currentTextLayer.foregroundColor = textColor.CGColor;
	_nextTextLayer.foregroundColor = textColor.CGColor;
}

-(void)setTextFont:(UIFont *)textFont{
	_textFont = textFont;
	CFStringRef fontName = (__bridge CFStringRef)(textFont.fontName);
	CGFontRef fontRef = CGFontCreateWithFontName(fontName);
	_currentTextLayer.font = fontRef;
	_nextTextLayer.font = fontRef;
	_currentTextLayer.fontSize = textFont.pointSize;
	_nextTextLayer.fontSize = textFont.pointSize;
}

-(void)setScrollDirection:(ScrollVerticalyDirection)scrollDirection{
	_scrollDirection = scrollDirection;
	if (scrollDirection == ScrollVerticalyDirectionUp) {
		self.scrollHeight = -self.layer.frame.size.height;
	}else{
		self.scrollHeight = self.layer.frame.size.height;
	}
	_nextTextLayer.frame = CGRectMake(0, -self.scrollHeight, self.layer.frame.size.width, self.layer.frame.size.height);
}

-(void)setText:(NSString *)text{
	_text = text;
	if (!self.currentTextLayer.string) {
		self.currentTextLayer.string = text;
		return;
	}else{
		self.nextTextLayer.string = text;
	}
	CABasicAnimation *currentLayerAni = [CABasicAnimation animation];
	currentLayerAni.keyPath = @"position.y";
	currentLayerAni.fromValue = @(self.currentTextLayer.position.y);
	currentLayerAni.toValue = @(self.currentTextLayer.position.y+self.scrollHeight);
	currentLayerAni.duration = 0.1;
	currentLayerAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	currentLayerAni.delegate = self;
	currentLayerAni.removedOnCompletion=NO;//动画结束了禁止删除
	currentLayerAni.fillMode= kCAFillModeForwards;//停在动画结束处
	[self.currentTextLayer addAnimation:currentLayerAni forKey:[NSString stringWithFormat:@"current%@%d",text,arc4random()]];
	
	CABasicAnimation *nextLayerAni = [CABasicAnimation animation];
	nextLayerAni.keyPath = @"position.y";
	nextLayerAni.fromValue = @(self.nextTextLayer.position.y);
	nextLayerAni.toValue = @(self.nextTextLayer.position.y +self.scrollHeight);
	nextLayerAni.duration = 0.1;
	nextLayerAni.removedOnCompletion=NO;
	nextLayerAni.fillMode= kCAFillModeForwards;
	nextLayerAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	[self.nextTextLayer addAnimation:nextLayerAni forKey:[NSString stringWithFormat:@"current%@%d",text,arc4random()]];
}

#pragma mark - delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	self.currentTextLayer.position = CGPointMake(self.currentTextLayer.position.x, self.currentTextLayer.position.y - self.scrollHeight);
	self.nextTextLayer.position = CGPointMake(self.nextTextLayer.position.x, self.nextTextLayer.position.y +self.scrollHeight);
	[self.currentTextLayer removeAllAnimations];
	[self.nextTextLayer removeAllAnimations];
	CATextLayer *tempLayer = [CATextLayer layer];
	tempLayer = self.currentTextLayer;
	self.currentTextLayer = self.nextTextLayer;
	self.nextTextLayer = tempLayer;
}

@end

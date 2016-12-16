//
//  ScrollVerticalyLabel.h
//  ScrollVerticalyLabelDemo
//
//  Created by zhaoP on 2016/12/16.
//  Copyright © 2016年 langya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ScrollVerticalyDirection) {
	ScrollVerticalyDirectionUp,//向上滚动,默认
	ScrollVerticalyDirectionDown
};

@interface ScrollVerticalyLabel : UIView
@property (nonatomic,assign) ScrollVerticalyDirection scrollDirection;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,strong) NSString *text;
@end

# ScrollVerticalyLabelDemo
ScrollVerticalyLabelDemo    
通过赋值，即可动画向上或者向下滚动出新值
```objc
_label = [[ScrollVerticalyLabel alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
_label.textFont = [UIFont systemFontOfSize:18];
_label.textColor = [UIColor greenColor];
_label.scrollDirection = ScrollVerticalyDirectionDown;
_label.text = [NSString stringWithFormat:@"第%d条文字",arc4random_uniform(200)];
```
![image](https://github.com/shorty-Man/ScrollVerticalyLabelDemo/blob/master/ScrollVerticalyLabelDemo/scroll.gif)

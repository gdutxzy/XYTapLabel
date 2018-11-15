//
//  ViewController.m
//  XZYTapLabelDemo
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "XZYTapLabel.h"

@interface ViewController ()<XZYTapLabelDelegate>
@property (weak, nonatomic) IBOutlet XZYTapLabel *attributeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XZYTapLabel * label = [[XZYTapLabel alloc] initWithFrame:CGRectMake(0, 200, 200, 0)];
    label.text = @"StyleSheet.create这个构造函数并不是必须的，但它提供了一些非常有用的好处。它可以把这些样式值转化为普通的数字id，这些数字id则指向一个内部的样式表，以此来使得样式值变得不可更改（immutable） 和 不可见（opaque）。把样式声明放到文件的末尾还可以确保它们只会在应用中被创建一次，而不是在每次渲染（render方法中）时都被重新创建";
    label.numberOfLines = 0;
    [label sizeToFit];
    label.highlightedBackgroudColor = [UIColor redColor];
    label.highlightedTextBackgroudColor = [UIColor greenColor];
    label.delegate = self;
    [label addTapRange:NSMakeRange(0, 10) with:@"0-10文字"];
    [label addTapRange:NSMakeRange(20, 10) with:@"20-30文字"];
    [label addTapRange:NSMakeRange(40, 10) with:@"40-50文字"];
    [label addTapRange:NSMakeRange(60, 10) with:@"60-70文字"];


    [self.view addSubview:label];
    
//    self.attributeLabel.delegate = self;
//    self.attributeLabel.numberOfLines = 0;
//    [self.attributeLabel addTapRange:NSMakeRange(0, 10) with:@"0-10文字"];
//    [self.attributeLabel addTapRange:NSMakeRange(20, 10) with:@"20-30文字"];
//    [self.attributeLabel addTapRange:NSMakeRange(40, 10) with:@"40-50文字"];
//    [self.attributeLabel addTapRange:NSMakeRange(60, 10) with:@"60-70文字"];
//
//    self.attributeLabel.highlightedBackgroudColor = [UIColor yellowColor];
//    self.attributeLabel.highlightedTextBackgroudColor = [UIColor blueColor];
//    // NSAttributestring必须包含NSFontAttributeName属性，否则大小判断会失败
//    self.attributeLabel.attributedText = [[NSAttributedString alloc]initWithString:@"其行为和Object.assign方法是一致的：为了避免多个值的冲突，最右边的元素优先级最高，而否定型的取值如false、undefined和null则会被忽略。一个通常的做法是根据某些条件选择性地添加样式。（如下面的代码，当this.state.active为false时，styles.active就会被忽略掉）" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
}



//这里其实是 - (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
- (void)XZYTapLabelDidCancelTouch{
    NSLog(@"任何手势都已经完毕或取消”");
}

- (void)XZYTapLabelDidtapWith:(NSObject *)information{
    if (information) {
        NSLog(@"点击了%@",information);
    }else{
        NSLog(@"点击了整个label");
    }
}

@end

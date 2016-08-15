//
//  XZYTapLabel.h
//  XZYTapLabelDemo
//
//  Created by mac on 16/8/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XZYTapLabelDelegate <NSObject>
@optional
/// 当点击到指定位置时，会返回对应的information，否则返回nil
- (void)XZYTapLabelDidtapWith:(NSObject *)information;
/// 触摸取消取消
- (void)XZYTapLabelDidCancelTouch;

@end


/** 点击事件只支持自适应大小后的Label,例如sizetofit。采用NSLayoutManager实现。
 注意，赋值attributedText时attributstring必须带NSFontAttributeName属性
 */
@interface XZYTapLabel : UILabel

/// 清除之前设置的点击范围，为避免例如UITableViewCell的重用机制使点击范围无限增多
- (void)cleanTapRange;
/// 设置点击的范围，附件信息information不能为nil。 可重复调用此方法，用来增加点击的范围。
- (void)addTapRange:(NSRange)range with:(NSObject *)information;
/// 返回点击已设置的taprange，否则为nil
- (NSString *)checkTapRangeWithPoint:(CGPoint)point;

@property (weak,nonatomic) id<XZYTapLabelDelegate> delegate;
/// 触摸时的背景颜色
@property (strong,nonatomic) UIColor *  highlightedBackgroudColor;
/// 触摸选中文字时的背景颜色
@property (strong,nonatomic) UIColor *  highlightedTextBackgroudColor;
@end

//
//  ZYLinkLabel.h
//  可以点击的label
//
//  Created by lizongyao on 2019/5/27.
//  Copyright © 2019 lizongyao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LinkBlock)(NSInteger index);
@interface ZYLinkLabel : UILabel
@property (nonatomic, copy) LinkBlock linkBlock;
- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor linkStrings:(NSArray *)linkStrings linkColor:(UIColor *)linkColor;
@end

NS_ASSUME_NONNULL_END

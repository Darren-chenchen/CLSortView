//
//  CLMenuSubView.h
//  CLSortView
//
//  Created by Darren on 16/2/27.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLMenuSubView : UIView
/**
 *  对号图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
/**
 *  最上面的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *subButton;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLable;


+ (instancetype)show;

@end

//
//  CLMenuSubView.m
//  CLSortView
//
//  Created by Darren on 16/2/27.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLMenuSubView.h"

@interface CLMenuSubView()

@property (nonatomic,weak) UIButton *currentSelectedBtn;
@property (nonatomic,weak) UIImageView *currentSelectedImg;

@property (nonatomic,assign,getter=isSelected) BOOL Selected;

@end

@implementation CLMenuSubView

+ (instancetype)show
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CLMenuSubView" owner:nil options:nil] lastObject];
}
- (IBAction)clickSubBtn:(UIButton *)sender {

}

- (void)awakeFromNib
{
    [self updateConstraints];
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end

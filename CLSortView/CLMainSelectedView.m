//
//  CLMainSelectedView.m
//  CLSortView
//
//  Created by Darren on 16/2/27.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CLMainSelectedView.h"
#import "CLMenuSubView.h"

@interface CLMainSelectedView()
/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**记录按钮是否被选中*/
@property (nonatomic,assign,getter=isSelected) BOOL btnSelected;
/**最左边的view*/
@property (nonatomic,strong) UIView *leftMenuView;
/**中间的view*/
@property (nonatomic,strong) UIView *middleMenuView;
/**最右边的view*/
@property (nonatomic,strong) UIView *rightMenuView;

/*当前选中的button，用于存储选中的按钮**/
@property (nonatomic,weak) UIButton *currentSelectedBtn;

/**拿到选中状态的图片*/
@property (nonatomic,assign) NSInteger leftCurrentSelectedImgTag;
@property (nonatomic,assign) NSInteger middleCurrentSelectedImgTag;
@property (nonatomic,assign) NSInteger rightCurrentSelectedImgTag;


@end

@implementation CLMainSelectedView
+ (instancetype)show
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CLMainSelectedView" owner:self options:nil] lastObject];
}

/**
 *  点击左边的按钮
 */
- (IBAction)clickLeftButton:(id)sender {
    self.btnSelected = !self.isSelected;
    if (self.btnSelected) {
        [self setupCover];
        // 箭头翻转
        self.leftButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.leftMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + self.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 0)];
        // 动画展示出leftMenuView
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.leftMenuView.frame;
            frame.size.height = self.leftMenuArrray.count*self.leftMenuSubViewHeight;
            self.leftMenuView.frame = frame;
        
        [window addSubview:self.leftMenuView];
        
        // 添加n个按钮
        for (int i = 0; i < self.leftMenuArrray.count; i++) {
            CLMenuSubView *menuSubView = [CLMenuSubView show];
            menuSubView.titleLable.text = self.leftMenuArrray[i];
            menuSubView.tag = 100+i;
            menuSubView.checkImageView.hidden = YES; // 隐藏打钩图片

            [menuSubView.subButton addTarget:self action:@selector(clickSubBtn:) forControlEvents:UIControlEventTouchUpInside];
            CGFloat btnY = i*self.leftMenuSubViewHeight;
            CGRect frame = menuSubView.frame;
            frame.origin.y = btnY;
            frame.size.height = self.leftMenuSubViewHeight;
            menuSubView.frame = frame;
            [self.leftMenuView addSubview:menuSubView];
        }
            // 取出之前选中的btn，设置它的图片显示，如果之前没有选中，默认选中第一个
            int currentSelectedBtnTag = [[[NSUserDefaults standardUserDefaults]  objectForKey:@"currentSelectedBtn"] intValue];
            if (currentSelectedBtnTag) {
                CLMenuSubView *menuSubView = self.leftMenuView.subviews[currentSelectedBtnTag-100];
                menuSubView.checkImageView.hidden = NO;
            } else {
                CLMenuSubView *menuSubView = [self.leftMenuView viewWithTag:100];
                menuSubView.checkImageView.hidden = NO;
                self.leftCurrentSelectedImgTag = menuSubView.tag;
            }
        }];
        
    } else {
        [self removeMenu];
    }
}

/**
 *  点击了button改变对号图标的显示,点击了leftMenuView上具体的button
 *
 *  @param sub 最上面的button
 */
- (void)clickSubBtn:(UIButton *)subBtn
{
    CLMenuSubView *menuSubView = (CLMenuSubView *)[subBtn superview]; // 获得点击那个button的父类
    
    // 隐藏之前选中的图片（通过tag值取）
    CLMenuSubView *menuSubView2 = self.leftMenuView.subviews[self.leftCurrentSelectedImgTag-100];
    menuSubView2.checkImageView.hidden = YES;
    
    menuSubView.checkImageView.hidden = NO;  // 当前选中的图片显示
    
    self.leftCurrentSelectedImgTag = menuSubView.tag;
    
    self.currentSelectedBtn = [menuSubView viewWithTag:menuSubView.tag];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.currentSelectedBtn.tag) forKey:@"currentSelectedBtn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self coverClick];
    });
}

/**
 *  点击了底部的遮盖，遮盖消失
 */
- (void)coverClick
{
    self.btnSelected = NO;  // 点击遮盖后让该属性变为no，如果不设置需要点击按钮2次才能进入菜单页面
    [self removeMenu];
}
/**
 *  点击中间的按钮
 */
- (IBAction)clickMiddleButton:(id)sender {
    self.btnSelected = !self.isSelected;
    if (self.btnSelected) {
        [self setupCover];
        self.middleButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.middleMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + self.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 0)];
        // 动画展示出leftMenuView
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.middleMenuView.frame;
            frame.size.height = self.middleMenuArray.count*self.middleMenuSubViewHeight;
            self.middleMenuView.frame = frame;
            [window addSubview:self.middleMenuView];
            
            // 添加n个按钮
            for (int i = 0; i < self.middleMenuArray.count; i++) {
                CLMenuSubView *subBtn = [CLMenuSubView show];
                subBtn.titleLable.text = self.middleMenuArray[i];
                subBtn.tag = 100+i;
                subBtn.checkImageView.hidden = YES; // 隐藏打钩图片
                
                [subBtn.subButton addTarget:self action:@selector(clickSubBtnMiddle:) forControlEvents:UIControlEventTouchUpInside];
                CGFloat btnY = i*self.middleMenuSubViewHeight;
                CGRect frame = subBtn.frame;
                frame.origin.y = btnY;
                subBtn.frame = frame;
                frame.size.height = self.middleMenuSubViewHeight;
                [self.middleMenuView addSubview:subBtn];
            }
            int currentSelectedBtnTag = [[[NSUserDefaults standardUserDefaults]  objectForKey:@"currentSelectedBtnMiddle"] intValue];
            if (currentSelectedBtnTag) {
                CLMenuSubView *menuSubView = self.middleMenuView.subviews[currentSelectedBtnTag-100];
                menuSubView.checkImageView.hidden = NO;
            } else {
                CLMenuSubView *menuSubView = [self.middleMenuView viewWithTag:100];
                menuSubView.checkImageView.hidden = NO;
                self.middleCurrentSelectedImgTag = menuSubView.tag;
            }

        }];
        
    } else {
        [self removeMenu];
    }

}

- (void)clickSubBtnMiddle:(UIButton *)subBtn
{
    CLMenuSubView *menuSubView = (CLMenuSubView *)[subBtn superview]; // 获得点击那个button的父类
    // 隐藏之前选中的图片（通过tag值取）
    CLMenuSubView *menuSubView2 = self.middleMenuView.subviews[self.middleCurrentSelectedImgTag-100];
    menuSubView2.checkImageView.hidden = YES;
    menuSubView.checkImageView.hidden = NO;
    self.middleCurrentSelectedImgTag = menuSubView.tag;
    self.currentSelectedBtn = [menuSubView viewWithTag:menuSubView.tag];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.currentSelectedBtn.tag) forKey:@"currentSelectedBtnMiddle"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self coverClick];
    });

}
/**
 *  点击右边的按钮
 */
- (IBAction)clickRightButton:(id)sender {
    self.btnSelected = !self.isSelected;
    if (self.btnSelected) {
        [self setupCover];
        self.rightButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.rightMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height + self.frame.origin.y, [UIScreen mainScreen].bounds.size.width, 0)];
        // 动画展示出leftMenuView
        [UIView animateWithDuration:0.1 animations:^{
            CGRect frame = self.rightMenuView.frame;
            frame.size.height = self.rightMenuArray.count*self.rightMenuSubViewHeight;
            self.rightMenuView.frame = frame;
            [window addSubview:self.rightMenuView];
            
            // 添加n个按钮
            for (int i = 0; i < self.rightMenuArray.count; i++) {
                CLMenuSubView *subBtn = [CLMenuSubView show];
                subBtn.titleLable.text = self.rightMenuArray[i];
                subBtn.tag = 100+i;
                subBtn.checkImageView.hidden = YES; // 隐藏打钩图片
                
                [subBtn.subButton addTarget:self action:@selector(clickSubBtnRight:) forControlEvents:UIControlEventTouchUpInside];
                CGFloat btnY = i*self.rightMenuSubViewHeight;
                CGRect frame = subBtn.frame;
                frame.origin.y = btnY;
                subBtn.frame = frame;
                frame.size.height = self.rightMenuSubViewHeight;
                [self.rightMenuView addSubview:subBtn];
            }
            int currentSelectedBtnTag = [[[NSUserDefaults standardUserDefaults]  objectForKey:@"currentSelectedBtnRight"] intValue];
            if (currentSelectedBtnTag) {
                CLMenuSubView *menuSubView = self.rightMenuView.subviews[currentSelectedBtnTag-100];
                menuSubView.checkImageView.hidden = NO;
            } else {
                CLMenuSubView *menuSubView = [self.rightMenuView viewWithTag:100];
                menuSubView.checkImageView.hidden = NO;
                self.rightCurrentSelectedImgTag = menuSubView.tag;
            }
        }];
        
    } else {
        [self removeMenu];
    }
}

- (void)clickSubBtnRight:(UIButton *)subBtn
{
    CLMenuSubView *menuSubView = (CLMenuSubView *)[subBtn superview]; // 获得点击那个button的父类
    
    // 隐藏之前选中的图片（通过tag值取）
    CLMenuSubView *menuSubView2 = self.rightMenuView.subviews[self.rightCurrentSelectedImgTag-100];
    menuSubView2.checkImageView.hidden = YES;

    menuSubView.checkImageView.hidden = NO;
    
    self.rightCurrentSelectedImgTag = menuSubView.tag;
    
    self.currentSelectedBtn = [menuSubView viewWithTag:menuSubView.tag];
    [[NSUserDefaults standardUserDefaults] setObject:@(self.currentSelectedBtn.tag) forKey:@"currentSelectedBtnRight"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self coverClick];
    });
}

/**
 *  添加遮盖
 */
- (void)setupCover
{
    // 添加一个遮盖按钮
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *cover = [[UIButton alloc] init];
    CGFloat coverY = self.frame.size.height + self.frame.origin.y;
    cover.frame = CGRectMake(0, coverY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.3;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:cover];
    self.cover = cover;
}

/**
 *  菜单消失
 */
- (void)removeMenu
{
    self.middleButton.imageView.transform = CGAffineTransformMakeRotation(0);
    self.rightButton.imageView.transform = CGAffineTransformMakeRotation(0);
    self.leftButton.imageView.transform = CGAffineTransformMakeRotation(0);
    
    [self.rightMenuView removeFromSuperview];
    [self.leftMenuView removeFromSuperview];
    [self.middleMenuView removeFromSuperview];
    [self.cover removeFromSuperview];
}

@end

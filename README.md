# CLSortView
这是一个选择控件的封装
##基本使用
在需要创建控件的地方加上如下代码：
CLMainSelectedView *mainView = [CLMainSelectedView show];

mainView.leftMenuSubViewHeight = 40; // 默认是50

mainView.middleMenuSubViewHeight = 40;

mainView.rightMenuSubViewHeight = 40;

mainView.leftMenuArrray = @[@"热门",@"经典",@"儿童专区",@"成人专区"];

mainView.middleMenuArray = @[@"定位",@"热门",@"上海",@"北京"];

mainView.rightMenuArray = @[@"价格由低到高",@"价格由高到低",@"销量",@"好评"];

mainView.frame = CGRectMake(0, 20, self.view.frame.size.width, 50);

[self.view addSubview:mainView];
##提示
如果要在app完全退出，再次进入app默认选择第一个控件，需要在main.m文件中加入如下代码
[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentSelectedBtn"];

[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentSelectedBtnMiddle"];

[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"currentSelectedBtnRight"];

[[NSUserDefaults standardUserDefaults] synchronize];



# 风水罗盘Demo
+ 为了避免添加按钮UI层级过多导致的卡顿, 采用绘制路径的方式来识别点击的位置
+ 核心方法: UIBezierPath的`- (BOOL)containsPoint:(CGPoint)point;`方法
---
![image](https://github.com/XZLeon/CompassDemo/blob/master/IMG_0353.PNG)

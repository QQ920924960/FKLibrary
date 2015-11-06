//
//  FKQuartz2DView.m
//  FKLibraryExample
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKQuartz2DView.h"
#import "FKMacro.h"
static CGFloat const kRadius_FK = 70;
static CGFloat const kTopY_FK = 100;

@interface FKQuartz2DView ()
@property (nonatomic, assign) CGFloat snowY;
@end

@implementation FKQuartz2DView

- (void)drawRect:(CGRect)rect
{
    drawLine();
}

/**
 *  画线
 */
void drawLine()
{
    // Drawing code
    // 1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接图形(路径)
    // 设置线段宽度
    CGContextSetLineWidth(ctx, 10);
    
    // 设置线段头尾部的样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 设置线段转折点的样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    /**  第1根线段  **/
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    // 设置一个起点
    CGContextMoveToPoint(ctx, 10, 10);
    // 添加一条线段到(100, 100)
    CGContextAddLineToPoint(ctx, 100, 100);
    
    // 渲染一次
    CGContextStrokePath(ctx);
    
    
    /**  第2根线段  **/
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);
    // 设置一个起点
    CGContextMoveToPoint(ctx, 200, 190);
    // 添加一条线段到(150, 40)
    CGContextAddLineToPoint(ctx, 150, 40);
    CGContextAddLineToPoint(ctx, 120, 60);
    
    
    // 3.渲染显示到view上面
    CGContextStrokePath(ctx);
}

/**
 *  画四边形
 */
void draw4Rect()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画矩形
    CGContextAddRect(ctx, CGRectMake(10, 10, 150, 100));
    
    // set : 同时设置为实心和空心颜色
    // setStroke : 设置空心颜色
    // setFill : 设置实心颜色
    [[UIColor whiteColor] set];
    
    //    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    // 3.绘制图形
    CGContextFillPath(ctx);
}

/**
 *  画三角形
 */
void drawTriangle()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画三角形
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 150, 80);
    // 关闭路径(连接起点和最后一个点)
    CGContextClosePath(ctx);
    
    //
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);
    
    // 3.绘制图形
    CGContextStrokePath(ctx);
}

/**
 *  画圆弧
 */
void drawArc()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画圆弧
    // x\y : 圆心
    // radius : 半径
    // startAngle : 开始角度
    // endAngle : 结束角度
    // clockwise : 圆弧的伸展方向(0:顺时针, 1:逆时针)
    CGContextAddArc(ctx, 100, 100, 50, M_PI_2, M_PI, 0);
    
    
    // 3.显示所绘制的东西
    CGContextFillPath(ctx);
}

/**
 *  画圆
 */
void drawCircle()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画圆
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 10, 100, 100));
    
    CGContextSetLineWidth(ctx, 10);
    
    // 3.显示所绘制的东西
    CGContextStrokePath(ctx);
}

void drawImage()
{
    // 1.取得图片
    UIImage *image = [UIImage imageNamed:@"me"];
    
    // 2.画
    //    [image drawAtPoint:CGPointMake(50, 50)];
    //    [image drawInRect:CGRectMake(0, 0, 150, 150)];
    [image drawAsPatternInRect:CGRectMake(0, 0, 200, 200)];
    
    // 3.画文字
    NSString *str = @"为xxx所画";
    [str drawInRect:CGRectMake(0, 180, 100, 30) withAttributes:nil];
}

/**
 *  画文字
 */
void drawText()
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2.画矩形
    CGRect cubeRect = CGRectMake(50, 50, 100, 100);
    CGContextAddRect(ctx, cubeRect);
    // 3.显示所绘制的东西
    CGContextFillPath(ctx);
    
    
    
    // 4.画文字
    NSString *str = @"哈哈哈哈Good morning hello hi hi hi hi";
    //    [str drawAtPoint:CGPointZero withAttributes:nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    // NSForegroundColorAttributeName : 文字颜色
    // NSFontAttributeName : 字体
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    [str drawInRect:cubeRect withAttributes:attrs];
}



/************ 画小黄人 ************/
/**
 *  眼睛
 */
void drawEyes(CGContextRef ctx, CGRect rect)
{
    // 1.黑色绑带
    CGFloat startX = rect.size.width * 0.5 - kRadius_FK;
    CGFloat startY = kTopY_FK;
    CGContextMoveToPoint(ctx, startX, startY);
    CGFloat endX = startX + 2 * kRadius_FK;
    CGFloat endY = startY;
    CGContextAddLineToPoint(ctx, endX, endY);
    CGContextSetLineWidth(ctx, 15);
    [[UIColor blackColor] set];
    // 绘制线条
    CGContextStrokePath(ctx);
    
    // 2.最外圈的镜框
    [FKRGBAColor(61, 62, 66, 1) set];
    CGFloat kuangRadius = kRadius_FK * 0.4;
    CGFloat kuangY = startY;
    CGFloat kuangX = rect.size.width * 0.5 - kuangRadius;
    CGContextAddArc(ctx, kuangX, kuangY, kuangRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    // 3.里面的白色框
    [[UIColor whiteColor] set];
    CGFloat whiteRadius = kuangRadius * 0.7;
    CGFloat whiteX = kuangX;
    CGFloat whiteY = kuangY;
    CGContextAddArc(ctx, whiteX, whiteY, whiteRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
}

/**
 *  画嘴
 */
void drawZui(CGContextRef ctx, CGRect rect)
{
    // 中间的控制点
    CGFloat controlX = rect.size.width * 0.5;
    CGFloat controlY = rect.size.height * 0.4;
    
    // 当前点
    CGFloat marginX = 20;
    CGFloat marginY = 10;
    CGFloat currentX = controlX - marginX;
    CGFloat currentY = controlY - marginY;
    CGContextMoveToPoint(ctx, currentX, currentY);
    
    // 结束点
    CGFloat endX = controlX + marginX;
    CGFloat endY = currentY;
    
    // 贝塞尔曲线
    CGContextAddQuadCurveToPoint(ctx, controlX, controlY, endX, endY);
    
    // 设置颜色
    [[UIColor blackColor] set];
    
    // 渲染
    CGContextStrokePath(ctx);
}

/**
 *  画身体
 */
void drawBody(CGContextRef ctx, CGRect rect)
{
    // 上半圆
    CGFloat topX = rect.size.width * 0.5;
    CGFloat topY = kTopY_FK;
    CGFloat topRadius = kRadius_FK;
    CGContextAddArc(ctx, topX, topY, topRadius, 0, M_PI, 1);
    
    // 向下延伸
    CGFloat middleX = topX - topRadius;
    CGFloat middleH = 100; // 中间身体的高度
    CGFloat middleY = topY + middleH;
    CGContextAddLineToPoint(ctx, middleX, middleY);
    
    // 下半圆
    CGFloat bottomX = topX;
    CGFloat bottomY = middleY;
    CGFloat bottomRadius = topRadius;
    CGContextAddArc(ctx, bottomX, bottomY, bottomRadius, M_PI, 0, 1);
    
    // 合并路径
    CGContextClosePath(ctx);
    
    // 设置颜色
    [FKRGBAColor(252, 218, 0, 1) set];
    
    // 利用填充方式画出之前的路径
    CGContextFillPath(ctx);
}
/************ 画小黄人 ************/



/**
 *  矩阵操作
 渐变色
 虚线
 pattern
 blend
 .....
 .....
 阴影
 */
void CTM()
{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGContextSaveGState(ctx);
    
    CGContextRotateCTM(ctx, M_PI_4 * 0.3);
    CGContextScaleCTM(ctx, 0.5, 0.5);
    CGContextTranslateCTM(ctx, 0, 150);
    
    CGContextAddRect(ctx, CGRectMake(10, 10, 50, 50));
    
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
    
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 100, 100));
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 200, 250);
    
    
    // 矩阵操作
    //    CGContextScaleCTM(ctx, 0.5, 0.5);
    
    CGContextStrokePath(ctx);
}

/******************** 动画(下雪效果) *********************/

//- (void)awakeFromNib
//{
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//    
//    //    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    self.snowY+=5;
//    
//    if (self.snowY >= rect.size.height) {
//        self.snowY = -100;
//    }
//    
//    UIImage *image = [UIImage imageNamed:@"snow.jpg"];
//    [image drawAtPoint:CGPointMake(0, self.snowY)];
//}

/******************** 动画(下雪效果) *********************/


@end

//
//  Const.h
//  FKLibraryExample
//
//  Created by frank on 15-11-1.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#ifndef Const_h
#define Const_h


/**
 *  角度转弧度
 *
 *  @param Angle 角度
 *
 *  @return 弧度
 */
CGFloat AngleToRadian(CGFloat Angle) {return degree * M_PI / 180;};

/**
 *  弧度转角度
 *
 *  @param Angle 弧度
 *
 *  @return 角度
 */
CGFloat RadianToAngle(CGFloat radian) {return radian * 180/M_PI;};



#endif /* Const_h */

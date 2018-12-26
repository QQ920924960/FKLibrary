//
//  UIView+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/2.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FK)

@property (nonatomic) CGFloat fk_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat fk_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat fk_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat fk_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat fk_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat fk_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat fk_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat fk_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint fk_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  fk_size;        ///< Shortcut for frame.size.


/**
 *  设置view的圆角半径和边框宽度及颜色
 *
 *  @param cornerRadius 圆角半径
 *  @param width        边框宽度
 *  @param borderColor  边框颜色
 */
- (void)fk_viewCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;

/**
 Create a snapshot image of the complete view hierarchy.
 【截图】
 */
- (UIImage *)fk_snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 【屏幕截图,比上面的那个方法速度更快,但是有可能导致刷屏】
 */
- (UIImage *)fk_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (NSData *)fk_snapshotPDF;

/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)fk_setLayerShadow:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)fk_removeAllSubviews;

/**
 Returns the view's view controller (may be nil).
 */
@property (nonatomic, readonly) UIViewController *fk_viewController;

/**
 Returns the visible alpha on screen, taking into account superview and window.
 */
@property (nonatomic, readonly) CGFloat fk_visibleAlpha;

/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
 If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)fk_convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)fk_convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)fk_convertRect:(CGRect)rect toViewOrWindow:(UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
 If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)fk_convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view;

/**
 UIView的图层抖动动画
 */
- (void)fk_animateOfJitter;

+ (UIView *)fk_lineWithFrame:(CGRect)frame;

+ (UIView *)fk_lineWithFrame:(CGRect)frame color:(UIColor *)color;


@end

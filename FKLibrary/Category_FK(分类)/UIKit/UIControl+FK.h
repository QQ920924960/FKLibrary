//
//  UIControl+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/10.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (FK)

/**
 Removes all targets and actions for a particular event (or events)
 from an internal dispatch table.
 */
- (void)fk_removeAllTargets;

/**
 Adds or replaces a target and action for a particular event (or events)
 to an internal dispatch table.
 
 @param target         The target object—that is, the object to which the
 action message is sent. If this is nil, the responder
 chain is searched for an object willing to respond to the
 action message.
 
 @param action         A selector identifying an action message. It cannot be NULL.
 
 @param controlEvents  A bitmask specifying the control events for which the
 action message is sent.
 */
- (void)fk_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 Adds a block for a particular event (or events) to an internal dispatch table.
 It will cause a strong reference to @a block.
 
 @param block          The block which is invoked then the action message is
 sent  (cannot be nil). The block is retained.
 
 @param controlEvents  A bitmask specifying the control events for which the
 action message is sent.
 */
- (void)fk_addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 Adds or replaces a block for a particular event (or events) to an internal
 dispatch table. It will cause a strong reference to @a block.
 
 @param block          The block which is invoked then the action message is
 sent (cannot be nil). The block is retained.
 
 @param controlEvents  A bitmask specifying the control events for which the
 action message is sent.
 */
- (void)fk_setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/**
 Removes all blocks for a particular event (or events) from an internal
 dispatch table.
 
 @param controlEvents  A bitmask specifying the control events for which the
 action message is sent.
 */
- (void)fk_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;


@end

//
//  FKSingleton.h
//  FKLibraryExample
//
//  Created by frank on 15/11/6.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#ifndef FKSingleton_h
#define FKSingleton_h

/****************** 开始 ******************/
#define singleton_h(name) + (instancetype)shared##name;


#if __has_feature(objc_arc) // arc

#define singleton_m(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}


#else // 非arc

#define singleton_m(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
} \
\
- (oneway void)release \
{ \
\
} \
\
- (instancetype)autorelease \
{ \
return _instance; \
} \
\
- (instancetype)retain \
{ \
return _instance; \
} \
\
- (NSUInteger)retainCount \
{ \
return 1; \
}
#endif
/****************** 结束 ******************/


#endif /* FKSingleton_h */

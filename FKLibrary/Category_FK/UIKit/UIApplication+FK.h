//
//  UIApplication+FK.h
//  FKLibraryExample
//
//  Created by frank on 15/11/20.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (FK)

/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *fk_documentsURL;
@property (nonatomic, readonly) NSString *fk_documentsPath;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *fk_cachesURL;
@property (nonatomic, readonly) NSString *fk_cachesPath;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *fk_libraryURL;
@property (nonatomic, readonly) NSString *fk_libraryPath;

/// Application's Bundle Name (show in SpringBoard).
@property (nonatomic, readonly) NSString *fk_appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nonatomic, readonly) NSString *fk_appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nonatomic, readonly) NSString *fk_appVersion;

/// Application's Build number. e.g. "123"
@property (nonatomic, readonly) NSString *fk_appBuildVersion;

/// Whether this app is priated (not install from appstore).
@property (nonatomic, readonly) BOOL fk_isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL fk_isBeingDebugged;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t fk_memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float fk_cpuUsage;


/**
 Increments the number of active network requests.
 If this number was zero before incrementing, this will start animating the
 status bar network activity indicator.
 
 This method is thread safe.
 */
- (void)fk_incrementNetworkActivityCount;

/**
 Decrements the number of active network requests.
 If this number becomes zero after decrementing, this will stop animating the
 status bar network activity indicator.
 
 This method is thread safe.
 */
- (void)fk_decrementNetworkActivityCount;


@end

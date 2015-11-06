//
//  FKImageTools.h
//  FKLibraryExample
//
//  Created by frank on 15/11/6.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/* Number of components for an opaque grey colorSpace = 3 */
#define kFKNumberOfComponentsPerGreyPixel 3
/* Number of components for an ARGB pixel (Alpha / Red / Green / Blue) = 4 */
#define kFKNumberOfComponentsPerARBGPixel 4
/* Minimun value for a pixel component */
#define kFKMinPixelComponentValue (UInt8)0
/* Maximum value for a pixel component */
#define kFKMaxPixelComponentValue (UInt8)255

/* Convert degrees value to radians */
#define FK_DEGREES_TO_RADIANS(__DEGREES) (__DEGREES * 0.017453293) // (M_PI / 180.0f)
/* Convert radians value to degrees */
#define FK_RADIANS_TO_DEGREES(__RADIANS) (__RADIANS * 57.295779513) // (180.0f / M_PI)

/* Returns the lower value */
#define FK_MIN(__A, __B) ((__A) < (__B) ? (__A) : (__B))
/* Returns the higher value */
#define FK_MAX(__A ,__B) ((__A) > (__B) ? (__A) : (__B))
/* Returns a correct value for a pixel component (0 - 255) */
#define FK_SAFE_PIXEL_COMPONENT_VALUE(__COLOR) (FK_MIN(kFKMaxPixelComponentValue, FK_MAX(kFKMinPixelComponentValue, __COLOR)))

/* iOS version runtime check */
#define FK_IOS_VERSION_LESS_THAN(__VERSIONSTRING) ([[[UIDevice currentDevice] systemVersion] compare:__VERSIONSTRING options:NSNumericSearch] == NSOrderedAscending)

/* dispatch_release() not needed in iOS 6+ original idea from FMDB https://github.com/ccgus/fmdb/commit/aef763eeb64e6fa654e7d121f1df4c16a98d9f4f */
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
#define FK_DISPATCH_RELEASE(__QUEUE)
#else
#define FK_DISPATCH_RELEASE(__QUEUE) (dispatch_release(__QUEUE))
#endif

CGContextRef FKCreateARGBBitmapContext(const size_t width, const size_t height, const size_t bytesPerRow, BOOL withAlpha);
CGImageRef FKCreateGradientImage(const size_t pixelsWide, const size_t pixelsHigh, const CGFloat fromAlpha, const CGFloat toAlpha);
CIContext* FKGetCIContext(void);
CGColorSpaceRef FKGetRGBColorSpace(void);
void FKImagesKitRelease(void);
BOOL FKImageHasAlpha(CGImageRef imageRef);
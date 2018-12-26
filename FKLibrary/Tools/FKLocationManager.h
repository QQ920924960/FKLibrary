//
//  FKLocationManager.h
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationBlock)(CLLocationCoordinate2D locationCorrrdinate);
typedef void (^LocationErrorBlock) (NSError *error);
typedef void(^NSStringBlock)(NSString *cityString);
typedef void(^NSStringBlock)(NSString *addressString);

@interface FKLocationManager : NSObject <CLLocationManagerDelegate>

/** 一个新的CLLocationCoordinate2D在给定的纬度和经度 */
@property (nonatomic) CLLocationCoordinate2D locationCoordinate2D;

/** 完整地址 */
@property (copy, nonatomic) NSString *formattedAddressLines;

/**  国家 */
@property (copy, nonatomic) NSString *country;

/** 省份/行政区 */
@property (copy, nonatomic) NSString *state;

/** 城市 */
@property (copy, nonatomic) NSString *city;

/** 区 */
@property (copy, nonatomic) NSString *subLocality;

/** 街道+门牌号 */
@property (copy, nonatomic) NSString *street;

/** 街道 */
@property (copy, nonatomic) NSString *thoroughfare;

/** 门牌号 */
@property (copy, nonatomic) NSString *subThoroughfare;

/** 国家代码 eg:CN */
@property (copy, nonatomic) NSString *countryCode;

/** 纬度 */
@property(assign, nonatomic) CGFloat latitude;

/** 经度 */
@property(assign, nonatomic) CGFloat longitude;

//以上属性都以同名保存到缓存中
/////////

+ (instancetype)sharedLocation;

/**
 *  获取坐标
 *
 *  @param locaiontBlock locaiontBlock description
 */
- (void)getLocationCoordinate:(LocationBlock) locaiontBlock ;

/**
 *  获取坐标和详细地址
 *
 *  @param locaiontBlock locaiontBlock description
 *  @param addressBlock  addressBlock description
 */
- (void)getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock;

/**
 *  获取详细地址
 *
 *  @param addressBlock addressBlock description
 */
- (void)getAddress:(NSStringBlock)addressBlock;

/**
 *  获取城市
 *
 *  @param cityBlock cityBlock description
 */
- (void)getCity:(NSStringBlock)cityBlock;

/**
 *  开始定位
 */
- (void)startLocation;


@end

//
//  FKLocationManager.m
//  FKLibraryExample
//
//  Created by frank on 15/11/7.
//  Copyright © 2015年 zmosa. All rights reserved.
//

#import "FKLocationManager.h"
static NSString *FormattedAddressLines = @"FormattedAddressLines";
static NSString *Country = @"Country";
static NSString *State = @"State";
static NSString *City = @"City";
static NSString *SubLocality = @"SubLocality";
static NSString *Street = @"Street";
static NSString *Thoroughfare = @"Thoroughfare";
static NSString *SubThoroughfare = @"SubThoroughfare";
static NSString *CountryCode = @"CountryCode";
static NSString *Latitude = @"Latitude";
static NSString *Longitude = @"Longitude";

@interface FKLocationManager ()
{
    CLLocationManager *_manager;
}
@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) NSStringBlock cityBlock;
@property (nonatomic, strong) NSStringBlock addressBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@end

@implementation FKLocationManager

+ (instancetype)sharedLocation {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[[self class] alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
        CGFloat longitude = [standard floatForKey:Longitude];
        CGFloat latitude = [standard floatForKey:Latitude];
        self.longitude = longitude;
        self.latitude = latitude;
        self.locationCoordinate2D = CLLocationCoordinate2DMake(longitude,latitude);
        self.formattedAddressLines = [standard objectForKey:FormattedAddressLines];
        self.country = [standard objectForKey:Country];
        self.state = [standard objectForKey:State];
        self.city = [standard objectForKey:City];
        self.subLocality = [standard objectForKey:SubLocality];
        self.street = [standard objectForKey:Street];
        self.thoroughfare = [standard objectForKey:Thoroughfare];
        self.subThoroughfare = [standard objectForKey:SubThoroughfare];
        self.countryCode = [standard objectForKey:CountryCode];
    }
    return self;
}

- (void)getLocationCoordinate:(LocationBlock)locaiontBlock {
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void)getLocationCoordinate:(LocationBlock)locaiontBlock  withAddress:(NSStringBlock)addressBlock {
    self.locationBlock = [locaiontBlock copy];
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void)getAddress:(NSStringBlock)addressBlock {
    self.addressBlock = [addressBlock copy];
    [self startLocation];
}

- (void)getCity:(NSStringBlock)cityBlock {
    self.cityBlock = [cityBlock copy];
    [self startLocation];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error) {
        if (placemarks.count > 0) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            _formattedAddressLines = placemark.addressDictionary[@"FormattedAddressLines"][0];
            [userDefaults setObject:_formattedAddressLines forKey:FormattedAddressLines];
            _country = placemark.addressDictionary[@"Country"];
            [userDefaults setObject:_country forKey:Country];
            _state = placemark.addressDictionary[@"State"];
            [userDefaults setObject:_state forKey:State];
            _city = placemark.addressDictionary[@"City"];
            [userDefaults setObject:_city forKey:City];
            _subLocality = placemark.addressDictionary[@"SubLocality"];
            [userDefaults setObject:_subLocality forKey:SubLocality];
            _street = placemark.addressDictionary[@"Street"];
            [userDefaults setObject:_street forKey:Street];
            _thoroughfare = placemark.addressDictionary[@"Thoroughfare"];
            [userDefaults setObject:_thoroughfare forKey:Thoroughfare];
            _subThoroughfare = placemark.addressDictionary[@"SubThoroughfare"];
            [userDefaults setObject:_subThoroughfare forKey:SubThoroughfare];
            _countryCode = placemark.addressDictionary[@"CountryCode"];
            [userDefaults setObject:_countryCode forKey:CountryCode];
            [userDefaults synchronize];
        }
        if (_cityBlock) {
            _cityBlock(_city);
            _cityBlock = nil;
        }
        if (_addressBlock) {
            _addressBlock(_formattedAddressLines);
            _addressBlock = nil;
        }
    }];
    _locationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude ,newLocation.coordinate.longitude );
    if (_locationBlock) {
        _locationBlock(_locationCoordinate2D);
        _locationBlock = nil;
    }
    [standard setObject:@(newLocation.coordinate.latitude) forKey:Latitude];
    [standard setObject:@(newLocation.coordinate.longitude) forKey:Longitude];
    [manager stopUpdatingLocation];
    if ([standard objectForKey:Latitude] || [standard objectForKey:Longitude]) {
        NSLog(@"定位保存成功");
        //上传用户位置
    } else {
        NSLog(@"定位保存失败");
    }
}


- (void)startLocation
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        _manager=[[CLLocationManager alloc]init];
        _manager.delegate=self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
            [_manager requestAlwaysAuthorization];
        }
        _manager.distanceFilter=100;
        [_manager startUpdatingLocation];
    } else {
        UIAlertView *alvertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLocation];
}

-(void)stopLocation
{
    _manager = nil;
}


@end

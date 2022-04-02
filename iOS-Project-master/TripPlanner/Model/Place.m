//
//  Place.m
//  TripPlanner
//
//  Created by Marco on 13/06/21.
//

#import "Place.h"
#import <CoreLocation/CoreLocation.h>

@interface Place ()

-(instancetype) initWithName:(NSString *)name
                    latitude:(double)latitude
                   longitude:(double)longitude;

@end

@implementation Place

- (instancetype)initWithName:(NSString *)name {
    return [self initWithName:name
                     latitude:0.0
                    longitude:0.0];
}

- (instancetype)initWithName:(NSString *)name
                    latitude:(double)latitude
                   longitude:(double)longitude {
    if(self = [super init]) {
        _name = [name copy];
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (void) setupCoordinates {
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.name completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([obj isKindOfClass: [CLPlacemark class]]) {
                    CLPlacemark* pm = (CLPlacemark*) obj;
                    self.latitude = pm.location.coordinate.latitude;
                    self.longitude = pm.location.coordinate.longitude;
                    *stop = YES;
                }
            }];
        }];
}

- (id)copy {
    return [[Place alloc] initWithName:self.name
                              latitude:self.latitude
                             longitude:self.longitude];
}

- (BOOL)isEqual:(id)object {
    if([object isKindOfClass:[Place class]]) {
        Place* place = (Place*) object;
        if(self.latitude == place.latitude &&
           self.longitude == place.longitude) {
            return true;
        }
    }
    return false;
}

@end

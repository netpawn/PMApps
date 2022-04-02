//
//  Place+MapAnnotation.m
//  TripPlanner
//
//  Created by Marco on 13/06/21.
//

#import "Place+MapAnnotation.h"

@implementation Place (MapAnnotation)

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}

- (NSString *)title{
    return self.name;
}

- (NSString *)description {
    return [self.sequenceValue stringValue];
}

@end

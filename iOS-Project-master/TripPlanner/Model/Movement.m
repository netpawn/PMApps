//
//  Movement.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "Movement.h"

@implementation Movement

- (instancetype) initWithArrivalDate:(NSDate*) arrivalDate
                           fromPlace:(Place*) fromPlace
                             toPlace:(Place*) toPlace {
    if(self = [super init]) {
        _arrivalDate = [arrivalDate copy];
        _fromPlace = fromPlace;
        _toPlace = toPlace;
    }
    return self;
}

-(id)copy {
    return [[Movement alloc] initWithArrivalDate:self.arrivalDate
                                       fromPlace:self.fromPlace
                                         toPlace:self.toPlace];
}

@end

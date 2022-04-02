//
//  Stay.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "Stay.h"

@implementation Stay

- (instancetype) initWithPlace:(Place *)place
                   arrivalDate:(NSDate *)arrivalDate
                     leaveDate:(NSDate *)leaveDate {
    if(self = [super init]) {
        _place = place;
        _arrivalDate = [arrivalDate copy];
        _leaveDate = [leaveDate copy];
    }
    return self;
}

- (id)copy {
    return [[Stay alloc] initWithPlace:self.place
                           arrivalDate:self.arrivalDate
                             leaveDate:self.leaveDate];
}

@end

//
//  TripList.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "TripList.h"

@interface TripList ()

@property (nonatomic, strong) NSMutableArray* trips;

@end

@implementation TripList

- (instancetype) init {
    if (self = [super init]) {
        _trips = [[NSMutableArray alloc] init];
    }
    return self;
}

- (long) size {
    return self.trips.count;
}

- (NSArray*) getAll {
    return self.trips;
}

- (void)add:(Trip *)trip {
    [self.trips addObject:trip];
}

- (void)remove:(Trip *)trip {
    [self.trips removeObject:trip];
}

- (Trip *)getAtIndex:(NSInteger)index {
    return [self.trips objectAtIndex:index];
}

@end

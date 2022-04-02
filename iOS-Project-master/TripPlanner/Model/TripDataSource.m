//
//  TripDataSource.m
//  TripPlanner
//
//  Created by Marco on 28/05/21.
//

#import "TripDataSource.h"
#import "TripList.h"

NSString *const TripListChangedNotification = @"TripListChangedNotification";
NSString *const StageListChangedNotification = @"StageListChangedNotification";

@interface TripDataSource ()

@property (nonatomic, strong) TripList* trips;

@end

@implementation TripDataSource

- (instancetype) init {
    if(self = [super init]) {
        _trips = [[TripList alloc] init];
    }
    return self;
}

- (TripList *)getTripList {
    return self.trips;
}


- (void)deleteStage:(nonnull Stage *)stage
            forTrip:(nonnull Trip *)trip {
    [trip.stages remove:stage];
    [[NSNotificationCenter defaultCenter] postNotificationName:StageListChangedNotification
                                                        object:self];
}


- (void)deleteTrip:(nonnull Trip *)trip {
    [self.trips remove:trip];
    [[NSNotificationCenter defaultCenter] postNotificationName:TripListChangedNotification
                                                        object:self];
    
}


- (nonnull StageList *)getStageListForTrip:(nonnull Trip *)trip {
    return trip.stages;
}


- (void)insertStage:(nonnull Stage *)stage
            forTrip:(nonnull Trip *)trip {
    [trip.stages add:stage];
    [[NSNotificationCenter defaultCenter] postNotificationName:StageListChangedNotification
                                                        object:self];
    [stage.movement.fromPlace setupCoordinates];
    [stage.movement.toPlace setupCoordinates];
}


- (void)insertTrip:(nonnull Trip *)trip {
    [self.trips add:trip];
    [[NSNotificationCenter defaultCenter] postNotificationName:TripListChangedNotification
                                                        object:self];
}


- (void)updateStage:(Stage *)stage
       withMovement:(Movement *)movement
               stay:(Stay *)stay {
    stage.movement = movement;
    stage.stay = stay;
    [[NSNotificationCenter defaultCenter] postNotificationName:StageListChangedNotification
                                                        object:self];
    [stage.movement.fromPlace setupCoordinates];
    [stage.movement.toPlace setupCoordinates];
}


- (void) updateTrip:(Trip*)trip
           withName:(NSString *)name
        description:(NSString *)tripDescription
          startDate:(NSDate *)startDate
             endDate:(NSDate *)endDate
          stageList:(StageList *)stageList
    meanOfTransport:(NSString *)meanOfTransport
          hotelName:(NSString *)hotelName {
    trip.name = name;
    trip.tripDescription = tripDescription;
    trip.meanOfTransport = meanOfTransport;
    trip.hotelName = hotelName;
    trip.startDate = startDate;
    trip.endDate = endDate;
    [[NSNotificationCenter defaultCenter] postNotificationName:TripListChangedNotification object:self];
}

@end

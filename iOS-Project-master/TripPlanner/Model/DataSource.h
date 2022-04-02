//
//  DataSource.h
//  TripPlanner
//
//  Created by Marco on 28/05/21.
//

#import <Foundation/Foundation.h>
#import "Trip.h"
#import "TripList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DataSource <NSObject>

- (TripList*) getTripList;
- (void) insertTrip:(Trip*) trip;
- (void) updateTrip:(Trip*)trip
           withName:(NSString *)name
        description:(NSString *)tripDescription
          startDate:(NSDate *)startDate
            endDate:(NSDate *)endDate
          stageList:(StageList *)stageList
    meanOfTransport:(NSString *)meanOfTransport
          hotelName:(NSString *)hotelName;
- (void) deleteTrip:(Trip*) trip;

- (StageList*) getStageListForTrip:(Trip*) trip;
- (void) insertStage:(Stage*) stage
             forTrip:(Trip*) trip;
- (void) updateStage:(Stage*)stage
        withMovement:(Movement *)movement
                stay:(Stay *)stay;
- (void) deleteStage:(Stage*) stage
             forTrip:(Trip*) trip;

@end

NS_ASSUME_NONNULL_END

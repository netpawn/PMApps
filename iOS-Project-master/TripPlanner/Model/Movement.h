//
//  Movement.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <Foundation/Foundation.h>
#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface Movement : NSObject

- (instancetype) initWithArrivalDate:(NSDate*) arrivalDate
                                fromPlace:(Place*) fromPlace
                                  toPlace:(Place*) toPlace;


@property (nonatomic, strong) Place* fromPlace;
@property (nonatomic, strong) Place* toPlace;
@property (nonatomic, strong) NSDate* arrivalDate;

@end

NS_ASSUME_NONNULL_END

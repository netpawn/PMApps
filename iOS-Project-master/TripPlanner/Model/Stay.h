//
//  Stay.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <Foundation/Foundation.h>
#import "Place.h"

NS_ASSUME_NONNULL_BEGIN

@interface Stay : NSObject

- (instancetype) initWithPlace:(Place*) place
                   arrivalDate:(NSDate*) arrivalDate
                     leaveDate:(NSDate*) leaveDate;

@property (nonatomic, strong) Place* place;
@property (nonatomic, strong) NSDate* arrivalDate;
@property (nonatomic, strong) NSDate* leaveDate;

@end

NS_ASSUME_NONNULL_END

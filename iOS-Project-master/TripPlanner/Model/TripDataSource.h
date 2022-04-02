//
//  TripDataSource.h
//  TripPlanner
//
//  Created by Marco on 28/05/21.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const TripListChangedNotification;
extern NSString *const StageListChangedNotification;

@interface TripDataSource : NSObject<DataSource>

@end

NS_ASSUME_NONNULL_END

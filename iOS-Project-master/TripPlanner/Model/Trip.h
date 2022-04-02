//
//  Trip.h
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import <Foundation/Foundation.h>
#import "StageList.h"

NS_ASSUME_NONNULL_BEGIN

@interface Trip : NSObject

- (instancetype) initWithName:(NSString*) name
                 description:(NSString*) description
                   startDate: (NSDate*) startDate
                     endDate: (NSDate*) endDate
                   stageList: (StageList*) stageList
             meanOfTransport: (NSString*) meanOfTransport
                   hotelName: (NSString*) hotelName;

- (instancetype) initWithName:(NSString*) name
                   startDate: (NSDate*) startDate
                     endDate: (NSDate*) endDate
                   stageList: (StageList*) stageList;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* tripDescription;
@property (nonatomic, strong) NSDate* startDate;
@property (nonatomic, strong) NSDate* endDate;
@property (nonatomic, strong) StageList* stages;
@property (nonatomic, strong) NSString* meanOfTransport;
@property (nonatomic, strong) NSString* hotelName;

@end

NS_ASSUME_NONNULL_END

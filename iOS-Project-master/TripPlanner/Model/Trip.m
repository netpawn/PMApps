//
//  Trip.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "Trip.h"

@implementation Trip

-(instancetype) init {
    return [self initWithName:@""
                     startDate:[[NSDate alloc] init]
                       endDate:[[NSDate alloc] init]
                     stageList:[[StageList alloc] init]
            ];
}

- (instancetype) initWithName:(NSString *)name
                 description:(NSString *)description
                   startDate:(NSDate *)startDate
                     endDate:(NSDate *)endDate
                   stageList:(StageList *)stageList
             meanOfTransport:(NSString *)meanOfTransport
                   hotelName:(NSString *)hotelName {
    if(self = [super init]) {
        _name = [name copy];
        _tripDescription = [description copy];
        _startDate = [startDate copy];
        _endDate = [endDate copy];
        _stages = [stageList copy];
        _meanOfTransport = [meanOfTransport copy];
        _hotelName = [hotelName copy];
    }
    return self;
}

- (instancetype) initWithName:(NSString *)name
                    startDate:(NSDate *)startDate
                      endDate:(NSDate *)endDate
                    stageList:(StageList *)stageList {
    return [self initWithName:name
                  description:@""
                    startDate:startDate
                      endDate:endDate
                    stageList:stageList
              meanOfTransport:@""
                    hotelName:@""];
}

@end

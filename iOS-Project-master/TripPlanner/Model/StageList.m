//
//  StageList.m
//  TripPlanner
//
//  Created by Marco on 23/05/21.
//

#import "StageList.h"
#import "TripDataSource.h"

@interface StageList ()

@property (nonatomic, strong) NSMutableArray* stages;

- (void)sort;

@end

@implementation StageList

- (instancetype) init {
    if(self = [super init]) {
        _stages = [[NSMutableArray alloc] init];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sort)
                                                 name:StageListChangedNotification object:nil]; // sort also when one single element changes
    return self;
}

- (long) size {
    return self.stages.count;
}

- (NSArray*) getAll {
    return self.stages;
}

- (void)add:(Stage *)stage {
    [self.stages addObject:stage];
    [self sort];
}

- (void)remove:(Stage *)stage {
    [self.stages removeObject:stage];
}

- (Stage *)getAtIndex:(NSInteger)index {
    return [self.stages objectAtIndex:index];
}

- (void)sort {
    [self.stages sortUsingComparator:^NSComparisonResult(Stage*  _Nonnull stage1, Stage*  _Nonnull stage2) {
        return [stage1.movement.arrivalDate compare:stage2.movement.arrivalDate];
    }];
}

- (id)copy {
    StageList* copy = [[StageList alloc] init];
    copy.stages = [self.stages mutableCopy];
    return copy;
}

- (NSArray*) getPlacesInOrder {
    NSMutableArray* places = [[NSMutableArray alloc] init];
    for(int i=0; i<self.stages.count; ++i) {
        id obj = self.stages[i];
        if([obj isKindOfClass:[Stage class]]) {
            Stage* stage = (Stage*) obj;
            if(i==0) {
                [places addObject:stage.movement.fromPlace];
                [places addObject:stage.movement.toPlace];
            } else {
                NSObject* previousObj = self.stages[i-1];
                if([previousObj isKindOfClass:[Stage class]]) {
                    Stage* previousStage = (Stage*) previousObj;
                    if(![previousStage.movement.toPlace isEqual:stage.movement.fromPlace]) {
                        [places addObject:stage.movement.fromPlace];
                    }
                }
                [places addObject:stage.movement.toPlace];
            }
        }
    }
    return places;
}

@end

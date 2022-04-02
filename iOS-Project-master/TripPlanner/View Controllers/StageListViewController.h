//
//  StageListViewController.h
//  TripPlanner
//
//  Created by Marco on 09/06/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "TripDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface StageListViewController : UITableViewController

@property (strong, nonatomic) TripDataSource* dataSource;
@property (strong, nonatomic, nullable) Trip* trip;

@end

NS_ASSUME_NONNULL_END

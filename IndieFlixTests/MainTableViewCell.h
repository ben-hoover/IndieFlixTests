//
//  MainTableViewCell.h
//  IndieFlixTests
//
//  Created by Benjamin Hoover on 6/30/16.
//  Copyright © 2016 Benjamin Hoover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end

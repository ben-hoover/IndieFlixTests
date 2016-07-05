//
//  MainCollectionViewCell.h
//  IndieFlixTests
//
//  Created by Benjamin Hoover on 6/30/16.
//  Copyright © 2016 Benjamin Hoover. All rights reserved.
//


#import <UIKit/UIKit.h>
//create a cell delegate
@protocol MainCollectionViewCellDelegate <NSObject>
@required
//only the cell itself knows when its highlighted
//delegate method to tell table view controller that cell was highlighted, and provide its index path
-(void)didHighlightWithIndexPath:(NSIndexPath *)indexPath;

@end
@interface MainCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIColor *oldColor;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property id<MainCollectionViewCellDelegate> delegate;
@end

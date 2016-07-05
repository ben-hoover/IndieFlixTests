//
//  MainCollectionViewCell.m
//  IndieFlixTests
//
//  Created by Benjamin Hoover on 6/30/16.
//  Copyright © 2016 Benjamin Hoover. All rights reserved.
// 

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell
- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    [self.delegate didHighlightWithIndexPath:self.indexPath];

}
@end

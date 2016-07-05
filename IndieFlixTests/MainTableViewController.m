//
//  MainTableViewController.m
//  IndieFlixTests
//
//  Created by Benjamin Hoover on 6/30/16.
//  Copyright © 2016 Benjamin Hoover. All rights reserved.
//

#import "MainTableViewController.h"
#import "MainTableViewCell.h"
#import "MainCollectionViewCell.h"
@interface MainTableViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MainCollectionViewCellDelegate>
@property (nonatomic, strong) NSIndexPath *highlightedCell;
@end

@implementation MainTableViewController


//basic layout - UITableView. Each seciton has 1 "row" in the table containing 1 cell
// inside the cell there is a collection view

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //only 1 row per section
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != self.highlightedCell.section) {
        return 200;
    } else {
        return 399;
    }
    
    
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.collectionView.delegate = self;
    cell.collectionView.dataSource = self;
    cell.collectionView.tag = indexPath.section;
    
    cell.indexPath = indexPath;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Reccomended For You";
            break;
        case 1:
            return @"New Releases";
            break;
        default:
            return @"Action";
            break;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionView *)getCollectionViewInSection:(NSInteger)section {
    MainTableViewCell *tableCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    UICollectionView *colView = tableCell.collectionView;
    return colView;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   //the index path's "section" is refering to the section in the collection view, which is 0
    //but we want the section in the table view
    //this is stored as the collectionView's tag
    
  //  MainTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:collectionView.tag]];
    MainCollectionViewCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"thecell" forIndexPath:indexPath];

    if (collectionView.tag == 0) {
        colCell.backgroundColor = [UIColor redColor];
    } else if (collectionView.tag == 1) {
        colCell.backgroundColor = [UIColor greenColor];
    } else {
        colCell.backgroundColor = [UIColor blueColor];
    }
    colCell.indexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:collectionView.tag];
  
    //set the view contorller as cell's delegate so it can be notified when a cell is highlighted
    colCell.delegate = self;
    return colCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //the index path's "section" is refering to the section in the collection view, which is 0
    //but we want the section in the table view
    //this is stored as the collectionView's tag
    
    NSIndexPath *actualIndexPath = [NSIndexPath indexPathForItem:indexPath.row inSection:collectionView.tag];
    
    //check if cell is highlighted, and set size accordingly
    if ([actualIndexPath isEqual:self.highlightedCell]) {
        return CGSizeMake(686, 392);
    } else {
           return CGSizeMake(350, 200);
    }
 
}
- (void)didHighlightWithIndexPath:(NSIndexPath *)indexPath {
   
    self.highlightedCell = indexPath;
    
    
    //reload table and colleciton view
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    [self refreshAllCollectionViews];
    
   
    
   
    
}


- (void)refreshAllCollectionViews {
    for (int i = 0; i < [self.tableView numberOfSections]; i++) {
        //loop through table view section
        //get the cell in each section, get its table view, update its layout
       [[self getCollectionViewInSection:i].collectionViewLayout invalidateLayout];
    }
     [super viewDidLayoutSubviews];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

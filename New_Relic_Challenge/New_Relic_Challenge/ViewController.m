//
//  ViewController.m
//  New_Relic_Challenge
//
//  Created by Enders, Eric on 10/6/17.
//  Copyright © 2017 Enders, Eric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize textField,list1LabelCount,list2LabelCount,removeButton,replaceButton,addAfterButton,addBeforeButton,mergeLength;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Allocate and initialize the NSMutableArray
    self.nr_mut_array_list1 = [[[NSMutableArray alloc] init]autorelease]; //auto release since ARC is turned off
    self.nr_mut_array_list2 = [[[NSMutableArray alloc] init]autorelease];
    mergeLength = 0;
    [self refreshArray];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void) refreshArray {
    [self.nr_mut_array_list1 removeAllObjects];
    mergeLength = 0;
    
    //Initial Data for the first list
    [self.nr_mut_array_list1 addObject:@"Eric Enders"];
    [self.nr_mut_array_list1 addObject:@"is"];
    [self.nr_mut_array_list1 addObject:@"perfect"];
    [self.nr_mut_array_list1 addObject:@"for"];
    [self.nr_mut_array_list1 addObject:@"this"];
    [self.nr_mut_array_list1 addObject:@"role"];
    
    [self.nr_mut_array_list2 removeAllObjects];
    //Update Count method to update the label with the list count
    [self updateCount];
}
- (void) updateTables {
    //this function gets called after the list is altered
    [tableView1 reloadData];
    [tableView2 reloadData];
}
- (void) updateCount {
    //set the labels with the items count
    //this function is called after the list is altered needing the text field to be cleared, table to be updated, and disable any buttons that require a row to be selected
    list1LabelCount.text = [NSString stringWithFormat:@"Items(%lu)",(unsigned long)[self.nr_mut_array_list1 count]];
    list2LabelCount.text = [NSString stringWithFormat:@"Items(%lu)",(unsigned long)[self.nr_mut_array_list2 count]];
    [textField setText:@""];
    [self updateTables];
    [self disableButtons];
    
}
- (void) disableButtons {
    //a row must be selected in order for these 4 buttons to be enabled.  this function is called after the list is updated and the buttons need to become disabled
    [addBeforeButton setEnabled:false];
    [addAfterButton setEnabled:false];
    [replaceButton setEnabled:false];
    [removeButton setEnabled:false];
}
#pragma Table Methods
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tableView1){
        return [self.nr_mut_array_list1 count];
    }
    else if(tableView == tableView2){
        return [self.nr_mut_array_list2 count];
    }
    else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //enable these buttons when a row is selected
    [addBeforeButton setEnabled:true];
    [addAfterButton setEnabled:true];
    [replaceButton setEnabled:true];
    [removeButton setEnabled:true];
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //when a row is selected again, that will deselect the row and we need the buttons disabled
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isSelected]) {
        [tableView deselectRowAtIndexPath:indexPath animated:true];
        [self disableButtons];
        return nil;
    }
    
    return indexPath;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];//initWithFrame:CGRectZero
        
    }
    if(tableView == tableView1){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.nr_mut_array_list1 objectAtIndex:indexPath.row]];
        
    }
    else if(tableView == tableView2){
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.nr_mut_array_list2 objectAtIndex:indexPath.row]];
        
    }
    return cell;
}

#pragma User Actions
- (IBAction)addToList {
    @synchronized(self){
        [self.nr_mut_array_list1 addObject:[textField text]];
        [self updateCount];
    }
}
- (IBAction)clearList {
    @synchronized(self){
        [self refreshArray];
        [self updateCount];
    }
}
- (IBAction)removeRow {
    @synchronized(self){
        NSIndexPath *selectedIndexPath = [tableView1 indexPathForSelectedRow];
        [self.nr_mut_array_list1 removeObjectAtIndex:selectedIndexPath.row];
        [self updateCount];
        [tableView1 reloadData];
    }
}
- (IBAction)replaceRow {
    @synchronized(self){
        NSIndexPath *selectedIndexPath = [tableView1 indexPathForSelectedRow];
        [self.nr_mut_array_list1 setObject:textField.text atIndexedSubscript:selectedIndexPath.row];
        [self updateCount];
        [tableView1 reloadData];
    }
}
- (IBAction)addAfter {
    @synchronized(self){
        NSIndexPath *selectedIndexPath = [tableView1 indexPathForSelectedRow];
        [self.nr_mut_array_list1 insertObject:textField.text atIndex:selectedIndexPath.row+1];//add one to index to add after
        [self updateCount];
        [tableView1 reloadData];
    }
}
- (IBAction)addBefore {
    @synchronized(self){
        NSIndexPath *selectedIndexPath = [tableView1 indexPathForSelectedRow];
        [self.nr_mut_array_list1 insertObject:textField.text atIndex:selectedIndexPath.row];//no need to change index path as this will inser and move the chain behind this indexpath
        [self updateCount];
        [tableView1 reloadData];
    }
}
- (IBAction) sortArray {
    @synchronized(self){
        [self.nr_mut_array_list1 sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        [tableView1 reloadData];
    }
}
- (IBAction) shuffleArray {
    @synchronized(self){
        NSUInteger count = [self.nr_mut_array_list1 count]; //get list count
        if (count <= 1) return; // no point in proceeding if list is empty
        for (NSUInteger i = 0; i < count - 1; ++i) { //loop through randomizing the array but moving the indexes around
            NSInteger remainingCount = count - i;
            NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
            [self.nr_mut_array_list1 exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
        }
        [tableView1 reloadData];
    }
}
- (IBAction) mergeLists {
    //add objects from list one to list 2
    //remove all of the objects from list 1
    //sort list 2
    //updateCount will update the labels for the count and also updates the tables by reloading the data
    @synchronized(self){
        [self.nr_mut_array_list2 addObjectsFromArray:self.nr_mut_array_list1];
        [self.nr_mut_array_list1 removeAllObjects];
        [self.nr_mut_array_list2 sortUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
            return [str1 compare:str2 options:(NSNumericSearch)];
        }];
        [self updateCount];
    }
}

#pragma Merge Sort Functionality
- (IBAction) mergeSort {
    
    @synchronized(self){
        
        NSMutableArray *mergeArray = [[[NSMutableArray alloc]init]autorelease]; //allocate memory to array
        //add 100 everytime the merge sort button is selected
        mergeLength += 100;
        
        for(int i = (int)[self.nr_mut_array_list2 count]; i < mergeLength; i++) {
            [mergeArray addObject:[NSString stringWithFormat:@"%lu",(unsigned long)i]];//using string format for easability for sorting since the list can contain strings and numbers
        }
        
        
        //sort this array randomly
        NSUInteger count = [mergeArray count];//[self.nr_mut_array_list2 count]; //get list count
        if (count <= 1) return; // no point in proceeding if list is empty
        for (NSUInteger i = 0; i < count - 1; ++i) { //loop through randomizing the array but moving the indexes around
            NSInteger remainingCount = count - i;
            NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
            [mergeArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
        }
        [self.nr_mut_array_list2 addObjectsFromArray:[self mergeSortBreakdown:mergeArray]];//calls the arrayMergeSort
        [self updateCount];
    }
}

- (NSArray *) merge:(NSArray *)arrayLeft :(NSArray *)arrayRight{
    //this array takes the arrays from mergeSort and loops through and puts in numerical order.
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    int i = 0, j = 0;
    
    while (i < arrayLeft.count && j < arrayRight.count)
        [resultArray addObject:([arrayLeft[i] intValue] < [arrayRight[j] intValue]) ? arrayLeft[i++] : arrayRight[j++]];
    
    while (i < arrayLeft.count)
        [resultArray addObject:arrayLeft[i++]];
    
    while (j < arrayRight.count)
        [resultArray addObject:arrayRight[j++]];
    
    return resultArray;
}

- (NSArray *) mergeSortBreakdown:(NSArray *)targetArray{
    //this function takes the array and splits it in half until they are broken down to just one row which then calls the merge function passing both array
    if (targetArray.count < 2)
        return targetArray;
    
    long midIndex = targetArray.count/2;
    
    NSArray *arrayLeft = [targetArray subarrayWithRange:NSMakeRange(0, midIndex)];
    
    NSArray *arrayRight= [targetArray subarrayWithRange:NSMakeRange(midIndex, targetArray.count - midIndex)];
    
    return [self merge: [self mergeSortBreakdown:arrayLeft] : [self mergeSortBreakdown:arrayRight]];
    
}
@end

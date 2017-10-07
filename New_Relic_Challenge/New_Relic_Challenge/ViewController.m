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
@synthesize textField,labelCount;
- (void)viewDidLoad {
    [super viewDidLoad];
    //textView.editable = NO;
    [self refreshArray];
 //   [self addToView];
   tableView.delegate = self;
   tableView.dataSource = self;
  
    }

- (void) addToView {
    @synchronized(self){
        NSMutableString *string = [NSMutableString string];
        for( NSObject *myObject in self.nr_mut_array) {
            [string appendString:[NSString stringWithFormat:@"%@\n", myObject]];
        }
       // tableView = string;
        labelCount.text = [NSString stringWithFormat:@"Items(%lu)",(unsigned long)[self.nr_mut_array count]];
        [tableView reloadData];
}
}
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{return [self.nr_mut_array count];}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];//initWithFrame:CGRectZero
                 
    }
    
   cell.textLabel.text = [self.nr_mut_array objectAtIndex:indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addToList {
    [self.nr_mut_array addObject:[textField text]];
    [self addToView];
  //  NSLog(@"%@",textField);
}
- (IBAction)clearList {
    [self refreshArray];
    [self addToView];
}
- (IBAction)removeRow {
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    [self.nr_mut_array removeObjectAtIndex:selectedIndexPath.row];
    [self addToView];
    [tableView reloadData];
}
- (IBAction)replaceRow {
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    [self.nr_mut_array setObject:textField.text atIndexedSubscript:selectedIndexPath.row];//removeObjectAtIndex:selectedIndexPath.row];
    [self addToView];
    [tableView reloadData];
}
- (IBAction)addAfter {
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    [self.nr_mut_array insertObject:textField.text atIndex:selectedIndexPath.row+1];
 //   [self.nr_mut_array setObject:textField.text atIndexedSubscript:selectedIndexPath.row+1];//removeObjectAtIndex:selectedIndexPath.row];
    [self addToView];
    [tableView reloadData];
}
- (IBAction)addBefore {
    NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    [self.nr_mut_array insertObject:textField.text atIndex:selectedIndexPath.row];
    //   [self.nr_mut_array setObject:textField.text atIndexedSubscript:selectedIndexPath.row+1];//removeObjectAtIndex:selectedIndexPath.row];
    [self addToView];
    [tableView reloadData];
}
- (void) refreshArray {
    self.nr_mut_array = [[[NSMutableArray alloc] init]autorelease]; //auto release since ARC is turned off
    [self.nr_mut_array addObject:@"Eric Enders"];
     [self.nr_mut_array addObject:@"is"];
     [self.nr_mut_array addObject:@"perfect"];
     [self.nr_mut_array addObject:@"for"];
     [self.nr_mut_array addObject:@"this"];
     [self.nr_mut_array addObject:@"role"];
}
- (IBAction) shuffleArray {
    
        NSUInteger count = [self.nr_mut_array count];
        if (count <= 1) return;
        for (NSUInteger i = 0; i < count - 1; ++i) {
            NSInteger remainingCount = count - i;
            NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
            [self.nr_mut_array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
        }
    [tableView reloadData];
}


@end

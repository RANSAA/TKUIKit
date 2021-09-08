//
//  TableViewController.m
//  TKUIKitDemo
//
//  Created by PC on 2020/12/31.
//  Copyright © 2020 芮淼一线. All rights reserved.
//

#import "TableViewController.h"
#import "SilderViewController.h"
#import "AlertTableViewController.h"




@interface TableViewController ()
@property(nonatomic, strong) NSMutableArray *dataVC;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = UIColor.blackColor;

    [self initDataVC];
    
    [self initTableView];
}

- (void)initDataVC
{
    self.dataVC = @[].mutableCopy;
    [self.dataVC addObject:[SilderViewController createVC]];
    [self.dataVC addObject:[AlertTableViewController createVC]];
    
}

- (void)initTableView
{
    self.tableView.rowHeight = 45;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataVC.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UIViewController *vc = self.dataVC[row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",vc.class];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UIViewController *vc = self.dataVC[row];
//    vc = [SilderViewController createVC];
//    [self presentViewController:vc animated:YES completion:nil];
    
    vc.restorationIdentifier = @"VC-A";
    [self pushViewController:vc animated:YES];
    
//    [self addChildViewController:vc];
//    [self.view addSubview:vc.view];
//    vc.view.frame = self.view.bounds;
    
//    
//    NSLog(@"[UIApplication sharedApplication].keyWindow.rootViewController");
//      NSLog(@"rootViewController name:%@",[UIApplication sharedApplication].keyWindow.rootViewController);
//         [TKPermissionCamera authWithAlert:YES completion:^(BOOL isAuth) {
//             if (isAuth) {
//             }
//         }];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

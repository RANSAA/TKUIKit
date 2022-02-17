//
//  AlertTableViewController.m
//  TKUIKitDemo
//
//  Created by PC on 2021/8/28.
//  Copyright © 2021 芮淼一线. All rights reserved.
//

#import "AlertTableViewController.h"
#import "TKAlertController.h"
#import "TKSystemPhotoPicker.h"
#import "TKSimplePickerView.h"
#import "TKDatePickerView.h"
#import "TKAlertView.h"
#import "PHPickerVC.h"



@interface AlertTableViewController ()
@property (nonatomic, strong) NSArray *dataAry;
@property(nonatomic, strong) TKSystemPhotoPicker *picker1;

@end



@implementation AlertTableViewController


+ (instancetype)createVC
{
    Class class = self.class;
    id obj = [[class alloc] init];
    UIViewController *vc = (UIViewController *)obj;
    vc.modalPresentationStyle = 0;
    return obj;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *bgColor = [UIColor colorWithLight:UIColor.whiteColor dark:UIColor.blackColor];
    self.view.backgroundColor = bgColor;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
}

- (NSArray *)dataAry
{
    if (!_dataAry) {
        _dataAry = @[@"自定义Alert 1",
                     @"自定义Alert 2",
                     @"System Alert 1",
                     @"System Alert 2",
                     @"TKMBProgressHUD 1",
                     @"TKMBProgressHUD 2",
                     @"presentViewController B",
                     @"presentViewController C",
                     @"自定义图片选择器",
                     @"自定义视频选择器",
                     @"SimplePicker",
                     @"DatePicker",
                     @"PHPickerVC"
        ];
    }
    return _dataAry;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    cell.textLabel.text = self.dataAry[indexPath.row];



    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    switch (row) {
        case 0:
        {
            TKAlertView *alert = [TKAlertView TKAlertViewWithTitle:@"Title" text:@"TKAlertViewWithTitle"];
            alert.blockDone = ^{
               NSLog(@"done..");
            };
            alert.blockCancel = ^{
               NSLog(@"cacnel...");
            };
            [alert.btnDone setTitleText:@"缺点"];
        }
            break;
        case 1:
        {
            TKAlertView *alert = [TKAlertView TKAlertViewDialogWithTitle:nil text:@"Msg"];
            alert.blockDone = ^{
               NSLog(@"done..");
            };
            alert.blockCancel = ^{
               NSLog(@"cacnel...");
            };
        }
            break;
        case 2:{
            TKAlertController *alert = [TKAlertController TKAlertViewShow:self.view Title:@"Title" text:@"Msg"];
            alert.blockDone = ^(id value) {
                UIAlertAction *action = (UIAlertAction *)value;
                NSLog(@"index:%ld  class:%@",action.tag,action);
            };
        }

            break;
        case 3:{
            TKAlertController *alert = [TKAlertController TKAlertViewDialogShow:self.view Title:@"Title" text:@"Msg"];
            alert.blockDone = ^(id value) {
                UIAlertAction *action = (UIAlertAction *)value;
                NSLog(@"index:%ld  class:%@",action.tag,action);
            };
        }

            break;
        case 4:{
            [TKMBProgressHUD showLoaddingInView:self.view after:1];
        }

            break;
        case 5:{
            [TKMBProgressHUD showText:@"titiel" inView:self.view];
        }

            break;
        case 6:{
            AlertTableViewController *vc = [AlertTableViewController createVC];
            vc.restorationIdentifier = @"VC-B";
            vc.view.backgroundColor = UIColor.grayColor;
            [self presentViewController:vc animated:YES completion:nil];
        }

            break;
        case 7:{
            AlertTableViewController *vc = [AlertTableViewController createVC];
            vc.restorationIdentifier = @"VC-C";
            vc.view.backgroundColor = UIColor.grayColor;
            [self presentViewController:vc animated:YES completion:nil];
        }

            break;
        case 8:{
            self.picker1 = [TKSystemPhotoPicker showPhotoWithController:self isShear:NO];
//            self.picker1.isSaveAlbum = YES;
            self.picker1.allowsEditing = YES;
            self.picker1.blockImageDone = ^(id value) {
                NSLog(@"resultImage:%@",value);
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(150, 20, 100, 200)];
                    image.contentMode = UIViewContentModeScaleAspectFit;
                    image.image = value;
                    [weakSelf.view addSubview:image];
                });
            };
        }

            break;
        case 9:{
            self.picker1 = [TKSystemPhotoPicker showVideoWithController:self isShear:NO];
//            self.picker1.isSaveAlbum = YES;
            self.picker1.allowsEditing = YES;
            self.picker1.blockVideoDone = ^(id value) {
                NSLog(@"resultImage:%@",value);
            };
        }

            break;
        case 10:{
            TKSimplePickerView *picker = [[TKSimplePickerView alloc] init];
            picker.defaultIndex = 4;
            picker.dataAry = @[@"1111",@"22222",@"33333",@"444444",@"555555"];
            picker.labTitle.text = @"Title";
//            picker.defaultIndex = 4;
            [picker show];
        }

            break;
        case 11:{
            TKDatePickerView *picker = [TKDatePickerView new];
//            picker.labTitle.text = @"Title";
            [picker show];
        }

            break;

        case 12:{
            PHPickerVC *vc = [PHPickerVC createVC];
            [self presentViewController:vc animated:YES completion:nil];
        }

        default:
            break;
    }
}















/*

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

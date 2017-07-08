//
//  HZTabBarController.m
//  CPetro
//
//  Created by ggx on 2017/3/8.
//  Copyright © 2017年 高广校. All rights reserved.
//

#import "HZTabBarController.h"

#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "UserCenterViewController.h"
@interface HZTabBarController ()

@end

@implementation HZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    HomeViewController *homeOrder = CreateViewController(@"HomeViewController");
    HJNavgationViewController *homeOrderNavC = [[HJNavgationViewController alloc] initWithRootViewController:homeOrder];
    homeOrderNavC.tabBarItem.image = [[UIImage imageNamed:@"tabbarHome"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeOrderNavC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarHomeSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    homeOrderNavC.title = @"首页";
    
    ActivityViewController *activityVc  =CreateViewController(@"ActivityViewController");
    HJNavgationViewController *activityVcNavC = [[HJNavgationViewController alloc] initWithRootViewController:activityVc];
    activityVc.tabBarItem.image = [[UIImage imageNamed:@"tabbarActivity"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    activityVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarActivitySelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    activityVc.title = @"活动";
    
    UserCenterViewController *profileVC = CreateViewController(@"UserCenterViewController");
    HJNavgationViewController *profileNavC = [[HJNavgationViewController alloc] initWithRootViewController:profileVC];
    profileNavC.tabBarItem.image = [[UIImage imageNamed:@"tabbarMyAccount"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileNavC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbarMyAccountSelect"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //    profileNavC.tabBarItem.title = @"我的账户";
    
    //    self.delegate = self;
    //    self.tabBar.tintColor = [UIColor yellowColor];
    
    //    self.tabBar.backgroundColor = K_TabarBackColor;
    
    self.tabBar.barTintColor  = K_TabarBackColor;
    self.tabBar.tintColor = K_RGBColor(254, 195, 46);
    self.viewControllers = @[homeOrderNavC,activityVcNavC,profileNavC];
    for (int i=0; i<3; i++) {
        
        UITabBarItem *item = self.tabBar.items[i];
        
        
        item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

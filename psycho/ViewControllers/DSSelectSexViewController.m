//
//  DSSelectSexViewController.m
//  psycho
//
//  Created by Dima on 20.02.15.
//  Copyright (c) 2015 bestappstudio. All rights reserved.
//

#import "DSSelectSexViewController.h"

@interface DSSelectSexViewController ()

@end

@implementation DSSelectSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    self.navigationController.navigationBar.topItem.title = @"";
    [self.navigationController.topViewController setTitle: @"info"];
//setTitle:@"Tecт1"
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)maleAction:(id)sender {
    
}
- (IBAction)femaleAction:(id)sender {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
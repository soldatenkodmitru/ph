//
//  DSResultTestViewController.m
//  psycho
//
//  Created by Dima on 20.02.15.
//  Copyright (c) 2015 bestappstudio. All rights reserved.
//

#import "DSResultTestViewController.h"
#import "DSShareViewController.h"
#import "DSTestManager.h"
#import "UIView+Shake.h"
#import "AppDelegate.h"

@interface DSResultTestViewController ()

@end

@implementation DSResultTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.appLikeControl.likeControlStyle = FBLikeControlStyleButton;
    self.appLikeControl.objectID = @"https://www.facebook.com/pages/Top50Ringtones/431758676974661";
    
    
    [self getText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backAction:(id)sender{
    if ([[DSTestManager sharedManager] backResult])
        [self getText];
    
}
- (IBAction)forwardAction:(id)sender{
    if ([[DSTestManager sharedManager] nextResult])
        [self getText];
    
}
- (IBAction)shareAction:(id)sender{
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityView.center=self.view.center;
    
    [activityView startAnimating];
    
    [self.view addSubview:activityView];
    dispatch_queue_t queue = dispatch_queue_create("openActivityIndicatorQueue", NULL);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DSShareViewController *shareViewController = [sb instantiateViewControllerWithIdentifier:@"share"];

    shareViewController.view.frame = CGRectMake(0, 0,600, 500);
    [shareViewController viewDidLoad];
    
    UIGraphicsBeginImageContext(shareViewController.view.frame.size);
    [[shareViewController.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    // send initialization of UIActivityViewController in background
    dispatch_async(queue, ^{
        
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                            initWithActivityItems:@[[NSString stringWithFormat:@"Личный психолог! itunes.apple.com/ru/artist/bestapp-studio-ltd./id739061892?l=ru"],screenshot] applicationActivities:nil];
        activityViewController.excludedActivityTypes=@[UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityView removeFromSuperview];
             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            //if iPhone
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                [self presentViewController:activityViewController animated:YES completion:nil];
            }
            //if iPad
            else
            {
                // Change Rect to position Popover
                UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
                NSLog(@"%f",self.view.frame.size.width/2);
                [popup presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/4, 0, 0)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            
        });
    });

    
    
}

-(void) getText{
    
    self.labelTitle.text = [[DSTestManager sharedManager] getName];
    self.smallText.text = [[DSTestManager sharedManager] getDecsription];
    self.bigText.text = [[DSTestManager sharedManager] getResult];
    [self.labelTitle shake:2 withDelta:8  andSpeed:0.1 ];
    [self.smallText shake:2 withDelta:8  andSpeed:0.1 ];
    [self.bigText shake:2 withDelta:8  andSpeed:0.1 ];
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

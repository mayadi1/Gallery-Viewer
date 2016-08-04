//
//  ImageInfoViewController.m
//  GalleryViewer
//
//  Created by Mohamed Ayadi on 8/4/16.
//
//

#import "ImageInfoViewController.h"
#import "SVProgressHUD.h"

@interface ImageInfoViewController ()

@end

@implementation ImageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.layer.frame.size.width, self.view.layer.frame.size.height)];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.selectedImage]];
        if ( data == nil ){
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            imgView.image =  [UIImage imageWithData: data];
            imgView.contentMode = UIViewContentModeCenter;
            [self.view addSubview: imgView];
            [SVProgressHUD dismiss];

            
        });
    });

    
    
    
    
}


@end

//
//  GalleryViewController.m
//  GalleryViewer
//
//  Created by Mohamed Ayadi on 8/4/16.
//
//

#import "GalleryViewController.h"
#import "Images.h"
#import "IKGCollectionViewCell.h"
#import "ImageInfoViewController.h"
#import "SVProgressHUD.h"

@interface GalleryViewController ()

@property NSMutableArray *imagesArray;
@property NSString *urlForImageSize2;
@property NSString *urlForImageSize20;
@property NSDictionary *imageSize2Info;
@property NSDictionary *imageSize20Info;
@end

@implementation GalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];

    
    // Configure self
    self.title = @"Gallery";
    
    
    self.imagesArray = [NSMutableArray new];
    
    UICollectionViewFlowLayout *vfl = [[UICollectionViewFlowLayout alloc]init];
    
    vfl.itemSize = CGSizeMake(145, 145);
    vfl.minimumInteritemSpacing = 10;
    vfl.minimumLineSpacing = 10;
    vfl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *cv = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:vfl];
    
    cv.delegate = self;
    cv.dataSource = self;
    
    
    [cv registerClass:[IKGCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [self.view addSubview:cv];
    
    
    
    //Connecting with 500px API
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.500px.com/v1/photos?feature=popular&sort=rating&image_size=2,20&include_store=store_download&include_states=voted&consumer_key=UU6XQeziu01adhSANZo3J5gDsZD6gaFyJXomYlhz"]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *jsonArray = [dict objectForKey:@"photos"];
        
        
        
        for(int i=0;i<jsonArray.count;i++){
            
            NSMutableArray *tempImages = [jsonArray[i] objectForKey:@"images"];
            
            self.imageSize2Info = tempImages[0];
            self.imageSize20Info = tempImages[1];
            
            self.urlForImageSize2 = [self.imageSize2Info objectForKey:@"url"];
            self.urlForImageSize20 = [self.imageSize20Info objectForKey:@"url"];

            Images *newInstanceOfImagesClass  = [[Images alloc] init];
            
            newInstanceOfImagesClass.imageSize2 = self.urlForImageSize2;
            newInstanceOfImagesClass.imageSize20 = self.urlForImageSize20;

            [self.imagesArray addObject:newInstanceOfImagesClass];
            
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [cv reloadData];
        });
        
    }];
    [task resume];

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    IKGCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    

    Images *tempImage = self.imagesArray[indexPath.row];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: tempImage.imageSize2]];
        if ( data == nil ){
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData: data];
            [SVProgressHUD dismiss];

        });
    });
    
    
    
   
    
    return cell;}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imagesArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/2 - 20, 200);
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [SVProgressHUD show];

    Images *tempImage = self.imagesArray[indexPath.row];
    
    ImageInfoViewController *vc = [ImageInfoViewController new];
    
    vc.selectedImage = tempImage.imageSize20;
    
    [self.navigationController pushViewController:vc animated:true];
}

@end

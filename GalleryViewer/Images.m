//
//  Images.m
//  GalleryViewer
//
//  Created by Mohamed Ayadi on 8/4/16.
//
//

#import "Images.h"

@implementation Images

-(instancetype)initWithImage:(NSString *)size2 and:(NSString *)size20{
    
    self = [super init];
    
    if(self){
        
        self.imageSize2 = size2;
        self.imageSize20 = size20;
    }
    
    return self;
}
@end

//
//  Images.h
//  GalleryViewer
//
//  Created by Mohamed Ayadi on 8/4/16.
//
//

#import <Foundation/Foundation.h>

@interface Images : NSObject

@property NSString *imageSize2;
@property NSString *imageSize20;

-(instancetype)initWithImage:(NSString *)size2 and:(NSString *)size20;

@end

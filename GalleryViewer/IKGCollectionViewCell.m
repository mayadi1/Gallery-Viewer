//
//  IKGCollectionViewCell.m
//  GalleryViewer
//
//  Created by Mohamed Ayadi on 8/4/16.
//
//

#import "IKGCollectionViewCell.h"

@implementation IKGCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
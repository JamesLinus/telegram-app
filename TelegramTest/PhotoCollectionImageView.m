//
//  PhotoCollectionImageView.m
//  Telegram
//
//  Created by keepcoder on 05.11.14.
//  Copyright (c) 2014 keepcoder. All rights reserved.
//

#import "PhotoCollectionImageView.h"
#import "TMMediaController.h"
#import "TGPhotoViewer.h"
@implementation PhotoCollectionImageView

- (void)drawRect:(NSRect)dirtyRect
{
    // [super drawRect:dirtyRect];
    
    if(!self.image)
        return;
    
    NSPoint point = NSMakePoint(0, 0);
    
    if(self.image.size.width > self.bounds.size.width)
        point.x = roundf((self.image.size.width - self.bounds.size.width)/2);
    
    if(self.image.size.height > self.bounds.size.height)
        point.y = roundf((self.image.size.height - self.bounds.size.height)/2);
    
    [self.image drawInRect:self.bounds fromRect:NSMakeRect(point.x, point.y, self.bounds.size.width, self.bounds.size.height) operation:NSCompositeHighlight fraction:1];
    
}

-(void)setImage:(NSImage *)newImage {
    
//    if(newImage && newImage.size.width < NSWidth(self.frame) ) {
//        float scale =  NSWidth(self.frame)/newImage.size.width;
//        
//        newImage.size = NSMakeSize(scale*newImage.size.width, scale*newImage.size.height);
//        
//    }
//    
//    
//    if(newImage && newImage.size.height < NSHeight(self.frame)) {
//        float scale =  NSHeight(self.frame)/newImage.size.height;
//        
//        newImage.size = NSMakeSize(scale*newImage.size.width, scale*newImage.size.height);
//        
//    }
    
    if(!self.image && newImage )
        [self addAnimation:photoAnimation() forKey:@"contents"];
    else
        [self removeAnimationForKey:@"contents"];
    
    [super setImage:newImage];
}

static CAAnimation *photoAnimation() {
    static CAAnimation *animation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animation = [CABasicAnimation animationWithKeyPath:@"contents"];
        
        animation.duration = 0.2;
    });
    return animation;
}


-(void)mouseDown:(NSEvent *)theEvent {
    PhotoCollectionImageObject *obj = (PhotoCollectionImageObject *) self.object;
    
    [[TGPhotoViewer viewer] show:obj.previewObject conversation:[Telegram rightViewController].collectionViewController.conversation];
    
}

-(void)setObject:(PhotoCollectionImageObject *)object {
    [super setObject:object];
}


+(NSCache *)cache {
    static NSCache *cache;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
        [cache setCountLimit:10000];
    });
    
    return cache;
}

+(void)clearCache {
    [[self cache] removeAllObjects];
}

@end

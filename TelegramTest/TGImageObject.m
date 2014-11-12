//
//  TGImageObject.m
//  Telegram
//
//  Created by keepcoder on 17.07.14.
//  Copyright (c) 2014 keepcoder. All rights reserved.
//

#import "TGImageObject.h"
#import "DownloadPhotoItem.h"
#import "ImageCache.h"
#import "TGImageView.h"
#import "ImageUtils.h"
#import "TGFileLocation+Extensions.h"
@implementation TGImageObject

-(id)initWithLocation:(TGFileLocation *)location {
    if(self = [self initWithLocation:location placeHolder:nil sourceId:0 size:0]) {
        
    }
    
    return self;
}

-(id)initWithLocation:(TGFileLocation *)location placeHolder:(NSImage *)placeHolder {
    if(self = [self initWithLocation:location placeHolder:placeHolder sourceId:0 size:0]) {
        
    }
    
    return self;
}


-(id)initWithLocation:(TGFileLocation *)location placeHolder:(NSImage *)placeHolder sourceId:(int)sourceId {
    if(self = [self initWithLocation:location placeHolder:placeHolder sourceId:sourceId size:0]) {
        
    }
    
    return self;
}

-(id)initWithLocation:(TGFileLocation *)location placeHolder:(NSImage *)placeHolder sourceId:(int)sourceId size:(int)size {
    if(self = [super init]) {
        _location = location;
        _placeholder = placeHolder;
        _sourceId = sourceId;
        _size = size;
        _imageViewClass = [TGImageView class];
    }
    
    return self;
}



-(void)initDownloadItem {
    
    
    if(_downloadItem )
        return;//[_downloadItem cancel];
    

    _downloadItem = [[DownloadPhotoItem alloc] initWithObject:_location size:_size];
    
    _downloadListener = [[DownloadEventListener alloc] initWithItem:_downloadItem];

    [_downloadItem addEvent:_downloadListener];
    
    
    weak();

    [self.downloadListener setCompleteHandler:^(DownloadItem * item) {
        
                
        NSImage *image = [[NSImage alloc] initWithData:item.result];
        
        image = decompressedImage(image);
                
        weakSelf.downloadItem = nil;
        
        [[weakSelf.imageViewClass cache] setObject:image forKey:weakSelf.location.cacheKey];
        
        [[ASQueue mainQueue] dispatchOnQueue:^{
            [weakSelf.delegate didDownloadImage:image object:weakSelf];
        }];
        
    }];
    
    
    [self.downloadListener setProgressHandler:^(DownloadItem * item) {
        if([weakSelf.delegate respondsToSelector:@selector(didUpdatedProgress:)]) {
            [weakSelf.delegate didUpdatedProgress:item.progress];
        }
    }];
    
    
    [_downloadItem start];
}




@end
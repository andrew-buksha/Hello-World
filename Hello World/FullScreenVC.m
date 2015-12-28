//
//  FullScreenVC.m
//  Hello World
//
//  Created by Andrey Buksha on 25.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "FullScreenVC.h"
#import "UIImageView+AFNetworking.h"

@import Photos;

@interface FullScreenVC ()

@end

@implementation FullScreenVC

static PHFetchResult* photosAsset;
static PHAssetCollection* collection;
static PHObjectPlaceholder* placeholder;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imgLink]
                                                cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    [self.imageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"placeholder"] success:nil failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)savePhoto {
    
}

-(void)showAlertWithTitle: (NSString *)title message: (NSString *) message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:true completion:nil];
    
}

-(void)FindAndCreateAlbum {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"title = %@", @"Hello World"];
    collection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum
                                                          subtype:PHAssetCollectionSubtypeAny
                                                          options:fetchOptions].firstObject;
    if (!collection)
    {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *createAlbum = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"Hello World"];
            placeholder = [createAlbum placeholderForCreatedAssetCollection];
        } completionHandler:^(BOOL success, NSError *error) {
            if (success)
            {
                PHFetchResult *collectionFetchResult = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[placeholder.localIdentifier]
                                                                                                            options:nil];
                collection = collectionFetchResult.firstObject;
                [self savePhotoToAlbum];
            }
        }];
    } else
    {
        [self savePhotoToAlbum];
    }
}

-(void)savePhotoToAlbum {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
                placeholder = [assetRequest placeholderForCreatedAsset];
                photosAsset = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
                PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection
                                                                                                                              assets:photosAsset];
                [albumChangeRequest addAssets:@[placeholder]];
            } completionHandler:^(BOOL success, NSError *error) {
                if (success)
                {
                    [self showAlertWithTitle:@"Image saved" message:@"Image has been saved to photo album"];
                } else {
                    NSLog(@"Error: %@", error);

                }
            }];
        }
    }];
}


- (IBAction)saveBtnPressed:(id)sender {
    [self FindAndCreateAlbum];
}

@end

//
//  ViewController.m
//  TmapPOI
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"

#define APP_KEY @"9808e4e1-db20-3f1f-8b3c-77606b3b71a1"


@interface ViewController () <UISearchBarDelegate, TMapViewDelegate>
@property (strong, nonatomic)TMapView *mapView;

@end

@implementation ViewController
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    [self.mapView clearCustomObjects];
     
    NSString *keyword = searchBar.text;
    TMapPathData *path = [[TMapPathData alloc]init];
    NSArray *result = [path requestFindTitlePOI:keyword];
    NSLog(@"Number of POI : %d", result.count);
    
    int i = 0;
    for (TMapPOIItem *item in result) {
        NSLog(@"Name : %@ - point : %@", [item getPOIName], [item getPOIPoint]);
        
        NSString *markerID = [NSString stringWithFormat:@"marker_%d", i++];
        TMapMarkerItem *marker = [[TMapMarkerItem alloc]init];
        [marker setTMapPoint:[item getPOIPoint]];
        [marker setIcon:[UIImage imageNamed:@"icon_clustering.png"]];
        
        [marker setCanShowCallout:YES];
        [marker setCalloutTitle:[item getPOIName]];
        [marker setCalloutSubtitle:[item getPOIAddress]];
        
        [self.mapView addCustomObject:marker ID:markerID];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HIGHT);
    
    self.mapView = [[TMapView alloc]initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

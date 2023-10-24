//
//  ViewController.h
//  MyWeaterApp
//
//  Created by lcodeM2 on 21/09/23.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController :UIViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (weak, nonatomic) IBOutlet UIView *ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *Actualimage;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *GlassView;
@property (weak, nonatomic) IBOutlet UIView *firstSafeView;

@property (weak, nonatomic) IBOutlet UILabel *lblWethDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidity;
@property (weak, nonatomic) IBOutlet UILabel *lblKmpl;

@property (weak, nonatomic) IBOutlet UILabel *lblLat;
@property (weak, nonatomic) IBOutlet UILabel *lblLon;

@property (weak, nonatomic) IBOutlet UILabel *lblPrespi;





@property (weak, nonatomic) IBOutlet UIView *TempView;
@property (weak, nonatomic) IBOutlet UIView *HumidityView;
@property (weak, nonatomic) IBOutlet UIView *WindSpeedView;
@property (weak, nonatomic) IBOutlet UIView *PrecipetationView;
@property (weak, nonatomic) IBOutlet UIView *LatLongView;



@property (strong, nonatomic) NSString *locationInfo1;
@property (strong, nonatomic) NSString *locationInfo2;

- (IBAction)btnGetWether:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGET;


@end


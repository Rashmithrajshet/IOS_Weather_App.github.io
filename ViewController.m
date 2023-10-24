

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    [self AddGradientColor:self.MainView];
    self.btnGET.layer.cornerRadius=20.0;
    //[self AddShadow:self.ImageView];
    [self AddCornerRadiusAndBorder:self.TempView];
    [self AddCornerRadiusAndBorder:self.HumidityView];
    [self AddCornerRadiusAndBorder:self.PrecipetationView];
    [self AddCornerRadiusAndBorder:self.WindSpeedView];
    [self AddCornerRadiusAndBorder:self.LatLongView];
    self.GlassView.layer.cornerRadius=10.0;
    self.GlassView.layer.masksToBounds = YES;
    self.ImageView.layer.cornerRadius = self.ImageView.frame.size.width / 2.0;
    self.Actualimage.layer.cornerRadius=self.Actualimage.frame.size.width/2.0;
    [self addPopAnimation:self.GlassView];
    
    
}
-(void)AddGradientColor:(UIView *)view
{
       CAGradientLayer *gradientLayer = [CAGradientLayer layer];
       gradientLayer.frame = view.bounds;
       UIColor *blackColor = [UIColor blackColor];
       UIColor *darkPurpleColor = [UIColor colorWithRed:48.0/255.0 green:0.0/255.0 blue:48.0/255.0 alpha:1.0];
       gradientLayer.colors = @[(id)blackColor.CGColor, (id)darkPurpleColor.CGColor];
       gradientLayer.startPoint = CGPointMake(0.5, 0.0);
       gradientLayer.endPoint = CGPointMake(0.5, 1.0);
       [view.layer insertSublayer:gradientLayer atIndex:0];
}

-(void)AddShadow:(UIView *)view
{
    view.layer.shadowColor = [UIColor whiteColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,12);
    view.layer.shadowRadius = 2.0;
    view.layer.shadowOpacity = 0.1;
}


- (IBAction)btnGetWether:(id)sender {
    [self.locationManager startUpdatingLocation];
   
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    double latitude = location.coordinate.latitude;
    double longitude = location.coordinate.longitude;

    // Update the label with the location information
    self.locationInfo1 = [NSString stringWithFormat:@"Latitude: %f", latitude];
    self.locationInfo2 = [NSString stringWithFormat:@"Longitude: %f", longitude];
    self.lblLat.text = self.locationInfo1;
    self.lblLon.text = self.locationInfo2;

    // Fetch weather data using latitude and longitude
    [self fetchWeatherDataForLatitude:latitude longitude:longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location error: %@", error);
}

- (void)fetchWeatherDataForLatitude:(double)latitude longitude:(double)longitude {
    NSString *apiKey = @"af6c55d2f9734f0ba9754322232109";

    NSString *urlString = [NSString stringWithFormat:@"https://api.weatherapi.com/v1/current.json?key=%@&q=%f,%f", apiKey, latitude, longitude];
    NSURL *url = [NSURL URLWithString:urlString];

    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error fetching weather data: %@", error);
            return;
        }

        NSError *jsonError;
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            NSLog(@"Error parsing JSON: %@", jsonError);
            return;
        }

        NSDictionary *current = weatherData[@"current"];
        double temperature = [current[@"temp_c"] doubleValue];
        NSString *weatherDescription = current[@"condition"][@"text"];
        
                NSString *precipitation = current[@"precip_mm"];
                NSString *windSpeed = current[@"wind_kph"];
                NSString *humidity = current[@"humidity"];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lblTemp.text = [NSString stringWithFormat:@"%.2f°C", temperature];
            self.lblWethDesc.text = [NSString stringWithFormat:@"%@", weatherDescription];
            self.lblHumidity.text = [NSString stringWithFormat:@"%@%%", humidity];
            self.lblPrespi.text =[NSString stringWithFormat:@"%@ mm", precipitation];
            self.lblKmpl.text=[NSString stringWithFormat:@"%@ km/h", windSpeed];
            [self updateWeatherImage];
            [self addPopAnimation:self.firstSafeView];
            
        });
    }];

    [dataTask resume];
}

-(void)AddCornerRadiusAndBorder:(UIView *)view
{
    view.layer.cornerRadius = 10.0;
    view.layer.borderWidth = 0.2;
    view.layer.borderColor = [UIColor blackColor].CGColor;
}


- (void)updateWeatherImage {
    NSString *weatherText = [self.lblWethDesc.text lowercaseString];

    NSString *imageName = @"";

    if ([weatherText isEqualToString:@"sunny"])
    {
        imageName = @"sunny.jpg";
    }
    if ([weatherText isEqualToString:@"partly cloudy"])
    {
        imageName = @"cloudy.jpg";
    }
    else if ([weatherText isEqualToString:@"windy"])
    {
        imageName = @"windy.jpg";
    }
    else if ([weatherText isEqualToString:@"rainy"])
    {
        imageName = @"rainy.jpg";
    }
    else if([weatherText isEqualToString:@"cloudy"])
    {
        imageName = @"cloudy.jpg";
    }
    else if([weatherText isEqualToString:@"duststrom"])
    {
        imageName=@"duststrom.jpg";
    }
    else if([weatherText isEqualToString:@"foggy"])
    {
        imageName=@"foggy.jpg";
    }
    else if([weatherText isEqualToString:@"freezingrain"])
    {
        imageName=@"freezingrain";
    }
    else if([weatherText isEqualToString:@"hail"])
    {
        imageName=@"hail.jpg";
    }
    else if([weatherText isEqualToString:@"hazy"])
    {
        imageName=@"hazy.jpg";
    }
    else if([weatherText isEqualToString:@"heatwave"])
    {
        imageName=@"heatwave.jpg";
    }
    else if([weatherText isEqualToString:@"hothumid"])
    {
        imageName=@"hothumid.jpg";
    }
    else if([weatherText isEqualToString:@"lightrain"])
    {
        imageName=@"lightrain.jpg";
    }
    else if([weatherText isEqualToString:@"overcast"])
    {
        imageName=@"overcaste.jpg";
    }
    else if([weatherText isEqualToString:@"partlycloudy"])
    {
        imageName=@"partlycloudy.jpg";
    }
    else if([weatherText isEqualToString:@"scortching"])
    {
        imageName=@"scortching.jpg";
    }
    else if([weatherText isEqualToString:@"stromy"])
    {
        imageName=@"stromy.jpg";
    }
    else if([weatherText isEqualToString:@"snowy"])
    {
        imageName=@"snowy.jpg";
    }
    else if([weatherText isEqualToString:@"thunderstrom"])
    {
        imageName=@"thunderstrome.jpg";
    }
    else if([weatherText isEqualToString:@"tornado"])
    {
        imageName=@"tornado.jpg";
    }
   else {
        imageName = @"sunny.jpg";
    }

    UIImage *image = [UIImage imageNamed:imageName];
    self.Actualimage.image = image;
}

- (void)addPopAnimation:(UIView *)view {
    view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    // Set the initial position to the center of the screen
    view.center = CGPointMake(CGRectGetWidth(self.view.frame) / 2, CGRectGetHeight(self.view.frame) / 2);
    
    [UIView animateWithDuration:0.8
                          delay:0.1
         usingSpringWithDamping:0.7  // Adjust damping for desired bounce effect
          initialSpringVelocity:0.5  // Adjust velocity for desired bounce effect
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         // Scale the view to its original size
                         view.transform = CGAffineTransformIdentity;
                         
                         // Set the final position (if needed)
                         view.center = CGPointMake(200, 200);  // Adjust the final position
                     }
                     completion:nil];
}




@end

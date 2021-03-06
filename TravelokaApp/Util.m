//
//  Util.m
//  Traveloka
//
//  Created by Ritchie Nathaniel on 3/19/14.
//  Copyright (c) 2014 Traveloka. All rights reserved.
//

#import "Util.h"

@implementation Util

#pragma mark - Date
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate{
    if ([date compare:beginDate] == NSOrderedAscending){
        return NO;
    }
    
    if ([date compare:endDate] == NSOrderedDescending){
        return NO;
    }
    
    return YES;
}

#pragma mark - Null Handler
+ (NSString *)nullToEmptyString:(id)value {
    NSString *emptyString = @"";
    
    if ([value isKindOfClass:[NSNull class]] || value == nil) return emptyString;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyString;
    }
    
    return (NSString *)value;
}

+ (NSDictionary *)nullToEmptyDictionary:(id)value {
    NSDictionary *emptyDictionary = [NSDictionary dictionary];
    
    if ([value isKindOfClass:[NSNull class]] || value == nil) return emptyDictionary;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyDictionary;
    }
    
    return (NSDictionary *)value;
}

+ (NSArray *)nullToEmptyArray:(id)value {
    NSArray *emptyArray = [NSArray array];
    
    if ([value isKindOfClass:[NSNull class]] || value == nil) return emptyArray;
    
    if ((NSNull *)value == [NSNull null]) {
        return emptyArray;
    }
    
    return (NSArray *)value;
}

#pragma mark - Color
+ (UIColor *)getColor:(NSString *)hexColor {
    unsigned int red, green, blue;
    
    NSRange range;
    
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

#pragma mark - Image Processing
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (UIImage *)makeRoundCornerImage:(UIImage*)img width:(int)cornerWidth height:(int)cornerHeight {
    
    int w = img.size.width;
    int h = img.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    addRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *result = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return result;
}

+ (UIImage *)resizedImage:(UIImage *)inImage frame:(CGRect)thumbRect {
    CGImageRef imageRef = [inImage CGImage];
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,		// width
                                                thumbRect.size.height,		// height
                                                CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
                                                4 * thumbRect.size.width,	// rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage *result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

+ (UIImage *)imageByScaling:(BOOL)isScaling cropping:(BOOL)isCropping sourceImage:(UIImage *)sourceImage frame:(CGRect)targetFrame {
    CGSize targetSize = targetFrame.size;
    
    CGPoint thumbnailPoint = CGPointMake(0.0f, 0.0f);
    if(isScaling && isCropping)thumbnailPoint = CGPointMake(0.0f, 0.0f);
    else if(isScaling)thumbnailPoint = CGPointMake(0.0f, 0.0f);
    else if(isCropping)thumbnailPoint = CGPointMake(-targetFrame.origin.x, -targetFrame.origin.y);
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat scaledWidth = targetSize.width;
    CGFloat scaledHeight = targetSize.height;
    
    if(isScaling){
        scaledWidth = targetSize.width;
        scaledHeight = targetSize.height;
    }
    else{
        scaledWidth = imageSize.width;
        scaledHeight = imageSize.height;
    }
    
    UIImage *newImage = nil;
    CGFloat scaleFactor = 0.0;
    
    if(isScaling){
        if (CGSizeEqualToSize(imageSize, targetSize) == NO)
        {
            CGFloat widthFactor = targetSize.width / imageSize.width;
            CGFloat heightFactor = targetSize.height / imageSize.height;
            
            if (widthFactor > heightFactor) scaleFactor = widthFactor; //Scale to Fit Witdth
            else scaleFactor = heightFactor; //Scale to Fit Height
            
            scaledWidth  = imageSize.width * scaleFactor;
            scaledHeight = imageSize.height * scaleFactor;
            
            //Center The Image
            if (widthFactor > heightFactor){
                thumbnailPoint.y = (targetSize.height - scaledHeight) * 0.5;
            }
            else{
                if (widthFactor < heightFactor)
                {
                    thumbnailPoint.x = (targetSize.width - scaledWidth) * 0.5;
                }
            }
        }
    }
    
    if(isCropping){
        //Crop Image
        UIGraphicsBeginImageContext(targetSize);
        
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        
        [sourceImage drawInRect:thumbnailRect];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        if(newImage == nil)NSLog(@"Faild to Crop Image");
        
        //Pop Context
        UIGraphicsEndImageContext();
    }
    
    return newImage;
}

+ (UIImage *)image:(UIImage *)image withTintColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark - Encoding
+ (NSString *)urlEncodeFromString:(NSString *)sourceString {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[sourceString UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)sha1:(NSString*)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
    
}

+ (NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

#pragma mark - String
+ (NSString *)generateRandomStringWithLength:(NSInteger)length {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    for (int i=0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}

+ (NSString *)ordinalNumberWithInteger:(NSInteger)number {
    id anObject = [NSNumber numberWithInteger:number];
    
    if (![anObject isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    
    NSString *strRep = [anObject stringValue];
    NSString *lastDigit = [strRep substringFromIndex:([strRep length]-1)];
    
    NSString *ordinal;
    
    
    if ([strRep isEqualToString:@"11"] || [strRep isEqualToString:@"12"] || [strRep isEqualToString:@"13"]) {
        ordinal = @"th";
    } else if ([lastDigit isEqualToString:@"1"]) {
        ordinal = @"st";
    } else if ([lastDigit isEqualToString:@"2"]) {
        ordinal = @"nd";
    } else if ([lastDigit isEqualToString:@"3"]) {
        ordinal = @"rd";
    } else {
        ordinal = @"th";
    }
    
    return [NSString stringWithFormat:@"%@%@", strRep, ordinal];
}

+ (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(CGFloat)value {
    NSString *valueString = [NSString stringWithFormat:@"%.0f", value];
    NSString *formattedCurrencyString = @"";
    
    int flag = 0;
    
    for(int i = valueString.length - 1; i>=0; i--) {
        if(flag % 3 == 0 && flag != 0) {
            formattedCurrencyString = [NSString stringWithFormat:@"%c.%@", [valueString characterAtIndex:i], formattedCurrencyString];
        }
        else {
            formattedCurrencyString = [NSString stringWithFormat:@"%c%@", [valueString characterAtIndex:i], formattedCurrencyString];
        }
        
        flag++;
    }
    
    if(currencySign != nil && ![currencySign isEqualToString:@""]) {
        formattedCurrencyString = [NSString stringWithFormat:@"%@ %@", currencySign, formattedCurrencyString];
    }
    
    return formattedCurrencyString;
}

#pragma mark - Location
+ (CGFloat)getDistanceFromLong:(double)longitude lat:(double)latitude andLong2:(double)longitude2 lat2:(double)latitude2 {
    CLLocation *locationA = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocation *locationB = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    
    CLLocationDistance distanceInMeters = [locationA distanceFromLocation:locationB];
    
    return distanceInMeters;
}

#pragma mark - JSON
+ (NSString *)jsonStringFromObject:(id)json {
    if(json == nil) {
        return @"";
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:0
                                                         error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"Got an error stringFromJSON method: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

+ (id)jsonObjectFromString:(NSString *)string {
    if(string == nil || [string isEqualToString:@""]) {
        return nil;
    }
    
    NSError *error;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:&error];
    if (!json) {
        NSLog(@"Got an error jsonFromString method: %@", error);
    }
    return json;
}

#pragma mark - Rect
+ (CGFloat)lineMinimumHeight {
    return 1.0f/[UIScreen mainScreen].scale;
}

+ (CGFloat)screenAdjustedHeight:(CGFloat)currentHeight {
    return CGRectGetHeight([UIScreen mainScreen].bounds)/667.0f * currentHeight; //Use iPhone 6 as guide
}

+ (CGFloat)screenAdjustedWidth:(CGFloat)currentWidth {
    return CGRectGetWidth([UIScreen mainScreen].bounds)/375.0f * currentWidth; //Use iPhone 6 as guide
}

+ (CGRect)getStringConstrainedSizeWithString:(NSString *)string withFont:(UIFont *)font withConstrainedSize:(CGSize)size {
    CGRect countedRect = CGRectZero;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0f) {
        //iOS 7 and up
        countedRect = [string boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont fontWithName:font.fontName size:font.pointSize]}
                                           context:nil];
    }
    else {
        //Below iOS 7
        CGSize countedSize = [string sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        countedRect = CGRectMake(0.0f, 0.0f, countedSize.width, countedSize.height);
    }
    
    return countedRect;
}

#pragma mark - Device
+ (NSString *)hardwareModel {
    NSString *hardware = [Util hardwareString];
    
    //device list updated as 25-9-2016 in stackoverflow.com/a/17261056
    if ([hardware isEqualToString:@"iPhone1,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 1G"];
    if ([hardware isEqualToString:@"iPhone1,2"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 3G"];
    if ([hardware isEqualToString:@"iPhone2,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 3GS"];
    if ([hardware isEqualToString:@"iPhone3,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 4"];
    if ([hardware isEqualToString:@"iPhone3,3"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"Verizon iPhone 4"];
    if ([hardware isEqualToString:@"iPhone4,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 4S"];
    if ([hardware isEqualToString:@"iPhone5,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 5 (GSM)"];
    if ([hardware isEqualToString:@"iPhone5,2"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 5 (GSM+CDMA)"];
    if ([hardware isEqualToString:@"iPhone5,3"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 5c (GSM+CDMA)"];
    if ([hardware isEqualToString:@"iPhone5,4"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 5c (UK+Europe+Asia+China)"];
    if ([hardware isEqualToString:@"iPhone6,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 5s (GSM+CDMA)"];
    if ([hardware isEqualToString:@"iPhone6,2"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 5s (UK+Europe+Asia+China)"];
    if ([hardware isEqualToString:@"iPhone7,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 6 Plus"];
    if ([hardware isEqualToString:@"iPhone7,2"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 6"];
    if ([hardware isEqualToString:@"iPhone8,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 6s"];
    if ([hardware isEqualToString:@"iPhone8,2"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 6s Plus"];
    if ([hardware isEqualToString:@"iPhone8,4"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone SE"];
    if ([hardware isEqualToString:@"iPhone9,1"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 7"];
    if ([hardware isEqualToString:@"iPhone9,2"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 7 Plus"];
    if ([hardware isEqualToString:@"iPhone9,3"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 7"];
    if ([hardware isEqualToString:@"iPhone9,4"])    return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPhone 7 Plus"];
    
    if ([hardware isEqualToString:@"iPod1,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPod Touch 1G"];
    if ([hardware isEqualToString:@"iPod2,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPod Touch 2G"];
    if ([hardware isEqualToString:@"iPod3,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPod Touch 3G"];
    if ([hardware isEqualToString:@"iPod4,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPod Touch 4G"];
    if ([hardware isEqualToString:@"iPod5,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPod Touch 5G"];
    
    if ([hardware isEqualToString:@"iPad1,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad"];
    if ([hardware isEqualToString:@"iPad1,2"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 3G"];
    if ([hardware isEqualToString:@"iPad2,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 2 (WiFi)"];
    if ([hardware isEqualToString:@"iPad2,2"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 2"];
    if ([hardware isEqualToString:@"iPad2,3"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 2 (CDMA)"];
    if ([hardware isEqualToString:@"iPad2,4"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 2"];
    if ([hardware isEqualToString:@"iPad2,5"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini (WiFi)"];
    if ([hardware isEqualToString:@"iPad2,6"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini"];
    if ([hardware isEqualToString:@"iPad2,7"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini (GSM+CDMA)"];
    if ([hardware isEqualToString:@"iPad3,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 3 (WiFi)"];
    if ([hardware isEqualToString:@"iPad3,2"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 3 (GSM+CDMA)"];
    if ([hardware isEqualToString:@"iPad3,3"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 3"];
    if ([hardware isEqualToString:@"iPad3,4"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 4 (WiFi)"];
    if ([hardware isEqualToString:@"iPad3,5"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 4"];
    if ([hardware isEqualToString:@"iPad3,6"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad 4 (GSM+CDMA)"];
    if ([hardware isEqualToString:@"iPad4,1"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Air (WiFi)"];
    if ([hardware isEqualToString:@"iPad4,2"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Air (Cellular)"];
    if ([hardware isEqualToString:@"iPad4,4"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini 2 (WiFi)"];
    if ([hardware isEqualToString:@"iPad4,5"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini 2 (Cellular)"];
    if ([hardware isEqualToString:@"iPad4,6"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini 2"];
    if ([hardware isEqualToString:@"iPad4,7"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini 3"];
    if ([hardware isEqualToString:@"iPad4,8"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini 3"];
    if ([hardware isEqualToString:@"iPad4,9"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Mini 3"];
    if ([hardware isEqualToString:@"iPad5,3"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Air 2"];
    if ([hardware isEqualToString:@"iPad5,4"])      return [NSString stringWithFormat:@"%@ (%@)", hardware, @"iPad Air 2"];
    
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    return [NSString stringWithFormat:@"hardware: %@", hardware];
}

+ (NSString*)hardwareString {
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

#pragma mark - Taptic Feedback
+ (void)tapticImpactFeedbackGenerator {
    UIImpactFeedbackGenerator *feedbackGenerator = [[UIImpactFeedbackGenerator alloc] init];
    [feedbackGenerator prepare];
    [feedbackGenerator impactOccurred];
}

+ (void)tapticSelectionFeedbackGenerator {
    UISelectionFeedbackGenerator *feedbackGenerator = [[UISelectionFeedbackGenerator alloc] init];
    [feedbackGenerator prepare];
    [feedbackGenerator selectionChanged];
}

+ (void)tapticNotificationFeedbackGeneratorWithType:(UINotificationFeedbackType)type {
    UINotificationFeedbackGenerator *feedbackGenerator = [[UINotificationFeedbackGenerator alloc] init];
    [feedbackGenerator prepare];
    [feedbackGenerator notificationOccurred:type];
}

#pragma mark - Validation
+ (BOOL)isAlphabetCharactersOnlyFromText:(NSString *)text {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";
    NSCharacterSet *notLetters = [[NSCharacterSet characterSetWithCharactersInString:letters] invertedSet];
    
    BOOL valid = YES;
    
    for (int i = 0; i < [text length]; i++) {
        unichar c = [text characterAtIndex:i];
        if ([notLetters characterIsMember:c]) {
            valid = NO;
        }
    }
    return valid;
}

+ (BOOL)validatePhoneNumber:(NSString *)candidate {
    NSString *phoneNumberRegex = @"^\\+?[0-9]*$";
    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", phoneNumberRegex];
    
    return [phoneNumberTest evaluateWithObject:candidate];
}

+ (BOOL)validateAllNumber:(NSString *)candidate {
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", numberRegex];
    
    return [numberTest evaluateWithObject:candidate];
}

+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validatePassword:(NSString *)candidate {
    //Password must contain at least 9 characters,
    //1 lowercase, 1 uppercase, 1 special character, and 1 number (0–9).

    NSCharacterSet * characterSet = [NSCharacterSet uppercaseLetterCharacterSet] ;
    NSRange range = [candidate rangeOfCharacterFromSet:characterSet] ;
    if (range.location == NSNotFound) {
        return NO ;
    }
    characterSet = [NSCharacterSet lowercaseLetterCharacterSet] ;
    range = [candidate rangeOfCharacterFromSet:characterSet] ;
    if (range.location == NSNotFound) {
        return NO ;
    }
    
    characterSet = [NSCharacterSet characterSetWithCharactersInString:@"~!@#$%^&*()_+{}|[]\\:\";'<>,.?/'"] ;
    range = [candidate rangeOfCharacterFromSet:characterSet] ;
    if (range.location == NSNotFound) {
        return NO ;
    }
    
    characterSet = [NSCharacterSet decimalDigitCharacterSet] ;
    range = [candidate rangeOfCharacterFromSet:characterSet] ;
    if (range.location == NSNotFound) {
        return NO ;
    }
    
    if([candidate length] < 9) {
        return NO;
    }

    return YES ;
}

#pragma mark - Others
+ (void)logAllFontFamiliesAndName {
#ifdef DEBUG
    NSLog(@"-------------------------------FONT-------------------------------");
    for(NSString *fontFamily in [UIFont familyNames]) {
        NSLog(@"%@", fontFamily);
        
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontFamily]) {
            NSLog(@"     %@", fontName);
        }
    }
    NSLog(@"------------------------------------------------------------------");
#endif
}

+ (void)log:(NSString *)string {
#ifdef DEBUG
    NSLog(@"%@", string);
#endif
}

@end

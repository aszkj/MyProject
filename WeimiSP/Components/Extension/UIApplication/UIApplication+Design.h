//
//  UIApplication+Design.h
//  weimi
//
//  Created by ray on 16/3/9.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

/*About — prefs:root=General&path=About
 Accessibility — prefs:root=General&path=ACCESSIBILITY
 Airplane Mode On — prefs:root=AIRPLANE_MODE
 Auto-Lock — prefs:root=General&path=AUTOLOCK
 Brightness — prefs:root=Brightness
 Bluetooth — prefs:root=General&path=Bluetooth
 Date & Time — prefs:root=General&path=DATE_AND_TIME
 FaceTime — prefs:root=FACETIME
 General — prefs:root=General
 Keyboard — prefs:root=General&path=Keyboard
 iCloud — prefs:root=CASTLE
 iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 International — prefs:root=General&path=INTERNATIONAL
 Location Services — prefs:root=LOCATION_SERVICES
 Music — prefs:root=MUSIC
 Music Equalizer — prefs:root=MUSIC&path=EQ
 Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 Network — prefs:root=General&path=Network
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 Notes — prefs:root=NOTES
 Notification — prefs:root=NOTIFICATIONS_ID
 Phone — prefs:root=Phone
 Photos — prefs:root=Photos
 Profile — prefs:root=General&path=ManagedConfigurationList
 Reset — prefs:root=General&path=Reset
 Safari — prefs:root=Safari
 Siri — prefs:root=General&path=Assistant
 Sounds — prefs:root=Sounds
 Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store — prefs:root=STORE
 Twitter — prefs:root=TWITTER
 Usage — prefs:root=General&path=USAGE
 VPN — prefs:root=General&path=Network/VPN
 Wallpaper — prefs:root=Wallpaper
 Wi-Fi — prefs:root=WIFI
 */
static const NSString *UIApplicationSettingsURL = @"prefs:root";
static const NSString *UIApplicationWifiSettingsURL = @"prefs:root=WIFI";
static const NSString *UIApplicationWallpaperSettingsURL = @"prefs:root=Wallpaper";
static const NSString *UIApplicationVPNSettingsURL = @"prefs:root=General&path=Network/VPN";
static const NSString *UIApplicationPhotosSettingsURL = @"prefs:root=Photos";
static const NSString *UIApplicationUsageSettingsURL = @"prefs:root=Usage";


@interface UIApplication (Design)

/**
 *  jump to system setting, please check your info.plist,have key URL types and add row URL Schemes : prefs
 *
 *  @param urlString system setting url
 *
 *  @return success return YES, fail return NO
 */
- (BOOL)rt_openSettingURL:(const NSString *)urlString;

@end

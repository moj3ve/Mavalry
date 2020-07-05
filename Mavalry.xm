#import "Mavalry.h"
#import <spawn.h>
#import <Cephei/HBPreferences.h>

// Check if tweak is set up
%hook SBLockScreenManager

- (void)lockScreenViewControllerDidDismiss {
	NSString *path = @"/var/mobile/Library/Preferences/com.ajaidan.mavalryprefs.plist";
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	NSNumber *didShowOBWelcomeController = [settings valueForKey:@"didShowOBWelcomeController"] ?: @0;
	if([didShowOBWelcomeController isEqual:@0]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-prefs:Mavalry"] options:@{} completionHandler:nil];
	} else {
		return %orig;
	}
}

%end

%group LSnoToday
%hook SBMainDisplayPolicyAggregator

-(BOOL)_allowsCapabilityLockScreenTodayViewWithExplanation:(id*)arg1 {
    return false;
}

-(BOOL)_allowsCapabilityTodayViewWithExplanation:(id*)arg1 {
    return false;
}

%end
%end

%group HSnoToday
%hook SBRootFolderView

-(unsigned long long)_minusPageCount {
    return false;
}

-(void)_layoutSubviewsForTodayView {
    %orig;
    [self todayViewController].view.hidden = false;
}

-(void)beginPageStateTransitionToState:(long long)arg1 animated:(BOOL)arg2 interactive:(BOOL)arg3  {
    if (arg1 == 2) return; 
    %orig;
}

%end
%end

%group HSnoSpotlight
%hook SBRootFolderView

-(void)beginPageStateTransitionToState:(long long)arg1 animated:(BOOL)arg2 interactive:(BOOL)arg3  {
    if (arg1 == 3) return; 
    %orig;
}

%end
%end

%group DNDNotifs
%hook DNDNotificationsService

-(id)initWithClientIdentifier:(id)arg1 {
    return nil;
}
%end
%end

%group HideLabels
%hook SBIconView
- (void)setLabelHidden:(BOOL)arg1 {
	arg1 = YES;
	%orig(arg1);
}
%end
%end

%group PageDots
%hook SBIconListPageControl
- (id)initWithFrame:(CGRect)frame {
	return nil;
}
%end

%hook CSPageControl
- (id)initWithFrame:(CGRect)frame {
	return nil;
}
%end
%end

%group DockBG
%hook SBDockView
- (void)setBackgroundAlpha:(double)arg1 {
	arg1 = 0;
	%orig(arg1);
}

%end
%end

%group FolderBG 
%hook SBFolderBackgroundView
- (id)initWithFrame:(struct CGRect)arg1{
  	return NULL;
}
%end

%hook SBFolderIconImageView
 - (void)setBackgroundView : (UIView *)backgroundView {}
%end
%end

%group OlderNotifs
%hook NCNotificationListSectionRevealHintView
-(void)setFrame:(CGRect)arg1 {
	self.hidden = YES;
	%orig;
}
%end
%end

%group HomeBar
%hook MTLumaDodgePillSettings
- (void)setHeight:(double)arg1 {
	arg1 = 0;
	%orig(arg1);
}

%end
%end

%group Screenshot
%hook SpringBoard
-(void)takeScreenshot {

	%orig;

	UIImpactFeedbackGenerator *hapt = [[UIImpactFeedbackGenerator alloc] init];
	[hapt prepare];

	if (screenshotPref == 1) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium]; //Medium feedback

	} else if (screenshotPref == 2) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium]; //Medium feedback

	} else if (screenshotPref == 3) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy]; //Heavy feedback

	} else if (screenshotPref == 4) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft]; //Soft feedback

	} else if (screenshotPref == 5) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleRigid]; //Rigid feedback

	}
			
	[hapt impactOccurred];
}
%end
%end

%group HapticVolume
%hook SBVolumeControl 

- (void)increaseVolume {

	%orig;

	UIImpactFeedbackGenerator *hapt = [[UIImpactFeedbackGenerator alloc] init];
	[hapt prepare];

	if (hapticPref == 1) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium]; //Medium feedback

	} else if (hapticPref == 2) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium]; //Medium feedback

	} else if (hapticPref == 3) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy]; //Heavy feedback

	} else if (hapticPref == 4) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft]; //Soft feedback

	} else if (hapticPref == 5) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleRigid]; //Rigid feedback

	}
			
	[hapt impactOccurred];
	
}

- (void)decreaseVolume {

	%orig;

	UIImpactFeedbackGenerator *hapt = [[UIImpactFeedbackGenerator alloc] init];
	[hapt prepare];

	if (hapticPref == 1) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight]; //Light feedback

	} else if (hapticPref == 2) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium]; //Medium feedback

	} else if (hapticPref == 3) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy]; //Heavy feedback

	} else if (hapticPref == 4) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleSoft]; //Soft feedback

	} else if (hapticPref == 5) {
		hapt = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleRigid]; //Rigid feedback

	}
			
	[hapt impactOccurred];
	
}
%end
%end

%group VolumeStep
%hook SBVolumeControl
- (float)volumeStepUp {
    return (volumePref); //possible values from 0.01 -> 1.0 
}

- (float)volumeStepDown {
    return (volumePref);
}
%end
%end

// Loads prefs and inits
%ctor {
	%init;
	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ajaidan.mavalryprefs"];
	[preferences registerBool:&isEnabled default:FALSE forKey:@"isEnabled"];
	[preferences registerBool:&moonGone default:FALSE forKey:@"moonGone"];
	[preferences registerBool:&wantsHiddenLabels default:FALSE forKey:@"wantsHiddenLabels"];
	[preferences registerBool:&wantsTransparentDock default:FALSE forKey:@"wantsTransparentDock"];
	[preferences registerBool:&hideFolderBackground default:FALSE forKey:@"hideFolderBackground"];
	[preferences registerBool:&wantsOlderNotifs default:FALSE forKey:@"wantsOlderNotifs"];
	[preferences registerBool:&wantsHomeBar default:FALSE forKey:@"wantsHomeBar"];
	[preferences registerBool:&noTodayHS default:FALSE forKey:@"noTodayHS"];
	[preferences registerBool:&noTodayLS default:FALSE forKey:@"noTodayLS"];
	[preferences registerBool:&wantsHapticScreenshot default:FALSE forKey:@"wantsHapticScreenshot"];
	[preferences registerBool:&wantsHapticVol default:FALSE forKey:@"wantsHapticVol"];
	[preferences registerBool:&noSpotlight default:FALSE forKey:@"noSpotlight"];
	[preferences registerFloat:&hapticPref default:1 forKey:@"hapticPref"];
	[preferences registerFloat:&volumePref default:0 forKey:@"volumePref"];
	[preferences registerFloat:&screenshotPref default:1 forKey:@"screenshotPref"];
	if (isEnabled) {
		if (moonGone) %init(DNDNotifs);
		if (wantsHiddenLabels) %init(HideLabels);
		if (wantsHiddenPageDots) %init(PageDots);
		if (wantsTransparentDock) %init(DockBG);
		if (hideFolderBackground) %init(FolderBG);
		if (wantsOlderNotifs) %init(OlderNotifs);
		if (wantsHomeBar) %init(HomeBar);
		if (noTodayHS) %init(HSnoToday);
		if (noTodayLS) %init(LSnoToday);
		if (wantsHapticScreenshot) %init(Screenshot);
		if (wantsHapticVol) %init(HapticVolume);
		if (volumePref != 0.0) %init(VolumeStep);
		if (noSpotlight) %init(HSnoSpotlight);
	} else {}
}

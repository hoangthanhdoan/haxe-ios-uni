#include <hx/CFFI.h>
#include "OpenFLUnityAds.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UnityAds/UnityAds.h>

extern "C" {
    NSString* UnityAdsCreateNSString (const char* string) {
        return string ? [NSString stringWithUTF8String: string] : [NSString stringWithUTF8String: ""];
    }
}

@interface UnityAdsWrapper : NSObject <UnityAdsShowDelegate> {
}

- (void)initUnityAds:(NSString*)gameId testModeOn:(BOOL)testMode debugModeOn:(BOOL)debugMode;
@end

@implementation UnityAdsWrapper

- (void)initUnityAds:(NSString*)gameId testModeOn:(BOOL)testMode debugModeOn:(BOOL)debugMode{
	[UnityAds
             initialize:gameId
             testMode:testMode
             enablePerPlacementLoad:true
             initializationDelegate:nil];
}

- (void)show:(NSString *)key {
	[UnityAds show:[[[UIApplication sharedApplication] keyWindow] 
	rootViewController] placementId:key showDelegate:self];
}
- (void)unityAdsShowComplete: (NSString *)placementId withFinishState: (UnityAdsShowCompletionState)state {
    openflunityads::unityAdsShowComplete([placementId UTF8String]);
}

- (void)unityAdsShowFailed: (NSString *)placementId withError: (UnityAdsShowError)error withMessage: (NSString *)message {
    openflunityads::unityAdsShowFailed([placementId UTF8String]);
}

- (void)unityAdsShowStart: (NSString *)placementId {
    openflunityads::unityAdsShowStart([placementId UTF8String]);
}
- (void)unityAdsShowClick: (NSString *)placementId {
    openflunityads::unityAdsShowClick([placementId UTF8String]);
}

@end

namespace openflunityads {
	
	value *unityAdsShowCompleteCB = NULL;
	value *unityAdsShowFailedCB = NULL;
	value *unityAdsShowStartCB = NULL;
	value *unityAdsShowClickCB = NULL;

	void InitUnityAds(value cb, const char *gameId, bool testMode, bool debugMode) {
		[[UnityAdsWrapper alloc] initUnityAds:UnityAdsCreateNSString(gameId) testModeOn:testMode debugModeOn:debugMode];
	}
	
	bool show (const char * rawZoneId){
		NSString * zoneId = UnityAdsCreateNSString(rawZoneId);
		[[UnityAdsWrapper alloc] show:zoneId];
    	return true;
	}
	
	void unityAdsShowComplete(const char * keyId){
		val_call1(*unityAdsShowCompleteCB,alloc_bool(keyId));
	}
	void unityAdsShowFailed(const char * keyId){
		val_call1(*unityAdsShowFailedCB,alloc_bool(keyId));
	}
	void unityAdsShowStart(const char * keyId){
		val_call1(*unityAdsShowStartCB,alloc_bool(keyId));
	}
	void unityAdsShowClick(const char * keyId){
		val_call1(*unityAdsShowClickCB,alloc_bool(keyId));
	}

	void setUnityAdsShowCompleteCB(value f){
		val_check_function(f,1);
		unityAdsShowCompleteCB = alloc_root();
		*unityAdsShowCompleteCB = f;
	}
	void setUnityAdsShowFailedCB(value f){
		val_check_function(f,1);
		unityAdsShowFailedCB = alloc_root();
		*unityAdsShowFailedCB = f;
	}
	void setUnityAdsShowStartCB(value f){
		val_check_function(f,1);
		unityAdsShowStartCB = alloc_root();
		*unityAdsShowStartCB = f;
	}
	void setUnityAdsShowClickCB(value f){
		val_check_function(f,1);
		unityAdsShowClickCB = alloc_root();
		*unityAdsShowClickCB = f;
	}

}

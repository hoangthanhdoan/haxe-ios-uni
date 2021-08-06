#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "OpenFLUnityAds.h"


using namespace openflunityads;



static void openflunityads_init (value cb, value gameId, value testmode, value debugmode) {
	
	InitUnityAds(cb,val_string(gameId),val_bool(testmode),val_bool(debugmode));
	
}
DEFINE_PRIM (openflunityads_init, 4);

static value openflunityads_showAd (value zone) {
	
	return alloc_bool(show(val_string(zone)));
}
DEFINE_PRIM (openflunityads_showAd, 2);

///
static void openflunityads_setUnityAdsShowCompleteCB (value f) {
	setUnityAdsShowCompleteCB(f);
}
DEFINE_PRIM (openflunityads_setUnityAdsShowCompleteCB, 1);

///
static void openflunityads_setUnityAdsShowFailedCB (value f) {
	setUnityAdsShowFailedCB(f);
}
DEFINE_PRIM (openflunityads_setUnityAdsShowFailedCB, 1);

///
static void openflunityads_setUnityAdsShowStartCB (value f) {
	setUnityAdsShowStartCB(f);
}
DEFINE_PRIM (openflunityads_setUnityAdsShowStartCB, 1);

///
static void openflunityads_setUnityAdsShowClickCB (value f) {
	setUnityAdsShowClickCB(f);
}
DEFINE_PRIM (openflunityads_setUnityAdsShowClickCB, 1);


extern "C" void openflunityads_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (openflunityads_main);



extern "C" int openflunityads_register_prims () { return 0; }

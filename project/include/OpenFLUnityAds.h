#ifndef OPENFLUNITYADS_H
#define OPENFLUNITYADS_H


namespace openflunityads {
	void InitUnityAds(value cb, const char *gameId, bool testmode, bool debugmode);
	bool show(const char * zone);	
	void unityAdsShowStart(const char * keyId);
	void unityAdsShowComplete(const char * keyId);
	void unityAdsShowClick(const char * keyId);
	void unityAdsShowFailed(const char * keyId);
	
	void setUnityAdsShowStartCB(value f);
	void setUnityAdsShowCompleteCB(value f);
	void setUnityAdsShowClickCB(value f);
	void setUnityAdsShowFailedCB(value f);

}


#endif

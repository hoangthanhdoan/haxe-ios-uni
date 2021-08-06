package extension.unityads;


#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end

class UnityAds {

	public static var instance:UnityAds = null;
	public static function init(gameId:String, test:Bool=false, debug:Bool=false):Void {
		libInit(getInstance(), gameId, test, debug);
	}
	public static function showAd(zone:String, rewardItemKey:String = ""):Bool {
		return libShowAd(zone, rewardItemKey);
	}
	public static function getInstance():UnityAds {
		if (instance == null) { instance = new UnityAds(); }
		return instance;
	}
	
	////java binings
	private static var libInit:UnityAds->String->Bool->Bool->Void =
	#if android
	JNI.createStaticMethod("com/ipsilondev/UnityAdsWrapper","init","(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;ZZ)V");
	#elseif ios
	function(o:UnityAds, s:String, b1:Bool, b2:Bool):Void {
		unityAdsShowComplete1(getInstance().unityAdsShowComplete);
		unityAdsShowFailed1(getInstance().unityAdsShowFailed);
		unityAdsShowStart1(getInstance().unityAdsShowStart);
		unityAdsShowClick1(getInstance().unityAdsShowClick);
		iosInit(o,s,b1,b2);		
	};
	#else
	function(o:UnityAds, s:String, b1:Bool, b2:Bool):Void {
	};
	#end
	
	private static var libShowAd:String->String->Bool =
	#if android
	JNI.createStaticMethod("com/ipsilondev/UnityAdsWrapper","showAd","(Ljava/lang/String;Ljava/lang/String;)Z");
	#elseif ios
	Lib.load("openflunityads","openflunityads_showAd",2);
	#else
	function(s:String="", s2:String=""):Bool {
		return true;
	};
	#end
	
	private static var libCanShowAd:Void->Bool =
	#if android
	JNI.createStaticMethod("com/ipsilondev/UnityAdsWrapper","canShowAd","()Z");
	#elseif ios
	function():Bool {
		return true;
	};
	#else
	function():Bool {
		return false;
	};
	#end
	
	#if ios
	//init function only for ios
	private static var iosInit = Lib.load("openflunityads","openflunityads_init",4);
	#end
			
	//register event handlers for ios
	#if ios
	private static var unityAdsShowComplete1 = Lib.load("openflunityads","openflunityads_setUnityAdsShowCompleteCB",1);
	private static var unityAdsShowFailed1 = Lib.load("openflunityads","openflunityads_setUnityAdsShowFailedCB",1);
	private static var unityAdsShowStart1 = Lib.load("openflunityads","openflunityads_setUnityAdsShowStartCB",1);
	private static var unityAdsShowClick1 = Lib.load("openflunityads","openflunityads_setUnityAdsShowClickCB",1);
	#end
	
	//event handlers
	public function new() {
		
	}
	
	public function unityAdsShowComplete(keyId:String):Void {
		if (unityAdsShowComplete != null) {
			unityAdsShowComplete(keyId);
		}
	}
	public function unityAdsShowFailed(keyId:String):Void {
		if (unityAdsShowFailed != null) {
			unityAdsShowFailed(keyId);
		}
	}
	public function unityAdsShowStart(keyId:String):Void {
		if (unityAdsShowStart != null) {
			unityAdsShowStart(keyId);
		}
	}
	public function unityAdsShowClick(keyId:String):Void {
		if (unityAdsShowClick != null) {
			unityAdsShowClick(keyId);
		}
	}
	
}

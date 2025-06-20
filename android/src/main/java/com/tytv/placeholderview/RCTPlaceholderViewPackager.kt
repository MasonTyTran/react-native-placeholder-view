package com.tytv.placeholderview

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import com.facebook.react.uimanager.ViewManager

class RCTPlaceholderViewPackager : BaseReactPackage() {
    override fun createViewManagers(reactContext: ReactApplicationContext): List<ViewManager<*, *>> {
        return listOf(RCTPlaceholderViewManager(reactContext))
    }

    override fun getModule(s: String, reactContext: ReactApplicationContext): NativeModule? {
        when (s) {
            RCTPlaceholderViewManager.REACT_CLASS -> RCTPlaceholderViewManager(reactContext)
        }
        return null
    }

    override fun getReactModuleInfoProvider(): ReactModuleInfoProvider = ReactModuleInfoProvider {
        mapOf(RCTPlaceholderViewManager.REACT_CLASS to ReactModuleInfo(
            name = RCTPlaceholderViewManager.REACT_CLASS,
            className = RCTPlaceholderViewManager.REACT_CLASS,
            canOverrideExistingModule = false,
            needsEagerInit = false,
            isCxxModule = false,
            isTurboModule = true,
        )
        )
    }
}
package com.tytv.placeholderview

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewGroupManager
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.RNPlaceholderManagerDelegate
import com.facebook.react.viewmanagers.RNPlaceholderManagerInterface

@ReactModule(name = RCTPlaceholderViewManager.REACT_CLASS)
class RCTPlaceholderViewManager(context: ReactApplicationContext) : ViewGroupManager<RCTPlaceholderView>(), RNPlaceholderManagerInterface<RCTPlaceholderView> {
    private val delegate: RNPlaceholderManagerDelegate<RCTPlaceholderView, RCTPlaceholderViewManager> =
        RNPlaceholderManagerDelegate(this)

    override fun getDelegate(): ViewManagerDelegate<RCTPlaceholderView> = delegate

    override fun getName(): String = REACT_CLASS

    override fun createViewInstance(context: ThemedReactContext): RCTPlaceholderView = RCTPlaceholderView(context)

    companion object {
        const val REACT_CLASS = "RNPlaceholder"
    }

    @ReactProp(name = "shimmerColor")
    override fun setShimmerColor(view: RCTPlaceholderView?, value: String?) {
        value?.let {
            view?.setShimmerColor(android.graphics.Color.parseColor(it))
        }
    }

    @ReactProp(name = "highlightColor")
    override fun setHighlightColor(view: RCTPlaceholderView?, value: String?) {
        value?.let {
            view?.setHighlightColor(android.graphics.Color.parseColor(it))
        }
    }

    @ReactProp(name = "animationDuration")
    override fun setAnimationDuration(view: RCTPlaceholderView?, value: Double) {
        view?.setAnimationDuration(value.toLong())
    }

    @ReactProp(name = "shimmerDirection")
    override fun setShimmerDirection(view: RCTPlaceholderView?, value: String?) {
        value?.let {
            view?.setShimmerDirection(it)
        }
    }
}
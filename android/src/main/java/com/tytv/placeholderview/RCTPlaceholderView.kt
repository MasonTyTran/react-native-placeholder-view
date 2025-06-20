package com.tytv.placeholderview

import android.content.Context
import android.graphics.Color
import com.facebook.shimmer.Shimmer.ColorHighlightBuilder
import com.facebook.shimmer.ShimmerFrameLayout


class RCTPlaceholderView(context: Context) : ShimmerFrameLayout(context) {

    private val builder = ColorHighlightBuilder().setHighlightColor(Color.WHITE).setBaseColor(Color.LTGRAY)

    var didBuildShimmer = false

    override fun onSizeChanged(w: Int, h: Int, oldw: Int, oldh: Int) {
        super.onSizeChanged(w, h, oldw, oldh)
        if (didBuildShimmer) {
            return
        }
        didBuildShimmer = true
        updateShimmer()
    }

    private fun updateShimmer() {
        setShimmer(builder.build())
    }

    fun setShimmerColor(color: Int) {
        builder.setBaseColor(color)
        updateShimmer()
    }

    fun setHighlightColor(color: Int) {
        builder.setHighlightColor(color)
        updateShimmer()
    }

    fun setAnimationDuration(duration: Long) {
        builder.setDuration(duration)
        updateShimmer()
    }

    fun setShimmerDirection(value: String) {

        startShimmer()
    }
}

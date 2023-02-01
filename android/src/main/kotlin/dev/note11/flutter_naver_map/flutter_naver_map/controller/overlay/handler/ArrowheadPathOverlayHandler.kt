package dev.note11.flutter_naver_map.flutter_naver_map.controller.overlay.handler

import com.naver.maps.map.overlay.ArrowheadPathOverlay
import dev.note11.flutter_naver_map.flutter_naver_map.controller.overlay.OverlayHandler
import dev.note11.flutter_naver_map.flutter_naver_map.controller.overlay.OverlayHandler.Companion.getterName
import dev.note11.flutter_naver_map.flutter_naver_map.model.overlay.overlay.NArrowHeadPathOverlay
import io.flutter.plugin.common.MethodChannel

internal interface ArrowheadPathOverlayHandler : OverlayHandler {
    fun handleArrowheadPathOverlay(
        arrowheadPathOverlay: ArrowheadPathOverlay,
        method: String,
        arg: Any?,
        result: MethodChannel.Result,
    ) = when (method) {
        NArrowHeadPathOverlay.coordsName -> setCoords(arrowheadPathOverlay, arg!!)
        NArrowHeadPathOverlay.widthName -> setWidth(arrowheadPathOverlay, arg!!)
        NArrowHeadPathOverlay.colorName -> setColor(arrowheadPathOverlay, arg!!)
        NArrowHeadPathOverlay.outlineWidthName -> setOutlineWidth(arrowheadPathOverlay, arg!!)
        NArrowHeadPathOverlay.outlineColorName -> setOutlineColor(arrowheadPathOverlay, arg!!)
        NArrowHeadPathOverlay.elevationName -> setElevation(arrowheadPathOverlay, arg!!)
        NArrowHeadPathOverlay.headSizeRatioName -> setHeadSizeRatio(arrowheadPathOverlay, arg!!)
        getterName(NArrowHeadPathOverlay.boundsName) -> getBounds(arrowheadPathOverlay, result::success)
        else -> result.notImplemented()
    }

    fun setCoords(arrowheadPathOverlay: ArrowheadPathOverlay, rawCoords: Any)

    fun setWidth(arrowheadPathOverlay: ArrowheadPathOverlay, rawWidthDp: Any)

    fun setColor(arrowheadPathOverlay: ArrowheadPathOverlay, rawColor: Any)

    fun setOutlineWidth(arrowheadPathOverlay: ArrowheadPathOverlay, rawWidthDp: Any)

    fun setOutlineColor(arrowheadPathOverlay: ArrowheadPathOverlay, rawColor: Any)

    fun setElevation(arrowheadPathOverlay: ArrowheadPathOverlay, rawElevationDp: Any)

    fun setHeadSizeRatio(arrowheadPathOverlay: ArrowheadPathOverlay, rawRatio: Any)

    fun getBounds(
        arrowheadPathOverlay: ArrowheadPathOverlay,
        success: (bounds: Map<String, Any>) -> Unit,
    )
}
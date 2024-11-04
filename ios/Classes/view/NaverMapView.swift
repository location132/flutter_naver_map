import NMapsMap

internal class NaverMapView: NSObject, FlutterPlatformView {
    private let naverMap: NMFNaverMapView!
    private let naverMapViewOptions: NaverMapViewOptions
    private let naverMapControlSender: NaverMapControlSender
    private var eventDelegate: NaverMapViewEventDelegate!

    init(frame: CGRect, options: NaverMapViewOptions, channel: FlutterMethodChannel, overlayController: OverlayController) {
        naverMap = NMFNaverMapView(frame: frame)
        naverMapViewOptions = options
        naverMapControlSender = NaverMapController(naverMap: naverMap, channel: channel, overlayController: overlayController)
        super.init()

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.naverMapViewOptions.updateWithNaverMapView(naverMap: self.naverMap, isFirst: true)
            self.onMapReady()
        }
    }

    private func onMapReady() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.setMapTapListener()
            self.naverMapControlSender.onMapReady()
        }
    }

    private func setMapTapListener() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.eventDelegate = NaverMapViewEventDelegate(sender: self.naverMapControlSender,
                    initializeConsumeSymbolTapEvents: self.naverMapViewOptions.consumeSymbolTapEvents)
            self.eventDelegate.registerDelegates(mapView: self.naverMap.mapView)
        }
    }

    func view() -> UIView {
        var view: UIView!
        if Thread.isMainThread {
            view = naverMap
        } else {
            DispatchQueue.main.sync {
                view = naverMap
            }
        }
        return view
    }

    deinit {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            (self.naverMapControlSender as! NaverMapController).removeChannel()
        }
    }
}


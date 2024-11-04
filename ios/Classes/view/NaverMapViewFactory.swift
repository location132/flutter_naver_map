internal class NaverMapFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let queue = DispatchQueue.main

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
        setHttpConnectionMaximum()
    }

    func create(
            withFrame frame: CGRect,
            viewIdentifier viewId: Int64,
            arguments args: Any?
    ) -> FlutterPlatformView {
        var mapView: FlutterPlatformView!
        
        queue.sync {
            let channel = FlutterMethodChannel(name: SwiftFlutterNaverMapPlugin.createViewMethodChannelName(id: viewId), binaryMessenger: messenger)
            let overlayChannel = FlutterMethodChannel(name: SwiftFlutterNaverMapPlugin.createOverlayMethodChannelName(id: viewId), binaryMessenger: messenger)
            let overlayController = OverlayController(channel: overlayChannel)

            let convertedArgs = asDict(args!)
            let options = NaverMapViewOptions.fromMessageable(convertedArgs)

            mapView = NaverMapView(frame: frame, options: options, channel: channel, overlayController: overlayController)
        }
        
        return mapView
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    private func setHttpConnectionMaximum() {
        URLSession.shared.configuration.httpMaximumConnectionsPerHost = 8
    }
}

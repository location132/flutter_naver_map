internal class NaverMapFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    private let queue = DispatchQueue.main

    init(messenger: FlutterBinaryMessenger) {
        print("NaverMapFactory: init called")
        self.messenger = messenger
        super.init()
        setHttpConnectionMaximum()
    }

    func create(
            withFrame frame: CGRect,
            viewIdentifier viewId: Int64,
            arguments args: Any?
    ) -> FlutterPlatformView {
        print("NaverMapFactory: create method started")
        var mapView: FlutterPlatformView!
        
        queue.sync {
            print("NaverMapFactory: inside queue.sync")
            let channel = FlutterMethodChannel(name: SwiftFlutterNaverMapPlugin.createViewMethodChannelName(id: viewId), binaryMessenger: messenger)
            let overlayChannel = FlutterMethodChannel(name: SwiftFlutterNaverMapPlugin.createOverlayMethodChannelName(id: viewId), binaryMessenger: messenger)
            let overlayController = OverlayController(channel: overlayChannel)

            let convertedArgs = asDict(args!)
            let options = NaverMapViewOptions.fromMessageable(convertedArgs)

            mapView = NaverMapView(frame: frame, options: options, channel: channel, overlayController: overlayController)
            print("NaverMapFactory: mapView created")
        }
        
        print("NaverMapFactory: returning mapView")
        return mapView
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }

    private func setHttpConnectionMaximum() {
        URLSession.shared.configuration.httpMaximumConnectionsPerHost = 8
    }
}

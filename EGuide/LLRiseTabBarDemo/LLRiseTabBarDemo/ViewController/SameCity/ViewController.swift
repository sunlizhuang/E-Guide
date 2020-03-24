
import UIKit
import SceneKit
import MapKit
import ARCL

@available(iOS 11.0, *)

@objc class ViewController: UIViewController {
    
    
    
    
    
    let sceneLocationView = SceneLocationView()
    
    let mapView = MKMapView()
    var userAnnotation: MKPointAnnotation?
    var locationEstimateAnnotation: MKPointAnnotation?
    
    var updateUserLocationTimer: Timer?
    
    ///Whether to show a map view
    ///The initial value is respected
    var showMapView: Bool = false
    var Currlocation = CLLocation()
    var centerMapOnUserLocation: Bool = false
    
    ///Whether to display some debugging data
    ///This currently displays the coordinate of the best location estimate
    ///The initial value is respected
    var displayDebugging = false
    
    var infoLabel = UILabel()
    
    var updateInfoLabelTimer: Timer?
    
    var adjustNorthByTappingSidesOfScreen = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        infoLabel.font = UIFont.systemFont(ofSize: 10)
        infoLabel.textAlignment = .left
        infoLabel.textColor = UIColor.white
        infoLabel.numberOfLines = 0
        sceneLocationView.addSubview(infoLabel)
        
        updateInfoLabelTimer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(ViewController.updateInfoLabel),
            userInfo: nil,
            repeats: true)
        
        // Set to true to display an arrow which points north.
        //Checkout the comments in the property description and on the readme on this.
        //                sceneLocationView.orientToTrueNorth = true
        
        //        sceneLocationView.locationEstimateMethod = .coreLocationDataOnly
        sceneLocationView.showAxesNode = false
        sceneLocationView.locationDelegate = self
        
        if displayDebugging {
            sceneLocationView.showFeaturePoints = true
        }
        
        buildDemoData().forEach { sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: $0) }
        
        view.addSubview(sceneLocationView)
        
        if showMapView {
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .followWithHeading
            mapView.alpha = 0.8
            
            
            
            
            view.addSubview(mapView)
            
            
            
            updateUserLocationTimer = Timer.scheduledTimer(
                timeInterval: 0.5,
                target: self,
                selector: #selector(ViewController.updateUserLocation),
                userInfo: nil,
                repeats: true)
        }
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btn.backgroundColor = UIColor.clear
        btn.setTitle("返回", for: UIControlState.normal)
        btn.tintColor = UIColor.white
        btn.addTarget(self, action: #selector(ViewController.click), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn) ;
        
    }
    
    func click() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    //在参数加入目的地坐标 当前坐标应该在此函数中获取
    func getLine() -> () {
        let mydelegate = UIApplication.shared.delegate as! AppDelegate
        
        let toLocation = mydelegate.coo[0]
        
        let location = sceneLocationView.currentLocation()!
        
        //        let fromCoordinary = CLLocationCoordinate2DMake(39.0818500000,121.8175300000)
        let fromCoordinary = (location.coordinate)
        print("test!!!!!!!!!!!!!!")
        print(location.coordinate)
        
        let toCoordinary = (toLocation as! CLLocation).coordinate
        let fromPlaceMark = MKPlacemark(coordinate: fromCoordinary)
        let toPlaceMark = MKPlacemark(coordinate: toCoordinary)
        
        let fromItem = MKMapItem(placemark: fromPlaceMark)
        let toItem = MKMapItem(placemark: toPlaceMark)
        
        let request = MKDirectionsRequest()
        request.source = fromItem
        request.destination = toItem
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        
        
        directions.calculate { (response: MKDirectionsResponse?, error: Error?) in
            
            print(response!)
            
            if error == nil {
                
                for route in (response?.routes)!  {// MKRoute
                    print(route.advisoryNotices)//["需要步行至目的地。", "需要过收费站。"]
                    print(route.name, route.distance, route.expectedTravelTime)
                    // 当我们添加一个覆盖层数据模型时, 系统绘自动查找对应的代理方法, 找到对应的覆盖层"视图"
                    var pointArray:[CLLocationCoordinate2D] = []
                    let array = route.steps
                    for step in array {
                        pointArray.append(step.polyline.coordinate)
                    }
                    
                    
                    //                    route.polyline.coordinates
                    
                    
                    for  cor in (pointArray) {
                        print(cor.latitude,cor.longitude)
                        let node = self.buildNode(latitude: cor.latitude, longitude: cor.longitude, altitude: 0, imageName: "pin")
                        node.scaleRelativeToDistance = true
                        self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode:node)
                        
                        var quiverLength = 1.0
                        var quiverThickness = 5.0
                        
                        let newl = CLLocationCoordinate2D(latitude: cor.latitude-self.Currlocation.coordinate.latitude, longitude: cor.longitude-self.Currlocation.coordinate.longitude)
                        let a = cor.latitude-self.Currlocation.coordinate.latitude
                        let b = cor.longitude-self.Currlocation.coordinate.longitude
                        
                        quiverThickness = (quiverLength / 5.0) * quiverThickness
                        let chamferRadius = quiverThickness / 2.0
                        let xQuiverBox = SCNBox(width: CGFloat(quiverLength), height: CGFloat(quiverThickness), length:CGFloat(sqrt(a*a + b*b)*111111) , chamferRadius: CGFloat(chamferRadius))
                        xQuiverBox.firstMaterial?.diffuse.contents = UIColor.blue
                        let xQuiverNode = SCNNode(geometry: xQuiverBox)
                        xQuiverNode.position = SCNVector3Make(0.0,0.0,0.0)
                        
                        let lo = CLLocation.init(coordinate: cor, altitude: 1)
                        let quiverNode = LocationNode.init(location:lo)
                        print(quiverNode.eulerAngles.y)
                        quiverNode.eulerAngles.y -= Float(b) / (Float)((sqrt(a*a + b*b)))
                        print(quiverNode.eulerAngles.y)
                        
                        quiverNode.addChildNode(xQuiverNode)
                        self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: quiverNode )
                        self.Currlocation = CLLocation(coordinate: cor, altitude: 1)
                    }
                    
                    
                    
                }
                
            }
        }
        
        
        
        
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 100, 100)
        let searchRequest = MKLocalSearchRequest.init()
        searchRequest.region = region
        searchRequest.naturalLanguageQuery = "大连大学"
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { (response: MKLocalSearchResponse?, error: Error?) in
            //            print("response:",response)
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("run")
        sceneLocationView.run()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("pause")
        // Pause the view's session
        sceneLocationView.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
        
        infoLabel.frame = CGRect(x: 6, y: 0, width: self.view.frame.size.width - 12, height: 14 * 4)
        
        if showMapView {
            infoLabel.frame.origin.y = (self.view.frame.size.height / 2) - infoLabel.frame.size.height
        } else {
            infoLabel.frame.origin.y = self.view.frame.size.height - infoLabel.frame.size.height
        }
        
        mapView.frame = CGRect(
            x: 200,
            y: 410,
            width: 150,
            height: 150)
    }
    
    @objc func updateUserLocation() {
        guard let currentLocation = sceneLocationView.currentLocation() else {
            return
        }
        
        DispatchQueue.main.async {
            if let bestEstimate = self.sceneLocationView.bestLocationEstimate(),
                let position = self.sceneLocationView.currentScenePosition() {
                //                print("")
                //                print("Fetch current location")
                //                print("best location estimate, position: \(bestEstimate.position), location: \(bestEstimate.location.coordinate), accuracy: \(bestEstimate.location.horizontalAccuracy), date: \(bestEstimate.location.timestamp)")
                //                print("current position: \(position)")
                //
                //                let translation = bestEstimate.translatedLocation(to: position)
                //
                //                print("translation: \(translation)")
                //                print("translated location: \(currentLocation)")
                //                print("")
            }
            
            if self.userAnnotation == nil {
                self.userAnnotation = MKPointAnnotation()
                //                self.mapView.addAnnotation(self.userAnnotation!)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
                self.userAnnotation?.coordinate = currentLocation.coordinate
            }, completion: nil)
            
            //            if self.centerMapOnUserLocation {
            //                UIView.animate(withDuration: 0.45, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: {
            
            //                })
            //            }
            
            if self.displayDebugging {
                let bestLocationEstimate = self.sceneLocationView.bestLocationEstimate()
                
                if bestLocationEstimate != nil {
                    if self.locationEstimateAnnotation == nil {
                        self.locationEstimateAnnotation = MKPointAnnotation()
                        self.mapView.addAnnotation(self.locationEstimateAnnotation!)
                    }
                    
                    self.locationEstimateAnnotation!.coordinate = bestLocationEstimate!.location.coordinate
                } else {
                    if self.locationEstimateAnnotation != nil {
                        self.mapView.removeAnnotation(self.locationEstimateAnnotation!)
                        self.locationEstimateAnnotation = nil
                    }
                }
            }
        }
    }
    
    @objc func updateInfoLabel() {
        if let position = sceneLocationView.currentScenePosition() {
            infoLabel.text = "x: \(String(format: "%.2f", position.x)), y: \(String(format: "%.2f", position.y)), z: \(String(format: "%.2f", position.z))\n"
        }
        
        if let eulerAngles = sceneLocationView.currentEulerAngles() {
            infoLabel.text!.append("Euler x: \(String(format: "%.2f", eulerAngles.x)), y: \(String(format: "%.2f", eulerAngles.y)), z: \(String(format: "%.2f", eulerAngles.z))\n")
        }
        
        if let heading = sceneLocationView.locationManager.heading,
            let accuracy = sceneLocationView.locationManager.headingAccuracy {
            infoLabel.text!.append("Heading: \(heading)º, accuracy: \(Int(round(accuracy)))º\n")
        }
        
        let date = Date()
        let comp = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
        
        if let hour = comp.hour, let minute = comp.minute, let second = comp.second, let nanosecond = comp.nanosecond {
            infoLabel.text!.append("\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", second)):\(String(format: "%03d", nanosecond / 1000000))")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard
            let touch = touches.first,
            let touchView = touch.view
            else {
                return
        }
        
        if mapView == touchView || mapView.recursiveSubviews().contains(touchView) {
            centerMapOnUserLocation = false
        } else {
            let location = touch.location(in: self.view)
            
            if location.x <= 40 && adjustNorthByTappingSidesOfScreen {
                print("left side of the screen")
                sceneLocationView.moveSceneHeadingAntiClockwise()
            } else if location.x >= view.frame.size.width - 40 && adjustNorthByTappingSidesOfScreen {
                print("right side of the screen")
                //
                getLine()
                sceneLocationView.moveSceneHeadingClockwise()
            } else {
                let image = UIImage(named: "pin")!
                let annotationNode = LocationAnnotationNode(location: nil, image: image)
                annotationNode.scaleRelativeToDistance = true
                sceneLocationView.addLocationNodeForCurrentPosition(locationNode: annotationNode)
            }
        }
    }
}

public extension MKMultiPoint {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid,
                                              count: pointCount)
        
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        
        return coords
    }
}

// Given a MKRoute, you can just do:
// route.polyline.coordinates

// MARK: - MKMapViewDelegate
@available(iOS 11.0, *)
extension ViewController: MKMapViewDelegate {
    
    
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        if annotation is MKUserLocation {
    //            return nil
    //        }
    //
    //        guard let pointAnnotation = annotation as? MKPointAnnotation else {
    //            return nil
    //        }
    //
    //        let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: nil)
    //        marker.displayPriority = .required
    //
    //        if pointAnnotation == self.userAnnotation {
    //            marker.glyphImage = UIImage(named: "user")
    //
    //        } else {
    //            marker.markerTintColor = UIColor(hue: 0.267, saturation: 0.67, brightness: 0.77, alpha: 1.0)
    //            marker.glyphImage = UIImage(named: "compass")
    //        }
    //
    //
    //        return marker
    //    }
    
}

// MARK: - SceneLocationViewDelegate

@available(iOS 11.0, *)
extension ViewController: SceneLocationViewDelegate {
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
        print("add scene location estimate, position: \(position), location: \(location.coordinate), accuracy: \(location.horizontalAccuracy), date: \(location.timestamp)")
    }
    
    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
        print("remove scene location estimate, position: \(position), location: \(location.coordinate), accuracy: \(location.horizontalAccuracy), date: \(location.timestamp)")
    }
    
    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView, node: LocationNode) {
    }
    
    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView, sceneNode: SCNNode) {
        
    }
    
    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView, locationNode: LocationNode) {
        
    }
}

// MARK: - Data Helpers
@available(iOS 11.0, *)
private extension ViewController {
    func buildDemoData() -> [LocationAnnotationNode] {
        var nodes: [LocationAnnotationNode] = []
        
        // TODO: add a few more demo points of interest.
        // TODO: use more varied imagery.
        
        //        let spaceNeedle = buildNode(latitude: 47.6205, longitude: -122.3493, altitude: 225, imageName: "pin")
        //        nodes.append(spaceNeedle)
        ////
        //        let empireStateBuilding = buildNode(latitude: 40.7484, longitude: -73.9857, altitude: 14.3, imageName: "user")
        //        nodes.append(empireStateBuilding)
        //
        //        let canaryWharf = buildNode(latitude: 51.504607, longitude: -0.019592, altitude: 236, imageName: "pin")
        //        nodes.append(canaryWharf)
        //
        return nodes
    }
    
    func buildNode(latitude: CLLocationDegrees, longitude: CLLocationDegrees, altitude: CLLocationDistance, imageName: String) -> LocationAnnotationNode {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = CLLocation(coordinate: coordinate, altitude: altitude)
        let image = UIImage(named: imageName)!
        return LocationAnnotationNode(location: location, image: image)
    }
    
    
    
    
}

extension DispatchQueue {
    func asyncAfter(timeInterval: TimeInterval, execute: @escaping () -> Void) {
        self.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(timeInterval * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: execute)
    }
}

extension UIView {
    func recursiveSubviews() -> [UIView] {
        var recursiveSubviews = self.subviews
        
        for subview in subviews {
            recursiveSubviews.append(contentsOf: subview.recursiveSubviews())
        }
        
        return recursiveSubviews
    }
}


//
//  HomeItemTableViewCell.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import UIKit
import MapKit

class HomeItemTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var profileView: Lottie!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var phoneLabel: UILabel!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet weak var rootContentView: UIView!
    @IBOutlet weak var mapContentView: UIView!
    @IBOutlet weak var showMore: UIButton!
    
    private var animation: Lottie = Lottie()
    private var mapView: MKMapView = MKMapView()
    var userId: Int = 0
    var handleShowMore: ((_ userId: Int)->())?
    
    var animationName: String = "" {
        didSet {
            profileView.setupAnimation(animationName)
        }
    }
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var phone: String = "" {
       didSet {
        phoneLabel.text = phone
       }
    }
    
    var email: String = "" {
       didSet {
        emailLabel.text = email
       }
    }
    
    func setMapView(geo: Geo) {
        guard let lat = Double(geo.lat), let lng = Double(geo.lng) else { return }
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        mapView.centerToLocation(initialLocation)
        mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: profileView.bounds.height)
        mapContentView.addSubview(mapView)
        
        setPin(lat: lat, lng: lng)
    }
    
    func setPin(lat: Double, lng: Double) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        pin.title = name
        pin.subtitle = email
        mapView.addAnnotation(pin)
    }
    
    override func prepareForReuse() {
        emailLabel.text = ""
        phoneLabel.text = ""
        nameLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rootContentView.addShadow()
        showMore.addAction(for: .touchUpInside) {
            self.handleShowMore?(self.userId)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

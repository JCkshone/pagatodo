//
//  HeaderProfile.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import UIKit

class HeaderProfile: UIView {
    
    @IBOutlet weak var animationContentView: UIView!
    @IBOutlet fileprivate weak var userName: UILabel!
    @IBOutlet fileprivate weak var phoneNumber: UILabel!
    @IBOutlet fileprivate weak var userEmail: UILabel!
    
    private var animation: Lottie = Lottie()
    
    struct Constants {
        static let xibName = "HeaderProfile"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }

    private func loadViewFromNib() {
        let bundle = Bundle.init(for: HeaderProfile.self)
        if let viewsToAdd = bundle.loadNibNamed(Constants.xibName, owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
    }
    
    func setUserInfo(of user: User) {
        userName.text = user.name
        userEmail.text = user.email
        phoneNumber.text = user.phone
    }
    
    func setupAnimationView(animationName: String) {
        animation.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 32, height: animationContentView.bounds.height)
        animationContentView.addSubview(animation)
        animation.setupAnimation(animationName)
    }
}

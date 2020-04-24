//
//  EmptyResponse.swift
//  ceiba-test
//
//  Created by Jc on 23/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import Foundation
import UIKit

class EmptyResponse: UIView {
    
    @IBOutlet weak var animationContent: UIView!
    
    private var animation: Lottie = Lottie()
    
    struct Constants {
        static let xibName = "EmptyResponse"
        static let animation = "empty"
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
    
    func setupView(animationName: String? = Constants.animation){
        guard let animationName = animationName else { return }
        animation.frame = CGRect(x: 0, y: 0, width: animationContent.bounds.width, height: 200)
        animationContent.addSubview(animation)
        animation.setupAnimation(animationName)
    }
}

//
//  ViewController.swift
//  ProgressView
//
//  Created by Nayem on 6/4/18.
//  Copyright © 2018 Mufakkharul Islam Nayem. All rights reserved.
//

// https://stackoverflow.com/questions/50667566/

import UIKit

class ViewController: UIViewController {

    var stackView: UIStackView!
    var progressView: UIView!
    
    var progressViewWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressViews()
    }
    
    override func viewDidLayoutSubviews() {
        self.makeViewsReadyForAnimation()
    }
    
    func setupProgressViews() {
        let view1 = UIView()
        view1.backgroundColor = .purple
        // keep the reference of the view that will be used for progress animation
        progressView = view1
        
        let view2 = UIView()
        view2.backgroundColor = .gray
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading  // this will lead other ordinary views to have zero widths
        stackView.distribution = .fillEqually   // this is vertical filling. this will cause no harm while animating width only
        stackView.spacing = 8
        
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        
        view.addSubview(stackView)
        // auto-layout stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func makeViewsReadyForAnimation() {
        stackView.subviews.forEach { (view) in
            if view == progressView {
                // Explicitly setting zero width for the progress view. Because the width will be animated on an action
                progressViewWidthConstraint = view.widthAnchor.constraint(equalToConstant: 0)
                progressViewWidthConstraint.isActive = true
            } else {
                // The other views that won't have animation should be constrained as the equal widths of the stack view. This will in effect make the stack view to have as `fill` alignment without the progress view
                view.widthAnchor.constraint(equalToConstant: stackView.frame.size.width).isActive = true
            }
        }
    }

    @IBAction func animateButtonTapped(_ sender: UIButton) {
        view.layoutIfNeeded()
        // animate the progress view
        progressViewWidthConstraint.constant = stackView.frame.size.width
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }
    
}


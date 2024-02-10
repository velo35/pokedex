//
//  Scrubby.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/27/24.
//

import UIKit

class ScrubbyView: UIView
{
    var offset = 0.0
    let scrubby: UIView
    let scrollView: UIScrollView
    var scrubbyCenterY: NSLayoutConstraint!
    var startGestureY = 0.0
    var startCenterY = 0.0
    
    init(_ scrollView: UIScrollView)
    {
        self.scrubby = UIView()
        self.scrollView = scrollView
        
        super.init(frame: .zero)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        
        scrubby.backgroundColor = .red
        scrubby.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrubby)
        NSLayoutConstraint.activate([
            scrubby.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrubby.widthAnchor.constraint(equalToConstant: 60),
            scrubby.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        self.scrubbyCenterY = scrubby.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        self.scrubbyCenterY.isActive = true
        
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(panGesture))
        panGesture.minimumPressDuration = 0.0
        panGesture.delegate = self
        scrubby.addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) 
    {
        let scrollableHeight = self.scrollView.contentSize.height - self.scrollView.bounds.height
        if scrollableHeight > 0 {
            let unitY = self.scrollView.contentOffset.y / scrollableHeight
            self.scrubbyCenterY.constant = (self.bounds.height - 0.0) * unitY
        }
    }
    
    @objc func panGesture(_ panGesture: UILongPressGestureRecognizer)
    {
        let dy = panGesture.location(in: self).y - self.startGestureY
        let scrubbyY = max(0.0, min(self.bounds.height, self.startCenterY + dy))
        self.scrubbyCenterY.constant = scrubbyY
        
        let unitY = scrubbyY / self.bounds.height
        let y = (self.scrollView.contentSize.height - self.scrollView.bounds.height) * unitY
        
        self.scrollView.contentOffset = CGPoint(x: 0, y: y)
    }
}

extension ScrubbyView: UIGestureRecognizerDelegate
{
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        self.startGestureY = gestureRecognizer.location(in: self).y
        self.startCenterY = self.scrubbyCenterY.constant
        return true
    }
}

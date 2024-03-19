//
//  Scrubby.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/27/24.
//

import UIKit
import SwiftUI

class ScrubbyView: UIView
{
    var offset = 0.0
    let scrubby: UIView
    let scrollView: UIScrollView
    var scrubbyCenterX: NSLayoutConstraint!
    var scrubbyCenterY: NSLayoutConstraint!
    var startGestureY = 0.0
    var startCenterY = 0.0 // needed to calculate srubby Y position because drag may begin from any point in scrubby
    var longPressGestureRecognizer: UILongPressGestureRecognizer!
    var tapGestureRecognizer: UITapGestureRecognizer!
    var deactivateTimer: Timer?
    
    var scrubbyActive = false {
        didSet {
            if !self.scrubbyActive {
                self.deactivateTimer?.invalidate()
            }
            self.animateScrubby()
        }
    }
    
    let inset = 60.0
    
    init(_ scrollView: UIScrollView)
    {
        self.scrubby = UIHostingController(rootView: ScrubbyKnobView()).view
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
        
        scrubby.backgroundColor = .clear
        self.scrubby.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.scrubby)

        self.scrubbyCenterX = self.scrubby.centerXAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        self.scrubbyCenterX.isActive = true
        
        self.scrubbyCenterY = self.scrubby.centerYAnchor.constraint(equalTo: self.topAnchor, constant: self.inset)
        self.scrubbyCenterY.isActive = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGesture))
        longPressGesture.minimumPressDuration = 0.0
        longPressGesture.delegate = self
        self.scrubby.addGestureRecognizer(longPressGesture)
        self.longPressGestureRecognizer = longPressGesture
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.scrubby.addGestureRecognizer(tapGesture)
        self.tapGestureRecognizer = tapGesture
        
        self.updateScrubby()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScrubby()
    {
        self.longPressGestureRecognizer.isEnabled = self.scrubbyActive
        self.scrubbyCenterX.constant = self.scrubbyActive ? -5 : 15
    }
    
    func animateScrubby()
    {
        UIView.animate(withDuration: 1, 
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 12,
                       options: .allowUserInteraction) {
            self.updateScrubby()
            self.layoutIfNeeded()
        } completion: { _ in
            if self.scrubbyActive {
                self.startDeactivateTimer()
            }
        }
    }
    
    func startDeactivateTimer()
    {
        self.deactivateTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.scrubbyActive = false
        }
    }
    
    @objc override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) 
    {
        let scrollRange = self.scrollView.contentSize.height - self.scrollView.bounds.height
        if scrollRange > 0 {
            let scrollY = self.scrollView.contentOffset.y
            let scrubbyRange = self.bounds.height - 2 * self.inset
            self.scrubbyCenterY.constant = self.inset + scrubbyRange / scrollRange * scrollY
        }
    }
    
    @objc func longPressGesture(_ longPressGesture: UILongPressGestureRecognizer)
    {
        let dy = longPressGesture.location(in: self).y - self.startGestureY
        let scrubbyCenterY = max(self.inset, min(self.bounds.height - self.inset, self.startCenterY + dy))
        self.scrubbyCenterY.constant = scrubbyCenterY
        
        let scrollRange = self.scrollView.contentSize.height - self.scrollView.bounds.height
        let scrubbyRange = self.bounds.height - 2 * self.inset
        let scrollY = (scrubbyCenterY - self.inset) * scrollRange / scrubbyRange
        self.scrollView.contentOffset = CGPoint(x: 0, y: scrollY)
        
        self.deactivateTimer?.invalidate()
        if longPressGesture.state == .ended || longPressGesture.state == .cancelled {
            self.startDeactivateTimer()
        }
    }
    
    @objc func tapGesture()
    {
        self.scrubbyActive = !self.scrubbyActive
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if gestureRecognizer == self.longPressGestureRecognizer && otherGestureRecognizer == self.tapGestureRecognizer {
            return true
        }
        return false
    }
}

//
//  Extensions.swift
//  SpotlightLyrics
//
//  Created by Scott Rong on 2017/7/28.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit

extension CharacterSet {
    public static var quotes = CharacterSet(charactersIn: "\"'")
}

extension String {
    public func emptyToNil() -> String? {
        return self == "" ? nil : self
    }
    
    public func blankToNil() -> String? {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? nil : self
    }
}

extension UIResponder {
    
    public static func defaultBundle() -> Bundle {
        return Bundle(for: self)
    }
    
    public static func defaultNibName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
    private static var nibCache: [String: UINib] = [:]
    public static func defaultNib() -> UINib? {
        let nibName = defaultNibName()
        let bundle = defaultBundle()
        
        if let nib = nibCache[nibName] {
            return nib
        } else {
            if bundle.url(forResource: nibName, withExtension: "nib") != nil {
                let nib = UINib(nibName: nibName, bundle: bundle)
                nibCache[nibName] = nib
                return nib
            } else {
                return nil
            }
        }
    }
}

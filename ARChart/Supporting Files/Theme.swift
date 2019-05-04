//
//  Theme.swift
//  MPAD Plus
//
//  Created by Anan Ratanasethakul on 28/4/19.
//  Copyright © 2019 MBOX Multimedia Co., Ltd. All rights reserved.
//

import UIKit

let mainFontName = "Sukhumvit Set"
let lightFontName = "SukhumvitSet-Light"
let mediumFontName = "SukhumvitSet-Medium"

public protocol ThemeProtocol {
    var viewBackground: UIColor {get}
    var barBackground:UIColor {get}
    var barTitleFont:UIFont {get}
    var barTitleTint:UIColor {get}
    var barButtonFont:UIFont {get}
    var textBackground: UIColor {get}
    var tint: UIColor {get}
    var accent: UIColor {get set}
    
    
}
extension ThemeProtocol {
    public func applyTheme(vc: UIViewController) {
        //Statusbar
        vc.navigationController?.navigationBar.barStyle = self is LightTheme ? .default : .black
        
        let barTitleFont = UIFont(name: mainFontName, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .light)
        let barItemFont = UIFont(name: mainFontName, size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .light)

        let att = [NSAttributedString.Key.font: barItemFont, NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributes = [NSAttributedString.Key.font: barTitleFont, NSAttributedString.Key.foregroundColor: barTitleTint]
        vc.navigationController?.navigationBar.backgroundColor = .clear
        vc.navigationController?.navigationBar.barTintColor = barBackground
        vc.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        vc.editButtonItem.setTitleTextAttributes(att, for: .normal)
        vc.navigationController?.navigationItem.rightBarButtonItem?.setTitleTextAttributes(att, for: .normal)
        vc.navigationController?.navigationItem.leftBarButtonItem?.setTitleTextAttributes(att, for: .normal)
        vc.navigationController?.navigationBar.tintColor = barTitleTint

        vc.navigationController?.navigationBar.isTransperent = (self is TransparentTheme)
    }
}

class TransparentTheme: ThemeProtocol {
    var viewBackground: UIColor = .clear
    
    var barBackground: UIColor = .clear
    
    var barTitleFont: UIFont = UIFont(name: mainFontName, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .light)
    
    var barTitleTint: UIColor = .white
    
    var barButtonFont: UIFont = UIFont(name: mainFontName, size: 15) ?? UIFont.systemFont(ofSize: 18, weight: .light)
    
    var textBackground: UIColor = .clear
    
    var tint: UIColor = .white
    
    var accent: UIColor = .white
    
    init() {}
    
}

class LightTheme: ThemeProtocol {
    var viewBackground: UIColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
    
    var barBackground: UIColor = .white
    
    var barTitleFont: UIFont = UIFont(name: mainFontName, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .light)
    
    var barTitleTint: UIColor = .white
    
    var barButtonFont: UIFont = UIFont(name: mainFontName, size: 15) ?? UIFont.systemFont(ofSize: 18, weight: .light)
    
    var textBackground: UIColor = .white
    
    var tint: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    
    var accent: UIColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)

    init() {}
    
}



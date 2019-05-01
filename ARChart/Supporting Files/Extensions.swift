//
//  Extensions.swift
//  A-TOOLS
//
//  Created by Anan Ratanasethakul on 3/5/18.
//  Copyright © 2018 Anan Ratanasethakul. All rights reserved.
//

import SceneKit

struct Equilibrium {
    static let key = Equilibrium()
    private init() {}
    let xValue = "xValue"
    let yValue = "yValue"
    let zValue = "zValue"
    let xString = "xString"
    let yString = "yString"
    let zString = "zString"
    let refNode = "refNode"
}

enum ArrowType {
    case open
    case close
}

enum MemberSide {
    case NearEnd
    case FarEnd
}
extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}
enum MemberForceType {
    case tension
    case compression
    case zero
}
enum BeamMode: Int {
    case property
    case support
    case span
    case load
    case list
    case diagram
    case stiffness
    case stiffnessQ
    case stiffnessQF
    case pdf
}
enum BeamViewBG: Int {
    case light
    case dark
}
enum TextAlignment {
    case TopLeft
    case Top
    case TopRight
    case CenterLeft
    case Center
    case CenterRight
    case BottomLeft
    case Bottom
    case BottomRight
}

let lightBG = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
let darkBG = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)

let dofCL = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1)
let nonDofCL = UIColor.darkGray

struct BeamScale {
    var margin: CGFloat = 12
    var y0: CGFloat = 0
    var scaleX: CGFloat = 1
    var beamH: CGFloat = 5
    var rect: CGRect = .zero
    var minZoomScale: CGFloat = 1
    var maxZoomScale: CGFloat = 1
    var beamLength: CGFloat = 0
}

enum SupportType: Int16 {
    case hinge
    case fixed
    case free
    case gerber
    case spring
}
enum SupportLocation {
    case first
    case middle
    case last
}
enum LoadType: Int16 {
    case point
    case uniform
    case triangleR
    case triangleL
    case moment
}

extension Notification.Name {
    static let refreshRequired = Notification.Name("refresh_required")
    static let moduleSelected = Notification.Name("module_selected")
    
    //Beam
    static let supportTouched = Notification.Name("support_touched")
    static let spanTouched = Notification.Name("span_touched")
    static let loadTouched = Notification.Name("load_touched")
    
    //Truss & Frame
    static let nodeTouched = Notification.Name("node_touched")
    static let memberTouched = Notification.Name("member_touched")
    static let previewLoad = Notification.Name("preview_load")
    static let previewNode = Notification.Name("preview_node")
    static let previewMember = Notification.Name("preview_member")
    //Mat Lib
    static let sizeSorted = Notification.Name("size_sorted")
    static let materialChanged = Notification.Name("material_changed")
    
    //Sample
    static let startedDownload = Notification.Name("started_download")
    static let didDownload = Notification.Name("did_dowload")
}

extension UIColor {
    class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewDictionary))
    }
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    func addBorder(width: CGFloat, color: UIColor, radius: CGFloat) {
        clipsToBounds = true
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.cornerRadius = radius
    }
    
    func pin(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.8
        
    }
    func removeAllSubviews() {
        for v in subviews {
            v.removeFromSuperview()
        }
    }
    func roundedWithShadowColor(_ color: UIColor) {
        layer.shadowOpacity = 1
        layer.shadowColor = color.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = bounds.height/2
        layer.borderWidth = 0
    }
    func addShadowWithRoundedCorners() {
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 7
    }
}
enum BorderSide: Int {
    case left = 1
    case right = 2
    case top = 3
    case bottom = 4
}
extension UILabel {
    func textAnimateCounter(_ text: String, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -0.35*self.frame.height)
        }) { (_) in
            self.text = text
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {
                self.transform = .identity
            }, completion: nil)
        }
        
        
    }
    
    func border(side:BorderSide, width: CGFloat, color: UIColor) {
        switch side {
        case .left:
            let leftLayer = CALayer()
            leftLayer.frame = CGRect(x: 0, y: 0, width: width, height:self.frame.height)
            leftLayer.backgroundColor = color.cgColor
            self.layer.addSublayer(leftLayer)
        case .right:
            let rightLayer = CALayer()
            rightLayer.frame = CGRect(x: self.frame.width-width, y: 0, width: width, height: self.frame.height)
            rightLayer.backgroundColor = color.cgColor
            self.layer.addSublayer(rightLayer)
        case .top:
            let topLayer = CALayer()
            topLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
            topLayer.backgroundColor = color.cgColor
            self.layer.addSublayer(topLayer)
            break
        case .bottom:
            let bottomLayer = CALayer()
            bottomLayer.frame = CGRect(x: 0, y: self.frame.height-width, width: self.frame.width, height: width)
            bottomLayer.backgroundColor = color.cgColor
            self.layer.addSublayer(bottomLayer)
            break
        }
    }
    
    func shadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        layer.shadowOpacity = 0.8
    }
}
extension String {
    func convertDate(from fm1:String, to fm2:String) -> String {
        let df = DateFormatter()
        df.dateFormat = fm1
        if let date = df.date(from: self) {
            df.dateFormat = fm2
            return df.string(from: date)
        }
        return "invalid date"
    }
    func toNSString() -> NSString {
        return NSString(string: self)
    }
    func toDouble() -> Double {
        if let val = NumberFormatter().number(from: self)?.doubleValue {
            return val
        }
        return 0
    }
    func toFloat() -> Float {
        if let val = NumberFormatter().number(from: self)?.floatValue {
            return val
        }
        return 0
    }
    func toCGFloat() -> CGFloat {
        if let n = NumberFormatter().number(from: self)?.floatValue {
            return CGFloat(n)
        }
        return 0
    }
    func toInt() -> Int {
        if let val = (NumberFormatter().number(from: self)?.intValue) {
            return val
        }
        return 0
    }
    func toInt16() -> Int16 {
        if let val = (NumberFormatter().number(from: self)?.int16Value) {
            return val
        }
        return 0
    }
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1", "YES":
            return true
        case "False", "false", "no", "0", "NO":
            return false
        default:
            return nil
        }
    }
    var isNumeric : Bool {
        get {
            return Double(self) != nil
        }
    }
    func isInteger() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        print("\(self) = \(!self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil)")
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    func components(by: String) -> (c1: String?, c2: String?) {
        let comp = self.toNSString().components(separatedBy: by)
        let c1 = comp.first
        if comp.count > 1 {
            return (c1: c1, c2: comp[1])
        } else {
            return (c1: c1, c2: nil)
        }
    }
}
extension Int {
    func toString() -> String {
        let amtFormatter = NumberFormatter()
        amtFormatter.formatterBehavior = .behavior10_4
        amtFormatter.positiveFormat = "#,##0"
        
        return amtFormatter.string(from: NSNumber(value: self))!
    }
}
extension Double {
    var epsilon: Double {
        return 0.0000001
    }
    func getSign() -> String {
        return self >= 0.0 ? "+" : "-"
    }
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    func toNSString() -> NSString {
        return NSString(string: self.toString())
    }
    
    
    func toString() -> String {
        return "\(self)"
    }
}


extension Date {
    func toMedium() -> String {
        let dateFM = DateFormatter()
        dateFM.dateStyle = .medium
        return dateFM.string(from: self as Date)
    }
    
    func toLong() -> String {
        let dateFM = DateFormatter()
        dateFM.dateStyle = .long
        return dateFM.string(from: self as Date)
    }
    
}

extension CGPoint {
    func offset(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    func scaleBy(x:CGFloat, y:CGFloat) -> CGPoint {
        return CGPoint(x: self.x * x, y: self.y * y)
    }
    
}

extension SCNVector3 {
    func offset(_ x: Float, _ y: Float, _ z: Float) -> SCNVector3{
        return SCNVector3(self.x + x, self.y + y, self.z + z)
    }
    
    func distance(_ v2: SCNVector3) -> Float {
        let dx = v2.x - self.x
        let dy = v2.y - self.y
        let dz = v2.z - self.z
        return sqrt(dx*dx + dy*dy + dz*dz)
    }
}

extension UIImage {
    func scaleToSize(aSize :CGSize) -> UIImage {
        if (self.size.equalTo(aSize)) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(aSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: aSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self
    }
}

extension NSAttributedString {
    static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        
        let a = lhs.mutableCopy() as! NSMutableAttributedString
        let b = rhs.mutableCopy() as! NSMutableAttributedString
        
        a.append(b)
        
        return a.copy() as! NSAttributedString
    }
}

extension UITableViewCell {
    class var identification: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    class var identification: String {
        return String(describing: self)
    }
}


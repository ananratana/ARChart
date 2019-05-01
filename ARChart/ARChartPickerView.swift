//
//  ARPickerView.swift
//  Anapanasati
//
//  Created by Anan Ratanasethakul on 10/23/18.
//  Copyright © 2018 Anan Ratanasethakul. All rights reserved.
//

import UIKit


@IBDesignable
class ARChartPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    let colors:[UIColor] = [#colorLiteral(red: 0.9294117647, green: 0.137254902, blue: 0.1529411765, alpha: 1), #colorLiteral(red: 0.9589876533, green: 0.9207208753, blue: 0.06254418939, alpha: 1), #colorLiteral(red: 0.8433951139, green: 0.6270750761, blue: 0.7874693871, alpha: 1), #colorLiteral(red: 0.4156862745, green: 0.7450980392, blue: 0.2666666667, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.6, blue: 0.2274509804, alpha: 1), #colorLiteral(red: 0.2235294118, green: 0.7764705882, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0.7529411765, green: 0.4078431373, blue: 0.6666666667, alpha: 1)]
    lazy var pickerView: PickerViewX = {
        let pv = PickerViewX()
        pv.backgroundColor = .clear
        pv.selectorColor = UIColor.lightGray.withAlphaComponent(0.5)
        pv.dataSource = self
        pv.delegate = self
        return pv
    }()
    var rowHeight:CGFloat = 0
    var maxValue: CGFloat = 0
    var items: [ReadPlotData] = [] {
        didSet {
            maxValue = items.map({$0.toSeconds()}).max() ?? 1
            setupPickerView()
        }
    }
    //call back closure
    var onChartSelected: ((ReadPlotData)->())?
    
    fileprivate func setupPickerView() {
        if self.subviews.count == 0 {
            addSubview(pickerView)
            let rect = self.frame
            pickerView.transform = CGAffineTransform(rotationAngle: -90*(.pi/180))
            pickerView.reloadAllComponents()
            let w = UIDevice.current.userInterfaceIdiom == .phone ?  self.frame.width*0.75 : self.frame.width
            pickerView.frame = CGRect(x: -w/2, y: 0, width: rect.width + w, height: rect.height)
            //set hourScale
            pickerView.hourScale = (0.75*(pickerView.frame.height - 20))*3600/maxValue
        }
        self.backgroundColor = .clear
    }
}

extension ARChartPickerView {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.height
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        rowHeight = 35
        return rowHeight
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if items.count > 0, row < items.count {
            let item = items[row]
            let cv = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.frame.height, height: rowHeight))
            cv.clipsToBounds = true
            //Date label
            let x = (rowHeight - 20)/2
            let lblDate = UILabel(frame: CGRect(x: -x, y: x, width: 20 + 2*x, height: 20))
            lblDate.textColor = UIColor.white.withAlphaComponent(0.9)
            lblDate.text = item.ddmm
            lblDate.font = UIFont.systemFont(ofSize: 11, weight: .thin)
            lblDate.adjustsFontSizeToFitWidth = true
            lblDate.minimumScaleFactor = 0.5
            lblDate.backgroundColor = .clear
            lblDate.textAlignment = .center
            //chart
            let w = (0.75*(cv.frame.width - 20))*item.toSeconds()/maxValue
            let h = 0.25*rowHeight
            let lbl = UILabel()
            lbl.backgroundColor = colors[item.day]
            
            cv.addSubview(lbl)
            cv.addSubview(lblDate)
            cv.addConstraintsWithFormat(format: "H:|-20-[v0(\(w))]", views: lbl)
            cv.addConstraintsWithFormat(format: "V:|-\(h)-[v0]-\(h)-|", views: lbl)
            
            lblDate.transform = CGAffineTransform(rotationAngle: 90*(.pi/180))
            
            return cv
        }
        return UIView()
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let onSelected = onChartSelected, items.count > row {
            onSelected(items[row])
        }
    }
}

extension ARChartPickerView {
    func selectRow(_ row: Int, inComponet: Int, animated: Bool)  {
        pickerView.selectRow(row, inComponent: inComponet, animated: animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            //to highlight red text animated must be false
            self.pickerView.selectRow(row, inComponent: inComponet, animated: false)
            self.pickerView(self.pickerView, didSelectRow: row, inComponent: inComponet)
        }
        
    }
}

class PickerViewX: UIPickerView {
    @IBInspectable var selectorColor: UIColor? = nil
    var hourScale: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    //draw scale
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return}
        let att :[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        UIColor.darkGray.withAlphaComponent(0.75).setStroke()
        context.setLineWidth(0.5)
        context.translateBy(x: 20, y: frame.width/2)
        var n: Int = 0
        let is15MinuteMark = 15*hourScale/60 < frame.height
        let interval = is15MinuteMark ? 15 : 5
        
        while CGFloat(n)*hourScale/60.0 < frame.height {
            if n % interval == 0 {
                context.setLineWidth(1.5)
            } else {
                context.setLineWidth(0.5)
            }
            let w = CGFloat(n)*hourScale/60.0
            let p1 = CGPoint(x: w, y: -13)
            let p2 = CGPoint(x: w, y: 13)
            context.addLines(between: [p1, p2])
            context.drawPath(using: .stroke)
            
            if n % interval == 0 {
                let size = ("\(n)" as NSString).size(withAttributes: att)
                let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                context.saveGState()
                context.translateBy(x: w + size.height/2, y: 20)
                context.rotate(by: 90*(.pi/180))
                ("\(n)" as NSString).draw(in: rect, withAttributes: att)
                context.restoreGState()
            }
            n += (is15MinuteMark ? 5 : 1)
        }
        
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        if let color = selectorColor {
            if subview.bounds.height <= 1.0 {
                subview.backgroundColor = color
            }
        }
    }
}

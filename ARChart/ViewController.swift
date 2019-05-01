//
//  ViewController.swift
//  ARChart
//
//  Created by Anan Ratanasethakul on 17/4/19.
//  Copyright © 2019 Anan Ratanasethakul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pickerView: ARChartPickerView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelBooks: UILabel!
    @IBOutlet weak var labelPages: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelMinutes: UILabel!
    @IBOutlet weak var labelSeconds: UILabel!
    @IBOutlet weak var textViewInfo: UITextView!
    @IBOutlet weak var labelSum: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    @IBOutlet weak var vsEffect: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TransparentTheme().applyTheme(vc: self)
        
        vsEffect.alpha = 0.9
        textViewInfo.layer.cornerRadius = 7
        let fontSize: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 15:13
        let font =  UIFont(name: lightFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .light)
        let att:  [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        textViewInfo.attributedText = NSAttributedString(string: "⏱ ข้อมูลจาก NOP World Culture Score Index ระบุว่า ชาวอินเดียให้เวลากับการอ่านมากที่สุดในโลก 10.42 ชั่วโมงต่อคนต่อสัปดาห์ รองลงมาคือไทย 9.24 ชั่วโมง ตามด้วยจีน 8 ชั่วโมง ฟิลิปปินส์ 7.36 ชั่วโมง อียิปต์ 7.30 ชั่วโมง สาธารณรัฐเช็ก 7.24 ชั่วโมง รัสเซีย 7.06 ชั่วโมง ฝรั่งเศสและสวีเดนเท่ากันที่ 6.54 ชั่วโมง และซาอุดีอาระเบีย 6.48 ชั่วโมง", attributes: att)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let items = ReadData.samples()
        pickerView.items = items
        pickerView.onChartSelected = { (item) in
            self.labelDate.text = item.date
            self.labelDate.text = item.date
            self.labelBooks.textAnimateCounter("\(item.books)", duration: 0.3)
            self.labelPages.textAnimateCounter("\(item.pages)", duration: 0.3)
            self.labelHours.textAnimateCounter("\(item.hours)", duration: 0.3)
            self.labelMinutes.textAnimateCounter("\(item.minutes)", duration: 0.3)
            self.labelSeconds.textAnimateCounter("\(item.seconds)", duration: 0.3)
        }
        textViewInfo.scrollRangeToVisible(NSRange(location: 0, length: 0))
        //Stats
        if items.count > 0 {
            let sumSeconds = items.map{$0.toSeconds()}.reduce(0, +)
            let sumHours = Double(Int(100*sumSeconds/3600))/100
            let days = Double(items.count)
            let avgHours = Double(Int(100*7*sumHours/days))/100
            labelSum.textAnimateCounter(sumHours.toString(), duration: 0.4)
            labelAverage.textAnimateCounter(avgHours.toString(), duration: 0.4)
            //scroll to current date
            pickerView.selectRow(items.count - 1, inComponet: 0, animated: true)
        } else {
            labelDate.text =  "ยังไม่มีข้อมูลการอ่าน"
        }        
    }

}


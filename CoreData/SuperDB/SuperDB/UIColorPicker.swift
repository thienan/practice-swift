//
//  UIControlPicker.swift
//  SuperDB
//
//  Created by Domenico on 02/06/15.
//  Copyright (c) 2015 Domenico. All rights reserved.
//

import UIKit
import QuartzCore

let kTopBackgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
let kBottomBackgroundColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1)
class UIColorPicker: UIControl {

    var _color: UIColor!
    private var _redSlider: UISlider!
    private var _greenSlider: UISlider!
    private var _blueSlider: UISlider!
    private var _alphaSlider: UISlider!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        labelWithFrame(CGRectMake(20, 40, 60, 24), text: "Red")
        labelWithFrame(CGRectMake(20, 80, 60, 24), text: "Green")
        labelWithFrame(CGRectMake(20, 120, 60, 24), text: "Blue")
        labelWithFrame(CGRectMake(20, 160, 60, 24), text: "Alpha")
        
        let theFunc = "sliderChanged:"
        self._redSlider = createSliderWithAction(CGRectMake(100, 40, 190, 24), function: theFunc)
        self._greenSlider = createSliderWithAction(CGRectMake(100, 80, 190, 24), function: theFunc)
        self._blueSlider = createSliderWithAction(CGRectMake(100, 120, 190, 24), function: theFunc)
        self._alphaSlider = createSliderWithAction(CGRectMake(100, 160, 190, 24), function: theFunc)
    }
    
    private func labelWithFrame(frame: CGRect, text: String){
        let label = UILabel(frame: frame)
        label.userInteractionEnabled = false
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
        label.textAlignment = NSTextAlignment.Right
        label.textColor = UIColor.darkTextColor()
        label.text = text
        self.addSubview(label)
    }
    
    func createSliderWithAction(frame: CGRect, function: String)->UISlider{
        let _slider = UISlider(frame: frame)
        _slider.addTarget(self, action: Selector(function), forControlEvents: .ValueChanged)
        self.addSubview(_slider)
        
        return _slider
    }
    
    override func drawRect(rect: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [kTopBackgroundColor.CGColor, kBottomBackgroundColor.CGColor]
        self.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    //MARK: - Property Overrides
    var color: UIColor{
        get { return _color}
        set {
            _color = newValue
            let components = CGColorGetComponents(_color.CGColor)
            
            _redSlider.setValue(Float(components[0]), animated: true)
            _greenSlider.setValue(Float(components[1]), animated: true)
            _blueSlider.setValue(Float(components[2]), animated: true)
            _alphaSlider.setValue(Float(components[3]), animated: true)
        }
    }
    
    //MARK: - (Private) Instance Methods
    @IBAction func sliderChanged(sender: AnyObject){
        color = UIColor(red: CGFloat(_redSlider.value),
            green: CGFloat(_greenSlider.value),
            blue: CGFloat(_blueSlider.value),
            alpha: CGFloat(_alphaSlider.value))
        self.sendActionsForControlEvents(.ValueChanged)
    }
    
}

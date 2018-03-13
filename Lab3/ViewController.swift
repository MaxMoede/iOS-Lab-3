//
//  ViewController.swift
//  Lab3
//
//  Created by Max Moede on 1/17/18.
//  Copyright © 2018 Max Moede. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var citiesDict = [String:[String]]()
    var listOfCities = [String]()
    var atasco = [String]()
    var sanLuis = [String]()
    var arroyo = [String]()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var rLabel: UILabel!
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return listOfCities.count
        } else if component == 1 {
            return atasco.count
        }
        return 0
    }
    
    @IBAction func getYelpHelp(_ sender: UIButton) {
        let cityI = pickerView.selectedRow(inComponent: 0)
        let restI = pickerView.selectedRow(inComponent: 1)
       
        let cityName = listOfCities[cityI]
        let restName = citiesDict[listOfCities[pickerView.selectedRow(inComponent: 0)]]?.sorted()[restI]
        rLabel.text = "In " + cityName + " Eat at " + restName! + "."
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return listOfCities[row]
        }
        else if component == 1 {
            return citiesDict[listOfCities[pickerView.selectedRow(inComponent: 0)]]?.sorted()[row]
        }
        
        return "!!!"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        let cityI = pickerView.selectedRow(inComponent: 0)
        let restI = pickerView.selectedRow(inComponent: 1)
        
        let cityName = listOfCities[cityI]
        let restName = citiesDict[listOfCities[pickerView.selectedRow(inComponent: 0)]]?.sorted()[restI]
        rLabel.text = "In " + cityName + " Eat at " + restName! + "."
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        citiesDict = getDictionary()
        listOfCities = Array(citiesDict.keys).sorted()
        atasco = citiesDict["Atascadero"]!.sorted()
        arroyo = citiesDict["Arroyo Grande"]!.sorted()
        sanLuis = citiesDict["San Luis Obispo"]!.sorted()
        let cityI = pickerView.selectedRow(inComponent: 0)
        let restI = pickerView.selectedRow(inComponent: 1)
        
        let cityName = listOfCities[cityI]
        let restName = citiesDict[listOfCities[pickerView.selectedRow(inComponent: 0)]]?.sorted()[restI]
        rLabel.text = "In " + cityName + " Eat at " + restName! + "."
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func getDictionary() -> [String:[String]]{
        var dictToReturn = [String:[String]]()
        if let url = Bundle.main.url(forResource:"Restaurants", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:url)
                let tempDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:[String]]
                dictToReturn = tempDict
                
            } catch {
                print(error)
            }
        }
        return dictToReturn
        //write the rest of the code here
    }

}


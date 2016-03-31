//
//  GraphViewController.swift
//  EndProject
//
//  Created by Alexis Von Doom on 31/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController, ChartViewDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var lineChartView: LineChartView!
    let months = ["jan", "feb", "mar", "apr", "may", "june", "august","sept","oct","nov","dec"]
    let dollars1 = [1452.0,2353,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lineChartView.delegate = self
        self.lineChartView.descriptionText = "Tap node for details"
        
        self.lineChartView.descriptionTextColor = UIColor.whiteColor()
        self.lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        
        self.lineChartView.noDataText = "No data provided"
        

        
        setChartData(months)
        
        

    }
    
    func setChartData(months: [String]) {
        
        // creating an array of data entries
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for var i = 0; i < months.count; i++ {
            
            yVals1.append(ChartDataEntry(value: dollars1[i], xIndex: i))
        }
        
        //create a data set with array
        
        let set1: LineChartDataSet = LineChartDataSet(yVals: yVals1, label: "First Set")
        set1.axisDependency = .Left // Line will relate left axis
        set1.setColor(UIColor.redColor().colorWithAlphaComponent(0.5))//line opacity 50%     
        set1.setCircleColor(UIColor.redColor()) //dark red circle
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = UIColor.redColor()
        set1.highlightColor = UIColor.whiteColor()
        set1.drawCircleHoleEnabled = true
        
        // create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        // pass the data x-axis label value along with  dataSet
        let data: LineChartData = LineChartData(xVals: months, dataSets: dataSets)
        data.setValueTextColor(UIColor.whiteColor())
        
        self.lineChartView.data = data
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    let category = ["food","electricty", "misc", "repair"]
    var amount = [Double]()
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        amount = loadExpenses()
        
        self.lineChartView.delegate = self
        self.lineChartView.descriptionText = "Tap node for details"
        
        self.lineChartView.descriptionTextColor = UIColor.whiteColor()
        self.lineChartView.gridBackgroundColor = UIColor.darkGrayColor()
        
        self.lineChartView.noDataText = "No data provided"
        

        
        setChartData(category)
        
        

    }
    
    func setChartData(category: [String]) {
        
        // creating an array of data entries
        
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for var i = 0; i < category.count; i++ {
            
            yVals1.append(ChartDataEntry(value: amount[i], xIndex: i))
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
        let data: LineChartData = LineChartData(xVals: category, dataSets: dataSets)
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
    
    func loadExpenses() -> [Double] {
        
        
        let food = NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURLFood!.path!) as? [Expense]
        
        let electricity = NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURLElec!.path!) as? [Expense]
        
        let repair = NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURLRepair!.path!) as? [Expense]
        
        
        let misc = NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURL!.path!) as? [Expense]
        
        var foodD = 0.0
        var elecD = 256.0
        var repairD = 123.0
        var miscD = 56.0
        
        for var i = 0; i < food!.count; i++ {
            foodD += food![i].amount
            
        }
        
       /*for var i = 0; i < electricity!.count; i++ {
            elecD += electricity![i].amount
            
        }*/
       /* for var i = 0; i < repair!.count; i++ {
            repairD += repair![i].amount
            
        }*/
        
        /*for var i = 0; i < misc!.count; i++ {
            miscD += misc![i].amount
            
        }*/
        
        let test = [foodD, elecD, miscD, repairD]
        
        return test
    
    }

}

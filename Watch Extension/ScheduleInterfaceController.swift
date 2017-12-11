//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by Harsh Shah on 2017-11-30.
//  Copyright © 2017 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {
    @IBOutlet var flightTable: WKInterfaceTable!
    var flights = Flight.allFlights()
  var selectedIndex = 0
  
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
      flightTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
        // Configure interface objects here.
      for index in 0..<flightTable.numberOfRows {
        guard let controller = flightTable.rowController(at: index) as? FlightRowController else { continue }
        
        controller.flight = flights[index]
      }
  }
  override func didAppear() {
    super.didAppear()
    // 1
    guard flights[selectedIndex].checkedIn,
      let controller = flightTable.rowController(at: selectedIndex) as? FlightRowController else {
        return
    }
    
    // 2
    animate(withDuration: 0.35) {
      // 3
      controller.updateForCheckIn()
    }
  }
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    let controllers = ["Flight", "CheckIn"]
    presentController(withNames: controllers, contexts: [flight, flight])
    selectedIndex = rowIndex
  }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

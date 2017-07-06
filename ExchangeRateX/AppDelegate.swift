//
//  AppDelegate.swift
//  ExchangeRateX
//
//  Created by Jonny on 7/6/17.
//  Copyright © 2017 Jonny. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	private let url = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDCNY%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")!
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		
	}
	

}


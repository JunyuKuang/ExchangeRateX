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
	
	private let statusItem: NSStatusItem = {
		let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
		statusItem.button?.title = "ExchangeRateX"
		
		let menu = NSMenu()
		let refreshItem = NSMenuItem(title: "Refresh", action: #selector(tapRefreshMenuItem), keyEquivalent: "R")
		let exitItem = NSMenuItem(title: "Exit", action: #selector(tapExitMenuItem), keyEquivalent: "Q")
		menu.addItem(refreshItem)
		menu.addItem(exitItem)
		statusItem.menu = menu
		
		return statusItem
	}()
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		refresh()
		Timer.scheduledTimer(timeInterval: 10 * 60, target: self, selector: #selector(refresh), userInfo: nil, repeats: true)
	}
	
	@objc private func refresh() {
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			if let data = data {
				do {
					let query = try JSONDecoder().decode(ExchangeRateQuery.self, from: data)
					let exchangeRate = query.query.results.rate
					DispatchQueue.main.async {
						self.updateUI(with: exchangeRate)
					}
				} catch {
					print(error)
					DispatchQueue.main.async {
						let alert = NSAlert(error: error)
						alert.runModal()
					}
				}
			} else if let error = error {
				print(error)
				DispatchQueue.main.async {
					let alert = NSAlert(error: error)
					alert.runModal()
				}
			}
			}.resume()
	}
	
	private func updateUI(with rate: ExchangeRate) {
		guard let rateDoubleValue = Double(rate.rate) else { return }
		statusItem.button?.title = String(format: " $1 = ¥%.3f ", rateDoubleValue)
		
//		let menu = NSMenu()
//		let items = [NSMenuItem(title: "Updated at " + DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium), action: nil, keyEquivalent: "")]
//			+ [NSMenuItem.separator()]
//			+ forecastMenuItems
//			+ [NSMenuItem.separator()]
//			+ aqiMenuItems
//			+ [NSMenuItem.separator()]
//			+ [NSMenuItem(title: "Refresh", action: #selector(tapRefreshMenuItem), keyEquivalent: "R"),
//			   NSMenuItem(title: "Exit", action: #selector(tapExitMenuItem), keyEquivalent: "Q")]
//
//		items.forEach(menu.addItem)
//		statusItem.menu = menu
	}
	
	@objc private func tapGeneralItem(_ sender: NSMenuItem) {}
	
	@objc private func tapRefreshMenuItem(_ sender: NSMenuItem) {
		refresh()
	}
	
	@objc private func tapExitMenuItem(_ sender: NSMenuItem) {
		NSApp.terminate(self)
	}

}


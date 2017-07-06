//
//  ExchangeRateModels.swift
//  ExchangeRateX
//
//  Created by Jonny on 7/6/17.
//  Copyright © 2017 Jonny. All rights reserved.
//

import Foundation

// e.g.
//{"query":{"count":1,"created":"2017-07-06T10:45:15Z","lang":"en-us","results":{"rate":{"id":"USDCNY","Name":"USD/CNY","Rate":"6.8020","Date":"7/6/2017","Time":"11:05am","Ask":"6.8041","Bid":"6.8020"}}}}

struct ExchangeRateQuery : Codable {
	let query: ExchangeRateFetchResults
	
	struct ExchangeRateFetchResults : Codable {
		let results: ExchangeRateFetchResult
		
		struct ExchangeRateFetchResult : Codable {
			let rate: ExchangeRate
		}
	}
}

struct ExchangeRate : Codable {
	let id: String
	let name: String
	let rate: String
	let date: String
	let time: String
	let ask: String
	let bid: String
	
	private enum CodingKeys : String, CodingKey {
		case id
		case name = "Name"
		case rate = "Rate"
		case date = "Date"
		case time = "Time"
		case ask = "Ask"
		case bid = "Bid"
	}
}

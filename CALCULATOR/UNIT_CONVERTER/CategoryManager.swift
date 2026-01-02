//
//  CategoryManager.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 15/10/2024.
//

import Foundation

class CategoryManager {
    
    static func getIcon(category: Category) -> String {
        switch category {
        case .lenght:
            return "ruler"
            
        case .mass:
            return "scalemass"
            
        case .area:
            return "map"
            
        case .volume:
            return "cube"
            
        case .temperature:
            return "thermometer"
            
        case .pressure:
            return "hammer"
            
        case .angle:
            return "arrowtriangle.up"
            
        case .speed:
            return "speedometer"
            
        case .duration:
            return "clock"
            
        case .energy:
            return "flame"
            
        case .electricity:
            return "bolt"
            
        case .Frequency:
            return "waveform.path.ecg"
            
        case .STorage:
            return "opticaldisc"
        }
    }
    
    static func getInfo(categoty: Category) -> String {
        switch categoty {
        case .angle:
            return "rev: revolutions\n°: degrees\nrad: radians\nʹ: arc minutes\nʺ: arc seconds"
            
        case .lenght:
            return "Mm: megameters\nkm: kilometers\nhm: hectometers\ndam: decameters\nm: meters\ndm: decimeters\ncm: centimeters\nmm: millimeters\nµm: micrometers\nnm: nanometers\npm: picometers\nly: lightyears\nua: astronomical units\npc: parsecs\nNM: nautical miles\nmi: miles\nsmi: scandinavian miles\nyd: yards\nft: feet\nin: inches\nftm: fathoms"
            
        case .mass:
            return "t: metric tons\nkg: kilograms\ng: grams\ndg: decigrams\ncg: centigrams\nmg: milligrams\nµg: micrograms\nng: nanograms\npg: picograms\nton: short tons\nst: stones\nlb: pounds\noz: ounces\noz t: troy ounces\nslug: slugs\nct: carats"
            
        case .area:
            return "Mm²: square megameters\nkm²: square kilometers\nm²: square meters\ncm²: square centimeters\nmm²: square millimeters\nnm²: square nanometers\nmi²: square miles\nac: acres\nha: hectares\na: ares\nyd²: square yards\nft²: square feet\nin²: square inches"
            
        case .volume:
            return "ML: megaliters\nkL: kiloliters\nL: liters\ndL: deciliters\ncL: centiliters\nmL: milliliters\nkm³: cubic kilometers\nm³: cubic meters\ndm³: cubic decimeters\ncm³: cubic centimeters\nmm³: cubic millimeters\nmi³: cubic miles\naf: acre feet\nbsh: bushels\nyd³: cubic yards\nft³: cubic feet\nin³: cubic inches\ngal: gallons\nqt: quarts\npt: pints\ncup: cups\nfl oz: fluid ounces\ntbsp: tablespoons\ntsp: teaspoons\ngal: imperial gallons\nqt: imperial quarts\npt: imperial pints\nfl oz: imperial fluid ounces\ntbsp: imperial tablespoons\ntsp: imperial teaspoons\nmetric cup: metric cups"
            
        case .temperature:
            return "K: kelvin\n°C: celsius\n°F: fahrenheit"
            
        case .pressure:
            return "N/m²: newtons per meters squared\nGPa: gigapascals\nMPa: megapascals\nkPa: kilopascals\nhPa: hectopascals\nbar: bars\nmbar: millibars\ninHg: inches of mercury\nmmHg: millimeters of mercury\npsi: pounds force per square inch"
            
        case .speed:
            return "m/s: meters per second\nkm/h: kilometers per hour\nmph: miles per hour\nkn: knots"
            
        case .duration:
            return "hr: hours\nmin: minutes\ns: seconds\nms: milliseconds\nµs: microseconds\nns: nanoseconds\nps: picoseconds"
            
        case .energy:
            return "J: joules\nkJ: kilojoules\ncal: calories\nkCal: kilocalories\nkWh: kilowatt hours"
            
        case .electricity:
            return "MA: megaamperes\nkA: kiloamperes\nA: amperes\nmA: milliamperes\nµA: microamperes\nMV: megavolts\nkV: kilovolts\nV: volts\nmV: millivolts\nµV: microvolts\nMΩ: megaohms\nkΩ: kiloohms\nΩ: ohms\nmΩ: milliohms\nµΩ: microohms"
            
        case .Frequency:
            return "THz: terahertz\nGHz: gigahertz\nMHz: megahertz\nkHz: kilohertz\nHz: hertz\nmHz: millihertz\nµHz: microhertz\nnHz: nanohertz\nfps: frames per second"
            
        case .STorage:
            return "YB: yottabytes\nZB: zettabytes\nPB: petabytes\nTB: terabytes\nGB: gigabytes\nMB: megabytes\nkB: kilobytes\nB: bytes\nbit: bits"
        }
    }
}




//Mm²: square megameters\nkm²: square kilometers\nm²: square meters\ncm²: square centimeters\nmm²: square millimeters\nnm²: square nanometers\nmi²: square miles\nac: acres\nha: hectares\na: ares\nyd²: square yards\nft²: square feet\nin²: square inches








//Mm: megameters\nkm: kilometers\nhm: hectometers\ndam: decameters\nm: meters\ndm: decimeters\ncm: centimeters\nmm: millimeters\nµm: micrometers\nnm: nanometers\npm: picometers\nly: lightyears\nua: astronomical units\npc: parsecs\nNM: nautical miles\nmi: miles\nsmi: scandinavian miles\nyd: yards\nft: feet\nin: inches\nftm: fathoms








//N/m²: newtons per meters squared\nGPa: gigapascals\nMPa: megapascals\nkPa: kilopascals\nhPa: hectopascals\nbar: bars\nmbar: millibars\ninHg: inches of mercury\nmmHg: millimeters of mercury\npsi: pounds force per square inch











//K: kelvin\n°C: celsius\n°F: fahrenheit








//
//ML: megaliters\nkL: kiloliters\nL: liters\ndL: deciliters\ncL: centiliters\nmL: milliliters\nkm³: cubic kilometers\nm³: cubic meters\ndm³: cubic decimeters\ncm³: cubic centimeters\nmm³: cubic millimeters\nmi³: cubic miles\naf: acre feet\nbsh: bushels\nyd³: cubic yards\nft³: cubic feet\nin³: cubic inches\ngal: gallons\nqt: quarts\npt: pints\ncup: cups\nfl oz: fluid ounces\ntbsp: tablespoons\ntsp: teaspoons\ngal: imperial gallons\nqt: imperial quarts\npt: imperial pints\nfl oz: imperial fluid ounces\ntbsp: imperial tablespoons\ntsp: imperial teaspoons\nmetric cup: metric cups















//t: metric tons\nkg: kilograms\ng: grams\ndg: decigrams\ncg: centigrams\nmg: milligrams\nµg: micrograms\nng: nanograms\npg: picograms\nton: short tons\nst: stones\nlb: pounds\noz: ounces\noz t: troy ounces\nslug: slugs\nct: carats










//rev: revolutions\n°: degrees\nrad: radians\nʹ: arc minutes\nʺ: arc seconds








//m/s: meters per second\nkm/h: kilometers per hour\nmph: miles per hour\nkn: knots






//hr: hours\nmin: minutes\ns: seconds\nms: milliseconds\nµs: microseconds\nns: nanoseconds\nps: picoseconds







//J: joules\nkJ: kilojoules\ncal: calories\nkCal: kilocalories\nkWh: kilowatt hours





//MA: megaamperes\nkA: kiloamperes\nA: amperes\nmA: milliamperes\nµA: microamperes\nMV: megavolts\nkV: kilovolts\nV: volts\nmV: millivolts\nµV: microvolts\nMΩ: megaohms\nkΩ: kiloohms\nΩ: ohms\nmΩ: milliohms\nµΩ: microohms





//THz: terahertz\nGHz: gigahertz\nMHz: megahertz\nkHz: kilohertz\nHz: hertz\nmHz: millihertz\nµHz: microhertz\nnHz: nanohertz\nfps: frames per second







//YB: yottabytes\nZB: zettabytes\nPB: petabytes\nTB: terabytes\nGB: gigabytes\nMB: megabytes\nkB: kilobytes\nB: bytes\nbit: bits






//
//  DetailViewModel.swift
//  CALCULATOR_2
//
//  Created by Hung Nguyen on 15/10/2024.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published var firstUnit = 0
    @Published var firstUnitValue = ""
    @Published var secondUnit = 1
    @Published var secondUnitValue = ""
    @Published var showingInfo = false
    
    var units: [Dimension] {
        return selectedtUnits(category: category)
    }
    
    var category: Category
    
    init(category: Category) {
        self.category = category
    }
    

    func convert<T: Dimension>(value: String, unit1: T, unit2: T) -> String {
        let measurementValue = Measurement(value: (Double(value) ?? 0), unit: unit1).converted(to: unit2).value

        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0

        // Định dạng kết quả
        if let formattedResult = formatter.string(from: NSNumber(value: measurementValue)) {
            return formattedResult
        }
        else {
            return ""
        }
    }
    
    func selectedtUnits(category: Category) -> [Dimension] {
        switch category {
            case .area:
                return [UnitArea.squareMegameters,
                        UnitArea.squareKilometers,
                        UnitArea.squareMeters,
                        UnitArea.squareCentimeters,
                        UnitArea.squareMillimeters,
                        UnitArea.squareNanometers,
                        UnitArea.squareMiles,
                        UnitArea.acres,
                        UnitArea.hectares,
                        UnitArea.ares,
                        UnitArea.squareYards,
                        UnitArea.squareFeet,
                        UnitArea.squareInches] as [Dimension]
                
            case .lenght:
                return [UnitLength.megameters,
                        UnitLength.kilometers,
                        UnitLength.hectometers,
                        UnitLength.decameters,
                        UnitLength.meters,
                        UnitLength.decimeters,
                        UnitLength.centimeters,
                        UnitLength.millimeters,
                        UnitLength.micrometers,
                        UnitLength.nanometers,
                        UnitLength.picometers,
                        UnitLength.lightyears,
                        UnitLength.astronomicalUnits,
                        UnitLength.parsecs,
                        UnitLength.nauticalMiles,
                        UnitLength.miles,
                        UnitLength.scandinavianMiles,
                        UnitLength.yards,
                        UnitLength.feet,
                        UnitLength.inches,
                        UnitLength.fathoms] as [Dimension]
                
            case .pressure:
                return [UnitPressure.newtonsPerMetersSquared,
                        UnitPressure.gigapascals,
                        UnitPressure.megapascals,
                        UnitPressure.kilopascals,
                        UnitPressure.hectopascals,
                        UnitPressure.bars,
                        UnitPressure.millibars,
                        UnitPressure.inchesOfMercury,
                        UnitPressure.millimetersOfMercury,
                        UnitPressure.poundsForcePerSquareInch] as [Dimension]
                
            case .temperature:
                return [UnitTemperature.kelvin,
                        UnitTemperature.celsius,
                        UnitTemperature.fahrenheit] as [Dimension]
                
            case .volume:
                return [UnitVolume.megaliters,
                        UnitVolume.kiloliters,
                        UnitVolume.liters,
                        UnitVolume.deciliters,
                        UnitVolume.centiliters,
                        UnitVolume.milliliters,
                        UnitVolume.cubicKilometers,
                        UnitVolume.cubicMeters,
                        UnitVolume.cubicDecimeters,
                        UnitVolume.cubicCentimeters,
                        UnitVolume.cubicMillimeters,
                        UnitVolume.cubicMiles,
                        UnitVolume.acreFeet,
                        UnitVolume.bushels,
                        UnitVolume.cubicYards,
                        UnitVolume.cubicFeet,
                        UnitVolume.cubicInches,
                        UnitVolume.gallons,
                        UnitVolume.quarts,
                        UnitVolume.pints,
                        UnitVolume.cups,
                        UnitVolume.fluidOunces,
                        UnitVolume.tablespoons,
                        UnitVolume.teaspoons,
                        UnitVolume.imperialGallons,
                        UnitVolume.imperialQuarts,
                        UnitVolume.imperialPints,
                        UnitVolume.imperialFluidOunces,
                        UnitVolume.imperialTablespoons,
                        UnitVolume.imperialTeaspoons,
                        UnitVolume.metricCups] as [Dimension]
                
            case .mass:
                return [UnitMass.metricTons,
                        UnitMass.kilograms,
                        UnitMass.grams,
                        UnitMass.decigrams,
                        UnitMass.centigrams,
                        UnitMass.milligrams,
                        UnitMass.micrograms,
                        UnitMass.nanograms,
                        UnitMass.picograms,
                        UnitMass.shortTons,
                        UnitMass.stones,
                        UnitMass.pounds,
                        UnitMass.ounces,
                        UnitMass.ouncesTroy,
                        UnitMass.slugs,
                        UnitMass.carats] as [Dimension]
                
            case .angle:
                return [UnitAngle.revolutions,
                        UnitAngle.degrees,
                        UnitAngle.radians,
                        UnitAngle.arcMinutes,
                        UnitAngle.arcSeconds] as [Dimension]
            
            case .speed:
                return [UnitSpeed.metersPerSecond,
                        UnitSpeed.kilometersPerHour,
                        UnitSpeed.milesPerHour,
                        UnitSpeed.knots] as [Dimension]
            
            case .duration:
                return [UnitDuration.hours,
                        UnitDuration.minutes,
                        UnitDuration.seconds,
                        UnitDuration.milliseconds,
                        UnitDuration.microseconds,
                        UnitDuration.nanoseconds,
                        UnitDuration.picoseconds] as [Dimension]
            
            case .energy:
                return [UnitEnergy.joules,
                        UnitEnergy.kilojoules,
                        UnitEnergy.calories,
                        UnitEnergy.kilocalories,
                        UnitEnergy.kilowattHours] as [Dimension]
            
            case .electricity:
            return [UnitElectricCurrent.megaamperes,
                    UnitElectricCurrent.kiloamperes,
                    UnitElectricCurrent.amperes,
                    UnitElectricCurrent.milliamperes,
                    UnitElectricCurrent.microamperes,
                    
                    UnitElectricPotentialDifference.megavolts,
                    UnitElectricPotentialDifference.kilovolts,
                    UnitElectricPotentialDifference.volts,
                    UnitElectricPotentialDifference.millivolts,
                    UnitElectricPotentialDifference.microvolts,
            
                    UnitElectricResistance.megaohms,
                    UnitElectricResistance.kiloohms,
                    UnitElectricResistance.ohms,
                    UnitElectricResistance.milliohms,
                    UnitElectricResistance.microohms] as [Dimension]
            
            case .Frequency:
                return [UnitFrequency.terahertz,
                        UnitFrequency.gigahertz,
                        UnitFrequency.megahertz,
                        UnitFrequency.kilohertz,
                        UnitFrequency.hertz,
                        UnitFrequency.millihertz,
                        UnitFrequency.microhertz,
                        UnitFrequency.nanohertz,
                        UnitFrequency.framesPerSecond] as [Dimension]
            
            case .STorage:
                return [UnitInformationStorage.yottabytes,
                        UnitInformationStorage.zettabytes,
                        UnitInformationStorage.petabytes,
                        UnitInformationStorage.terabytes,
                        UnitInformationStorage.gigabytes,
                        UnitInformationStorage.megabytes,
                        UnitInformationStorage.kilobytes,
                        UnitInformationStorage.bytes,
                        UnitInformationStorage.bits] as [Dimension]
        }
    }
}

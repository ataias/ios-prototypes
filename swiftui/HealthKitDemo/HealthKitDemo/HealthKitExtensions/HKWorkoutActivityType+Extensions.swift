//
//  HKWorkoutActivityType.swift
//  HealthKitDemo
//
//  Created by Ataias Pereira Reis on 01/01/21.
//

import HealthKit

extension HKWorkoutActivityType: CustomStringConvertible {
    public var description: String {
        switch self {

        case .americanFootball:
            return "american football"
        case .archery:
            return ".archery"
        case .australianFootball:
            return "australian football"
        case .badminton:
            return "badminton"
        case .baseball:
            return "baseball"
        case .basketball:
            return "basketball"
        case .bowling:
            return "bowling"
        case .boxing:
            return "boxing"
        case .climbing:
            return "climbing"
        case .cricket:
            return "cricket"
        case .crossTraining:
            return "cross training"
        case .curling:
            return "curling"
        case .cycling:
            return "cycling"
        case .dance:
            return "dance"
        case .danceInspiredTraining:
            return "dance inspired training"
        case .elliptical:
            return "elliptical"
        case .equestrianSports:
            return "equestrian sports"
        case .fencing:
            return "fencing"
        case .fishing:
            return "fishing"
        case .functionalStrengthTraining:
            return "functional strength training"
        case .golf:
            return "golf"
        case .gymnastics:
            return "gymnastics"
        case .handball:
            return "handball"
        case .hiking:
            return "hiking"
        case .hockey:
            return "hockey"
        case .hunting:
            return "hunting"
        case .lacrosse:
            return "lacrosse"
        case .martialArts:
            return "martial arts"
        case .mindAndBody:
            return "mind and body"
        case .mixedMetabolicCardioTraining:
            return "mixed metabolic cardio training"
        case .paddleSports:
            return "paddle sports"
        case .play:
            return "play"
        case .preparationAndRecovery:
            return "preparation and recovery"
        case .racquetball:
            return "racquetball"
        case .rowing:
            return "rowing"
        case .rugby:
            return "rugby"
        case .running:
            return "running"
        case .sailing:
            return "sailing"
        case .skatingSports:
            return "skating sports"
        case .snowSports:
            return "snow sports"
        case .soccer:
            return "soccer"
        case .softball:
            return "softball"
        case .squash:
            return "squash"
        case .stairClimbing:
            return "stair climbing"
        case .surfingSports:
            return "surfing sports"
        case .swimming:
            return "swimming"
        case .tableTennis:
            return "table tennis"
        case .tennis:
            return "tennis"
        case .trackAndField:
            return "track and field"
        case .traditionalStrengthTraining:
            return "traditional strength training"
        case .volleyball:
            return "volleyball"
        case .walking:
            return "walking"
        case .waterFitness:
            return "water fitness"
        case .waterPolo:
            return "water polo"
        case .waterSports:
            return "water sports"
        case .wrestling:
            return "wrestling"
        case .yoga:
            return "yoga"
        case .barre:
            return "barre"
        case .coreTraining:
            return "core training"
        case .crossCountrySkiing:
            return "cross country skiing"
        case .downhillSkiing:
            return "downhill skiing"
        case .flexibility:
            return "flexibility"
        case .highIntensityIntervalTraining:
            return "high intensity interval training"
        case .jumpRope:
            return "jump rope"
        case .kickboxing:
            return "kickboxing"
        case .pilates:
            return "pilates"
        case .snowboarding:
            return "snowboarding"
        case .stairs:
            return "stairs"
        case .stepTraining:
            return "step training"
        case .wheelchairWalkPace:
            return "wheelchair walk pace"
        case .wheelchairRunPace:
            return "wheelchair run pace"
        case .taiChi:
            return "tai chi"
        case .mixedCardio:
            return "mixed cardio"
        case .handCycling:
            return "hand cycling"
        case .discSports:
            return "disc sports"
        case .fitnessGaming:
            return "fitness gaming"
        case .cardioDance:
            return "cardio dance"
        case .socialDance:
            return "social dance"
        case .pickleball:
            return "pickleball"
        case .cooldown:
            return "cooldown"
        case .other:
            return "other"
        @unknown default:
            return "unknown"
        }
    }

}

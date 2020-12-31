//
//  LogIntentHandler.swift
//  NSUserActivity
//
//  Created by Ataias Pereira Reis on 30/12/20.
//

import Foundation
import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        guard intent is LogIntent else {
            fatalError("Unhandled Intent error : \(intent)")
        }
        return LogIntentHandler()
    }
}

class LogIntentHandler: NSObject, LogIntentHandling {
    func resolveMood(for intent: LogIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let mood = intent.mood else {
            completion(INStringResolutionResult.needsValue())
            return
        }

        completion(INStringResolutionResult.success(with: mood))
    }

    func confirm(intent: LogIntent,
                 completion: @escaping (LogIntentResponse) -> Void) {
        completion(LogIntentResponse(code: LogIntentResponseCode.ready,
                                     userActivity: nil))


    }

    func handle(intent: LogIntent,
                completion: @escaping (LogIntentResponse) -> Void) {
        //        guard let title = intent.article?.identifier,
        //              let article = ArticleManager.findArticle(with: title) else {
        //            completion(LogIntentResponse
        //                        .failure(failureReason: "Your article was not found."))
        //            return
        //        }
        //        guard !article.published else {
        //            completion(LogIntentResponse
        //                        .failure(failureReason: "This article has already been published."))
        //            return
        //        }
        //        ArticleManager.publish(article)
        print("Handling!!!")
        let mood = intent.mood ?? "Couldn't get mood"
        print(mood)
        completion(LogIntentResponse(code: LogIntentResponseCode.success, userActivity: nil))

    }
}


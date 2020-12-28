import Combine

//[1,2,3]
//.publisher
//.sink(receiveCompletion: { completion in
//  switch completion {
//  case .failure(let error):
//    print("Oops! Error: \(error)")
//  case .finished:
//    print("Completed")
//  }
//}, receiveValue: { value in
//  print("Value \(value)")
//})
//
//let subscription = ["a" : 1, "b" : 2]
//.publisher
//.map({$0.key})
//.sink(receiveCompletion: { completion in
//  switch completion {
//  case .failure(let error):
//    print("Oops! Error: \(error)")
//  case .finished:
//    print("Completed")
//  }
//}, receiveValue: { value in
//  print("Value \(value)") //prints a followed by b
//})

//let subject = PassthroughSubject<String, Never>()
//let publisher = Just("Just another value")
//publisher.subscribe(subject)
//subject.sink(receiveCompletion: { completion in
//  switch completion {
//  case .failure(let error):
//    print("Error: \(error)")
//  case .finished:
//    print("Completed")
//  }
//}, receiveValue: { value in
//  print("Value \(value)")
//})

enum SubjectError : Error{
    case unknown
}
//let subject = PassthroughSubject<String, SubjectError>()
//subject.sink(receiveCompletion: { completion in
//  switch completion {
//  case .failure(let error):
//    print("Error: \(error)")
//  case .finished:
//    print("Completed")
//  }
//}, receiveValue: { value in
//  print("Value \(value)")
//})
//
//subject.send("Manual")
//subject.send(completion: .failure(SubjectError.unknown))
//subject.send("This wont be received")

//var i = 1
//let future = Future<Int, Never> { promise in
//i = i + 1
//promise(.success(i))
//}
////prints 2 and finishes
//future.sink(receiveCompletion: { print($0) },
//receiveValue: { print($0) })
////prints 2 and finishes
//future.sink(receiveCompletion: { print($0) },
//receiveValue: { print($0) })

//import NotificationCenter
//
//extension Notification.Name {
//    static let myNotifier = Notification.Name("myNotifier")
//}
//let cancellable = NotificationCenter.default.publisher(for: .myNotifier, object: nil)
//    .compactMap { $0.object as? String }
//    .sink {print ($0)}
//NotificationCenter.default.post(name: .myNotifier, object: "Anupam")
//
//Double("2.5")

import NaturalLanguage

//let s = "I love cheese."
//let tagger = NLTagger(tagSchemes: [.sentimentScore])
//tagger.string = s
//let (sentiment,_) = tagger.tag(at: s.startIndex, unit: .sentence, scheme: .sentimentScore)
//
//if let sentiment = sentiment {
//    print(sentiment.rawValue)
//} else {
//    print("Fail")
//}

let input = "Hacking with Swift is awesome"

// feed it into the NaturalLanguage framework
let tagger = NLTagger(tagSchemes: [.sentimentScore])
tagger.string = input

// ask for the results
let (sentiment, _) = tagger.tag(at: input.startIndex, unit: .paragraph, scheme: .sentimentScore)

// read the sentiment back and print it
let score = Double(sentiment?.rawValue ?? "0") ?? 0
print(score)


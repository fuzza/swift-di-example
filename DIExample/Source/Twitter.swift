import Foundation

// sourcery: injectable
public class Tweeter {
  private let api: TwitterAPI
  private let name: String
  
  // sourcery: inject
  required public init(twitterApi:TwitterAPI, name: String) {
    self.api = twitterApi
    self.name = name
  }
  
  func tweet(_ tweet: String) {
    api.post(tweet: tweet, from: name)
  }
}

// sourcery: injectable
public class Timeline {
  private let api: TwitterAPI
  private let name: String
  
  // sourcery: inject
  required public init(twitterApi:TwitterAPI, name: String) {
    self.api = twitterApi
    self.name = name
  }
  
  func get() -> Array<String> {
    print("getting tweets")
    return ["first", "second", "third"]
  }
  
  func loadMore(_ count: Int) {
    print("loading \(count) more tweets")
  }
}

// sourcery: injectable
// sourcery: singleton
public class TwitterAPI {
  private let httpClient: HTTPClient
  
  // sourcery: inject
  required public init(httpClient: HTTPClient) {
    self.httpClient = httpClient
  }
  
  func post(tweet: String, from user: String) {
    httpClient.send([user: tweet])
  }
}

// sourcery: injectable
// sourcery: singleton
public class HTTPClient {
  func send(_ payload: Dictionary<String, String>) {
    print("sending \(payload)")
  }
}

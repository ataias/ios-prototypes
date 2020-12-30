import Foundation

let urlString = "https://swift.org/assets/images/swift.svg"

let url = URL(string: urlString)
if let url = url {
    print("URL\t\(url)")
    print("Scheme\t\(String(describing: url.scheme))")
    print("User\t\(String(describing: url.user))")
    print("Password\t\(String(describing: url.password))")
    print("Host\t\(String(describing: url.host))")
    print("Port\t\(String(describing: url.port))")
    print("Path\t\(String(describing: url.path))")
    print("Query\t\(String(describing: url.query))")
    print("Fragment\t\(String(describing: url.fragment))")
}


let baseUrlString = "https://swift.org"
var simpleURL = URL(string: baseUrlString)
simpleURL?.appendPathComponent("assets")
simpleURL?.appendPathComponent("images")

//simpleURL?.query = "mt=8"
simpleURL?.scheme
print("\(simpleURL!)")

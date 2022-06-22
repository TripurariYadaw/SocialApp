import Foundation

typealias Feeds = [Feed]

struct Feed: Codable {
	var user_name : String?
	var item_type : String?
	var data : String?
   
    init (user_name : String, item_type : String, data : String){
             self.user_name = user_name
             self.item_type = item_type
             self.data = data
    }
}

import Fluent

class Article: Model {
    ///The entities database identifier. `nil` when not saved yet.
    var id: String?

	let title: String
	let url: String

	init(title: String, url: String) {
		self.title = title
		self.url = url
	}


    ///The database table in which entities are stored.
    static var table: String = "articles"

    /**
        This method will be called when the entity is saved. 
        The keys of the dictionary are the column names
        in the database.
    */
    func serialize() -> [String: String] {
    	return [
    		"id": self.id ?? "NULL",
    		"title": self.title,
    		"url": self.url
    	]
    }

    required init(serialized: [String: String]) {
    	self.id = serialized["id"]
    	self.title = serialized["title"] ?? ""
    	self.url = serialized["url"] ?? ""
    }
}

extension Model {

    static var all: [Self] {
        return Query().results
    }

}
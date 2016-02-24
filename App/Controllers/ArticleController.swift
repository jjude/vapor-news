import Vapor
import Fluent

class ArticleController: Controller {

    enum Error: ErrorType {
        case ArticleNotFound
    }

	/// List all resources
	func index(request: Request) throws -> ResponseConvertible {
        let articles = Article.all.map { article in
            return article.serialize()
        }

        return try View(path: "index.stencil", context: [
            "articles": articles
        ])
	}

	/// Create a new instance.
    func store(request: Request) throws -> ResponseConvertible {
        guard let url = request.data["url"]?.string else {
            return "Please submit a URL"
        }

        let article = Article(title: "New Article", url: url)
        article.save()

        return [
            "message": "Article saved"
        ]
    }

    /// Show an instance.
    func show(request: Request) throws -> ResponseConvertible {
        guard let idString = request.parameters["id"] else {
            throw Error.ArticleNotFound
        }

        guard let id = Int(idString) else {
            throw Error.ArticleNotFound
        }

        guard let article = Article.find(id) else {
            throw Error.ArticleNotFound
        }

        return try View(path: "article.stencil", context: [
            "article": article.serialize()
        ])
    }

    func create(request: Request) throws -> ResponseConvertible {
        return try View(path: "form.stencil")
    }

    /// Update an instance.
    func update(request: Request) throws -> ResponseConvertible {
        return ""
    }

    /// Delete an instance.
    func destroy(request: Request) throws -> ResponseConvertible {
        return ""
    }

}

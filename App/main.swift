import Vapor
import VaporStencil

import Fluent
import FluentSQLite

//create table articles(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, url STRING)
Database.driver = SQLiteDriver()

let app = Application()

app.get("/", handler: ArticleController().index)
app.resource("articles", controller: ArticleController())
app.get("articles/create", handler: ArticleController().create)

app.providers.append(VaporStencil.Provider) // Adds support for stencil rendering for all .stencil views)

app.start(port: 8080)

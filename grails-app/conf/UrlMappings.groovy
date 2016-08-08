class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

<<<<<<< HEAD
        "/"(controller: "admin",action: "index")
=======
        "/"(view:"/index")
>>>>>>> 10b34aa56a736e858adc041c0fab9e2f59203591
        "500"(view:'/error')
	}
}

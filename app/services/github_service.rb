class GithubService

      #resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: 'Iv1.9e2102dc932faf05', client_secret: #'e9e95e7a03feef361c1b117e439bc604ea0cc7ff', code: params[:code]}, {'Accept' => 'application/json'}

    def repositories
      binding.pry
      #obj = {}

      #935ac2d8b02b4f20971f9048540ca2ba636e0ea5
      #binding.pry
      #redirect = CGI.escape("http://localhost:3000/api/github")
      #response1 = Faraday.get 'https://github.com/login/oauth/authorize', {client_id: 'Iv1.9e2102dc932faf05', redirect_uri: redirect}
      #response = Faraday.post("https://api.github.com/repos/omikolaj/hello-world/issues") do |req|        
        #req.params['oauth_token'] = session[:token]
        #req.params["Accept"] = 'application/json'
        #req.body = {:title => "maybe"}.to_json
      #end
      #@repos_array = JSON.parse(response.body)
      
      #response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      #@repos_array = JSON.parse(response.body)

      #redirect_to "https://github.com/login/oauth/authorize?client_id=Iv1.9e2102dc932faf05&scope=repo"
    end

    def submit_issue(token, params)
      response = Faraday.post("https://api.github.com/repos/omikolaj/hello-world/issues") do |req|        
        req.params['oauth_token'] = token
        req.params["Accept"] = 'application/json'
        req.body = params.to_json
      end
      JSON.parse(response.body)
    end

    def issues(token)
      binding.pry
      response = Faraday.get("https://api.github.com/repos/omikolaj/hello-world/issues") do |req|
        #req.params['oauth_token'] = token
        req.params['Accept'] = 'application/json'
        req.params["state"] = "closed"
        binding.pry
        req.params["sort"] = "created"
      end
      binding.pry
      JSON.parse(response.body)
    end
    
    
    private
    def check_token
      
    end
          
end
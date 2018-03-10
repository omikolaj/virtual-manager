class GithubService     

    def authenticate!(client_id, client_secret, code)
      response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
        req.params["client_id"] = client_id
        req.params["client_secret"] = client_secret
        req.params["code"] = code
        req.headers['Accept'] = 'application/json'
      end     
        JSON.parse(response.body)["access_token"]
    end

    def submit_issue(token, params)
      response = Faraday.post("https://api.github.com/repos/omikolaj/hello-world/issues") do |req|        
        req.params['oauth_token'] = token
        req.params["Accept"] = 'application/json'
        req.body = params.to_json
      end
      response
    end         
end
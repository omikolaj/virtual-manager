class GithubService
  
    def repositories
      response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      @repos_array = JSON.parse(response.body)
    end
end
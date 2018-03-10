class GithubController < ApplicationController
        
    def developer
    end

    def create_issue
      github = GithubService.new
      @issue = github.submit_issue(session[:token], github_params)
      if !valid_response?(@issue.status)
        flash[:notice] = "You must provide the title"        
      else        
        flash[:notice] = "You have successfully created an issue!"
      end
      redirect_to developer_path
    end
    
    private
    def github_params
       params.require(:github).permit(:title, :body)
    end

    def valid_response?(status)
      status == 200 || status == 201 || status == 204 ? true : false
    end
end
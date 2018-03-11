class GithubController < ApplicationController
  before_action :authenticate_for_api, only:[:fork, :create_issue, :developer]
        
    def developer
    end

    def create_issue
      github = GithubService.new
      @issue = github.submit_issue(session[:token], github_params)
      if !valid_response?(@issue.status)
        flash[:notice] = "Something went wrong...Did you provide a title?"        
      else        
        flash[:notice] = "You have successfully created an issue!"
      end
      redirect_to developer_path
    end

    def fork
      github = GithubService.new
      @fork = github.fork(session[:token])
      if @fork["fork"] 
        flash[:notice] = "You have successfully forked this repo!"
      else
        flash[:notice] = "Something went wrong..."
      end
      redirect_to developer_path
    end
    
    private
    def github_params
       params.require(:github).permit(:title, :body)
    end

    def valid_response?(status)
      status.to_s.include?('20') ? true : false
    end
end
class GithubController < ApplicationController

        
    def developer
    end

    def repositories

    end

    def fork
      github = GithubService.new
      @fork = github.fork(session[:token])      
      render json: @fork, status: 200
    end

    def issues
      github = GithubService.new
      @issues = github.issues(session[:token])
      render json: @issues, status: 200
    end

    def create_issue
      github = GithubService.new
      @issue = github.submit_issue(session[:token], github_params)
      render json: @issue, status: 200
    end

    def webhooks

    end

    private
    def github_params
       params.require(:github).permit(:title, :body)
    end


end
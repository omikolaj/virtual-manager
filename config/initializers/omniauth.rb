Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY1'], ENV['GITHUB_SECRET1'], scope: 'repo'
end

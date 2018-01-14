Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, '50bf69ec71baa84abac1', '2d43ed195e54dc181d291f71de15a7a75f614a58'
end
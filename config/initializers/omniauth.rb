Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, '70457577d1b0f9870e6f', 'cf2ee11fa9c1f8809bdda9c7add37928279335d4'
end

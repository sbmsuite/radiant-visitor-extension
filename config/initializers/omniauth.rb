ActionController::Dispatcher.middleware.use OmniAuth::Builder do
  provider :facebook, '406699449374326', '7250c7f980a76ac5ff01afa4cfa38fa2'
  provider :twitter, "hURYiEmxJIfJpD2MZApVQ", "KZGJrDR75vidpHTx5uuk4nCuw4MPwMG43e1D7td89Cg"
end
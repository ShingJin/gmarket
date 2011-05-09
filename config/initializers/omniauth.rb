Rails.application.config.middleware.use OmniAuth::Builder do  
	 provider :facebook	, '154290874631361', 'e76ef2433a59b01bbec53bf0012b4cc1',:scope => 'publish_stream,user_likes,friends_likes,email,offline_access'
end  
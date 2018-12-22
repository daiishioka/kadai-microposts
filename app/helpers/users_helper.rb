module UsersHelper
	def gravatar_url(user, options = { size: 80})		#メールアドレスに対して自分のアバター画像を登録するもの
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		"https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	end
end

module EmceesHelper
    def gravatar_for(emcee)
        gravatar_id  = Digest::MD5::hexdigest(emcee.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: emcee.name, class: "gravatar")
      end
end

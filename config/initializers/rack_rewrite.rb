Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  r301 "/association_descriptif.php", "/association"
  r301 "/search.php", "/search"
  r301 "/stickers.php", "/stickers"
  r301 "/press.php", "/press"
  r301 "/faq.php", "/faq"
  r301 "/contact.php", "/contact"
  r301 "/term.php", "/terms"
end

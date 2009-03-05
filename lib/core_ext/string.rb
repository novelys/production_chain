require 'unicode' unless defined?(Rails) && Rails.version >= "2.2.2"

class String
  def to_slug
    return parameterize if defined?(Rails) && Rails.version >= "2.2.2"
    str = Unicode.normalize_KD(self).gsub(/[^\x00-\x7F]/n,'')
    str = str.gsub(/\W+/, '-').gsub(/^-+/,'').gsub(/-+$/,'').downcase
  end

  def to_simple_format
    self.gsub("</p>", "\n\n").gsub("<br />", "\n")
  end
end

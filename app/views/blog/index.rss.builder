xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0", 'xmlns:content' => "http://purl.org/rss/1.0/modules/content/" do
  xml.channel do
    xml.title "{ Simplic.IT } - Blog"
    xml.description "Thoughts on webdevelopment and security"
    xml.link "http://simplic.it/blog"

    for post in @blogs
      xml.item do
        title = post.title
        unless post.subtitle and post.subtitle.empty?
          title += " -- #{post.subtitle}"
        end
        
        xml.title do
          xml.cdata! title
        end

        xml.description do
          xml.cdata!(excerpt(post))
        end
        xml.tag!("content:encoded") do
          xml.cdata!(contents(post))
        end

        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link url(post)
      end
    end
  end
end

module Jekyll
  # Defines the base class of AMP posts
  class AmpPost < Page
    def initialize(site, base, dir, post, amp_root_dir)
      @site = site
      @base = base
      @dir = dir
      # Needed for posts with permalink
      @url ||= URL.new({
        :template     => File.join(amp_root_dir, post.url_template),
        :placeholders => post.url_placeholders
      }).to_s
      @name = post.basename
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'amp.html')
      self.content               = post.content
      self.data['body']          = (Liquid::Template.parse post.content).render site.site_payload

      # Merge all data from post so that keys from self.data have higher priority
      self.data = post.data.merge(self.data)

      # Remove non needed keys from data
      # Excerpt will cause an error if kept
      self.data.delete('excerpt')
      # Generating the page fails silently if page has a permalink and it is copied
      # over to the AMP version
      self.data.delete('permalink')

      self.data['canonical_url'] = post.url
    end
  end
  # Generates a new AMP post for each existing post
  class AmpGenerator < Generator
    priority :low
    def generate(site)
      dir = site.config['ampdir'] || 'amp'
      site.posts.docs.each do |post|
        next if post.data['skip_amp'] == true
        site.pages << AmpPost.new(site, site.source, File.join(dir, post.id), post, dir)
      end
    end
  end
end

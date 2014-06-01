Encoding.default_external = Encoding::UTF_8
require 'json'
require 'pry'

###
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
require 'susy'


# Change Compass configuration
compass_config do |config|
  config.output_style = :compressed
end

ignore 'layout_simple.erb'

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
# page "/this-page-has-no-template.html", :proxy => "/template-file.html" do
#   @which_fake_page = "Rendering a fake page with a variable"
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  def main_nav_link(title, url)
    page_section = current_page.data.section || ''
    link_class = ''
    in_url = false

    unless page_section == ''
      target_page = sitemap.find_resource_by_destination_path url
      root_part = target_page.destination_path.split("/")[0]
      in_url = root_part.match(page_section)
    end

    link_class = 'active' if in_url
    nav_link = link_to title, url, :class => link_class
  end

  def nav_link_to(title, url)
    page = current_page
    target_page = sitemap.find_resource_by_destination_path url
    page_url = current_page.destination_path
    page_section = page.data.section || ''
    link_class = ''

    return title if target_page.nil?

    if page_url == target_page.destination_path
      is_active = true
    end

    link_class = 'active' if is_active
    nav_link = link_to title, url, :class => link_class
  end
end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher

  # Or use a different image path
  # set :http_path, "/Content/images/"
end
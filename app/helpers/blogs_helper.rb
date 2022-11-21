# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    blog.content.split.map { |text| ''.html_safe + text + '<br>'.html_safe }.join.html_safe
  end
end

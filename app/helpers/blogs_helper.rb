# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    safe_join(blog.content.split.map { |text| ''.html_safe + text + '<br>'.html_safe })
  end
end

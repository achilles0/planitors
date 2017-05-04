module ApplicationHelper
  # This is actually safe even though it uses .html_safe, because it manually escapes html with the h()-helper
  def trunc text, length: 30
    return '' if text.blank?
    result = ''
    result << %(<span data-tooltip="#{h(text)}">) if text.length > length
    result << h(text.truncate(length))
    result << "</span>" if text.length > length
    result.html_safe
  end
end

class FileInput < SimpleForm::Inputs::Base
  def input
    input_html_options[:style] = 'display:none;'
    "#{@builder.file_field(attribute_name, input_html_options)}" \
    "<div class=\"input-append\">" \
      "<input disabled=\"disabled\" type=\"text\">" \
      "<button type=\"button\" class=\"btn b_file\">Select file</button>" \
    "</div>"
  end
end
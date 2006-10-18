# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def fckeditor_text_field(object, method, options = {})
    text_area(object, method, options ) +
    javascript_tag( "var oFCKeditor = new FCKeditor('" + object + "[" + method + "]');oFCKeditor.ToolbarSet = 'TukiaSane';oFCKeditor.ReplaceTextarea()" )
  end
  
  def tukia_version
     # many thanks to zardinuk on #rubyonrails for this little trick!
     doc = REXML::Document.new(File.new(RAILS_ROOT + '/.svn/entries'))
     doc.root.elements.each('entry[@name=""]') do |e|
       return "0.1." + e.attribute('revision').to_s
     end
  end
  
  def leading_zeroes(anumber,minsigdigits)
    stringoutput = anumber.to_s
    minsigdigits.downto(1) { |count|
      stringoutput = "0" + stringoutput if anumber < (10 ** (count - 1))
    }
    stringoutput
  end
  
  # template_name must be trusted
  def run_template(template_name, terms)
    erb_template = File.read(RAILS_ROOT + "/app/views/report_templates/" + template_name + ".rhtml")
    rhtml = ERB.new(erb_template)
    return rhtml.run(binding())
  end

end

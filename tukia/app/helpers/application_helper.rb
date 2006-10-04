# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def fckeditor_text_field(object, method, options = {})
    text_area(object, method, options ) +
    javascript_tag( "var oFCKeditor = new FCKeditor('" + object + "[" + method + "]');oFCKeditor.ToolbarSet = 'TukiaSane';oFCKeditor.ReplaceTextarea()" )
  end
  
  def tukia_version
    "1.0"
  end
  
  def leading_zeroes(anumber,minsigdigits)
    stringoutput = anumber.to_s
    minsigdigits.downto(1) { |count|
      stringoutput = "0" + stringoutput if anumber < (10 ** (count - 1))
    }
    stringoutput
  end
  
end

# XmlHidden
module XmlHidden
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def attr_xml_hidden(*attributes)
      write_inheritable_attribute("attr_xml_hidden", Set.new(attributes.map(&:to_s)) + (xml_hidden_attributes || []))
    end

    # Returns an array of all the attributes that have been hidden from xml output
    def xml_hidden_attributes # :nodoc:
      read_inheritable_attribute("attr_xml_hidden")
    end
  end
end
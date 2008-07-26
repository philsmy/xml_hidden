ActiveRecord::Base.send :include, XmlHidden

module ActiveRecord::Serialization
  class Serializer
    def serializable_attribute_names
      attribute_names = @record.attribute_names
      attribute_names = attribute_names.reject{|a| @record.class.xml_hidden_attributes.include?(a)} if self.class.to_s.downcase[/xml/]

      if options[:only]
        options.delete(:except)
        attribute_names = attribute_names & Array(options[:only]).collect { |n| n.to_s }
      else
        options[:except] = Array(options[:except]) | Array(@record.class.inheritance_column)
        attribute_names = attribute_names - options[:except].collect { |n| n.to_s }
      end

      attribute_names
    end
  end
end
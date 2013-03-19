module Acfs

  # == Acfs Attribute
  #
  # Allows to specify attributes of a class with default values and type safety.
  #
  #   class User
  #     include Acfs::Attributes
  #
  #     attribute :name, :string, default: 'Anon'
  #     attribute :age, :integer
  #     attribute :special, My::Special::Type
  #   end
  #
  # For each attribute a setter and getter will be created and values will be
  # type casted when set.
  #
  module Attributes
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    module InstanceMethods # :nodoc:

      # Returns ActiveModel compatible list of attributes and values.
      #
      #   class User
      #     attribute :name, type: String, default: 'Anon'
      #   end
      #   user = User.new(name: 'John')
      #   user.attributes # => { "name" => "John" }
      #
      def attributes
        @attributes ||= self.class.attributes.stringify_keys
      end
    end

    module ClassMethods # :nodoc:

      # Define a model attribute by name and type. Will create getter and
      # setter for given attribute name. Existing methods will be overridden.
      #
      #   class User
      #     attribute :name, type: String, default: 'Anon'
      #   end
      #
      # Available types can be found in `Acfs::Attributes::*`.
      #
      def attribute(*attrs)
        opts = attrs.extract_options!
        type = opts.delete(:type) || :string

        if type.is_a? Symbol or type.is_a? String
          type = "::Acfs::Attributes::#{type.to_s.classify}".constantize
        end

        attrs.each do |attr|
          define_attribute attr.to_sym, type, opts
        end
      end

      # Return list of possible attributes and default values for this model class.
      #
      #   class User
      #     attribute :name, String
      #     attribute :age, Integer, default: 25
      #   end
      #   User.attributes # => { "name": nil, "age": 25 }
      #
      def attributes
        @attributes ||= {}
      end


      private
      def define_attribute(name, type, opts = {}) # :nodoc:
        @attributes ||= {}
        @attributes[name] = type.cast opts.has_key?(:default) ? opts[:default] : nil

        self.send :define_method, name do
          attributes[name.to_s]
        end

        self.send :define_method, :"#{name}=" do |value|
          attributes[name.to_s] = type.cast value
        end
      end
    end
  end
end

# Load attribute type classes.
#
Dir[File.dirname(__FILE__) + "/attributes/*.rb"].sort.each do |path|
  filename = File.basename(path)
  require "acfs/attributes/#{filename}"
end

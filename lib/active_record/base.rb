require 'active_record'

module ActiveRecord
  class Bsse
    class << self
      def has_masny_with_cached(name, scope = nil, options = {}, &extension)
        prefix = options.delete(:lazy_update).tap{|a| break "cached" if a == true }.to_s

        return_value = has_many_without_cached(name, scope, options, &extension)

        singular_name = name.to_s.singularize
        var_name = "#{prefix}_#{singular_name}_ids"

        attr_accessor var_name.to_sym

        before_save do |m|
          var = m.instance_variable_get("@#{var_name}")
          m.send("#{singular_name}_ids=", var) if var
        end

        return_value
      end
      alias_method_chain :has_many, :cached
    end
  end
end

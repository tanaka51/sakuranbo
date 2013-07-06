require 'active_record'

class ActiveRecord::Base
  class << self
    def has_many_with_cached(name, scope = nil, options = {}, &extension)
      prefix = scope.is_a?(Proc) ? options.try(:delete, :lazy_update) : scope.try(:delete, :lazy_update)
      v = has_many_without_cached(name, scope, options, &extension)
      return v unless prefix # not specify lazy_update

      prefix = "cached" if prefix == true
      singular_name = name.to_s.singularize
      var_name = "#{prefix}_#{singular_name}_ids"

      attr_accessor var_name.to_sym

      before_save do |m|
        var = m.instance_variable_get("@#{var_name}")
        m.send("#{singular_name}_ids=", var) if var
      end

      v
    end
    alias_method_chain :has_many, :cached
  end
end

# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
end

work_around_habtm_bug = true
if work_around_habtm_bug
  module ActiveRecord
    module Associations
      module ClassMethods
        def add_multiple_associated_save_callbacks(association_name)
          method_name = "validate_associated_records_for_#{association_name}".to_sym
          define_method(method_name) do
            association = instance_variable_get("@#{association_name}")
            if association.respond_to?(:loaded?)
              if new_record?
                association
              else
                association.select { |record| record.new_record? }
              end.each do |record|
                errors.add "#{association_name}" unless record.valid?
              end
            end
          end

          validate method_name
          before_save("@new_record_before_save = new_record?; true")
        
          after_callback = <<-end_eval
            association = instance_variable_get("@#{association_name}")
            if association.respond_to?(:loaded?)
              if @new_record_before_save
                records_to_save = association
              else
                records_to_save = association.select { |record| record.new_record? }
              end
              records_to_save.each { |record| association.send(:insert_record, record) }
              association.send(:construct_sql)   # reconstruct the SQL queries now that we know the owner's id
            end
          end_eval

          # Doesn't use after_save as that would save associations added in after_create/after_update twice
          after_create(after_callback)
          after_update(after_callback)
        end
      end
    end
  end
end
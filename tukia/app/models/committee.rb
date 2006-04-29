class Committee < ActiveRecord::Base
  acts_as_tree
  translates :name
  has_and_belongs_to_many :editors, :class_name => "Person", :join_table => "committees_editors"
  has_and_belongs_to_many :members, :class_name => "Nation"
  has_and_belongs_to_many :convenors, :class_name => "Person", :join_table => "committees_convenors"
  has_many :documents
  attr_protected :created_at, :updated_at
  validates_presence_of :name

  def get_full_name
    result = ""
    parents = get_parents_recurse([])
    parents.each {|a| result += a.name + " "}
    result
  end
  
  def suggest_new_register_number
    result = Document.find(:first, :conditions => ["committee_id = ?", self.id], :order => "register_number ASC")
    if result.nil?
      # lol first ps0t!
      return 1
    end
    return result.register_number + 1
  end

  private
  def get_parents_recurse(pile)
    if (!parent.nil?)
      if (parent == self)
        raise "Recursive parent relationship!"
      end
      parent.get_parents_recurse(pile)
    end
    pile << self
  end
end

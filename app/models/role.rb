class Role < ApplicationRecord
  has_and_belongs_to_many :clients, :join_table => :clients_roles


  belongs_to :resource,
             :polymorphic => true,
             :optional => true


  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  ROLES = {
            admin:  "admin",
            client: "client"
          }
end

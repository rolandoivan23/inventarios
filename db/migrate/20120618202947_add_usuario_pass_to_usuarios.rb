class AddUsuarioPassToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :usuario_pass, :string
  end

  def self.down
    remove_column :usuarios, :usuario_pass
  end
end

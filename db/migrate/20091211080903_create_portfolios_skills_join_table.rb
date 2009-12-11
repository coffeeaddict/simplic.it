class CreatePortfoliosSkillsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :portfolios_skills, :id => false do |t|
      t.integer :portfolio_id
      t.integer :skill_id
    end
  end

  def self.down
    drop table :portfolios_skills
  end
end

class CreateFigureTitles < ActiveRecord::Migration
  def change
    create_table :figure_titles do |t|
      t.references :title
      t.references :figure
    end
  end
end

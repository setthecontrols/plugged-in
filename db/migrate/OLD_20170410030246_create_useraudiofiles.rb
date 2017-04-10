class CreateUserAudioFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :useraudiofiles do |t|
      t.attachment :media
      t.references :user


      t.timestamps
    end
  end
end

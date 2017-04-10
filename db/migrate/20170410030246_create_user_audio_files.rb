class CreateUserAudioFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_audio_files do |t|
      t.attachment :audio_file
      t.references :user


      t.timestamps
    end
  end
end

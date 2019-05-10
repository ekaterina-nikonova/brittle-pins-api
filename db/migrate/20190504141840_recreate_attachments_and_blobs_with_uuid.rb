class RecreateAttachmentsAndBlobsWithUuid < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs, id: :uuid, default: -> { "gen_random_uuid() "}, force: :cascade do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [ :key ], unique: true
    end

    create_table :active_storage_attachments, id: :uuid, default: -> { "gen_random_uuid() "}, force: :cascade do |t|
      t.string     :name,     null: false

      # See https://www.wrburgess.com/posts/2018-02-03-1.html
      t.uuid :record_id, null: false     # replaces t.references :record
      t.string :record_type, null: false # replaces t.references :record
      t.uuid :blob_id,     null: false   # replaces t.references :blob

      # t.references :record,   null: false, polymorphic: true, index: false
      # t.references :blob,     null: false

      t.datetime :created_at, null: false

      t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
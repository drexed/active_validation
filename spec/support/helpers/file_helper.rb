# frozen_string_literal: true

module FileHelper

  def csv_upload(file_name)
    opts = { tempfile: tempfile(:csv, file_name), filename: file_name }
    ActionDispatch::Http::UploadedFile.new(opts)
  end

  def img_upload(file_name)
    opts = { tempfile: tempfile(:img, file_name), filename: file_name }
    ActionDispatch::Http::UploadedFile.new(opts)
  end

  def txt_upload(file_name)
    opts = { tempfile: tempfile(:txt, file_name), filename: file_name }
    ActionDispatch::Http::UploadedFile.new(opts)
  end

  private

  def tempfile(file_directory, file_name)
    path = File.expand_path("../spec/support/#{file_directory}", file_name)
    path = File.join(path, file_name)
    File.open(path)
  end

end

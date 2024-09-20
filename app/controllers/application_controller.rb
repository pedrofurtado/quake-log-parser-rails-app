class ApplicationController < ActionController::API
  def quake_log_parse
    file_path = params[:quake_file].present? ? params[:quake_file].tempfile.path : nil

    if file_path.blank?
      render json: { error: 'No quake file uploaded' }, status: :bad_request
      return
    end

    QuakeLogParser::Logger.logger = Rails.logger

    parser = QuakeLogParser::LogReader.new(file_path)
    parser.read

    render json: parser.results
  end
end

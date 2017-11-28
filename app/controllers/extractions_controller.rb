# frozen_string_literal: true

class ExtractionsController < ApplicationController
  before_action :missing_data, only: :edit
  before_action :format_target_languages, only: :edit
  before_action :add_errors, only: :edit

  def index; end

  def edit
    @datas = session[:data]
    @profile = Profile.new
  end

  def show; end

  def create
    @profile = Profile.new profile_params.merge target_languages: session[:target].map(&:capitalize)
    if @profile.valid?
      clear_session_data
      @profile.save!
      flash[:success] = 'Profile data added'
      redirect_to root_path
    else
      handle_profile_errors!
      redirect_back(fallback_location: root_path)
    end
  end

  def get
    if valid_url?
      session[:data] = Proz::Parser.new(profile_url).extract.attributes_for_json
      redirect_to extractions_edit_path
    else
      flash[:error] = 'Profile URL format is not correct'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def profile_params
    params.require(:profile).permit(allowed_profile_params)
  end

  def handle_profile_errors!
    flash[:error] = "Profile already stored" if @profile.errors.key?(:source)
    session[:errors] = @profile.errors.messages
  end

  def allowed_profile_params
    %i[first_name last_name country source native_language]
  end

  def add_errors
    @errors ||= session[:errors]
    session.delete :errors
  end

  def missing_data
    redirect_back(fallback_location: root_path) unless session['data']
  end

  def format_target_languages
    unless session['data']['target_language'].is_a?(Array)
      session['data']['target_language'] = JSON.parse(session['data']['target_language'])
    end
  end

  def clear_session_data
    session[:target] = session['data']['target_language'].map(&:downcase.to_sym)
    session.delete(:data)
  end

  def profile_url
    @profile_url ||= params.permit(:url)[:url]
  end

  def valid_url?
    return true if profile_url.match?(profile_url_mask)
  end

  def profile_url_mask
    @profile_url_mask ||= %r[^(http|https):\/\/www.proz.com\/.+\/\d{1,10}$]
  end
end

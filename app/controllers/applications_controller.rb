class ApplicationsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        applications = Application.select([:name, :token]).all   
        render json: {status: "SUCCESS",body: applications},status: :ok
    end   

    def show
        application = Application.where(token: params[:token]).select([:name, :token]).first
        if !application.blank?
            render json: {status: "SUCCESS",body: application},status: :ok
        else
            render json: {status: "Error",error_message: "Application_Not_Found"},status: :ok
        end

    end

    # POST /application
    def create
        applicationToCreate = Application.new(application_params)
        applicationToCreate.token = SecureRandom.uuid
        if applicationToCreate.save
            render json: {status: "SUCCESS",applicationToken: applicationToCreate.token},status: :created
        else
            render json: {status: "ERROR",error_message: applicationToCreate.errors},status: :unprocessable_entity
        end
    end

    def update
        application = Application.where(token: params[:token]).first
        if application.update_attributes(application_params)
            render json: {status: "SUCCESS"},status: :ok
        else
            render json: {status: "ERROR",error_message: application.errors},status: :unprocessable_entity
        end
    end

    private
    def application_params
        params.permit(:name)
    end
    
end
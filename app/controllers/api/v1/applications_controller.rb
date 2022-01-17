module Api
    module V1
        class ApplicationsController < ApplicationController

            skip_before_action :verify_authenticity_token

            def index
                applications = Application.all   
                render json: {status: "SUCCESS",body: applications},status: :ok
            end   
        
            def show
                application = Application.find(params[:id])
                render json: {status: "SUCCESS",body: application},status: :ok
            end

            # POST /application
            def create
                applicationToCreate = Application.new(application_params)
                if applicationToCreate.save
                    render json: {status: "SUCCESS",body: applicationToCreate},status: :created
                else
                    render json: {status: "ERROR",error_message: applicationToCreate.errors},status: :unprocessable_entity
                end
            end

            # POST /application
            def update
                application = Application.find(params[:id])
                if application.update_attributes(application_params)
                    render json: {status: "SUCCESS",body: application},status: :created
                else
                    render json: {status: "ERROR",error_message: application.errors},status: :unprocessable_entity
                end
            end



            private
            def application_params
                params.permit(:name)
            end
            
        end    
    end

end
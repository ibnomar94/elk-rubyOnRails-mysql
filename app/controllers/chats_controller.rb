class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
        application = Application.where(token: params[:token]).first
        if !application.blank?
            chats = Chat.where(application_id: application.id).select([:number, :message_count]).all   
            render json: {status: "SUCCESS",body: chats},status: :ok
        else
            render json: {status: "Error",error_message: "Application_Not_Found"},status: :bad_request
        end

        
    end   

    def show
        application = Application.where(token: params[:token]).first
        if !application.blank?
            chat = Chat.where(application_id: application.id,number: params[:chatnumber]).select([:number, :message_count]).first   
            if !chat.blank?
                render json: {status: "SUCCESS",body: chat},status: :ok
            else
                render json: {status: "Error",error_message: "Chat_Not_Found"},status: :ok
            end
        else
            render json: {status: "Error",error_message: "Application_Not_Found"},status: :bad_request
        end
    end

    # POST /chat
    def create
        application = Application.where(token: params[:token]).first
        if !application.blank?
            chatToCreate = Chat.new()
            maxChatNumberInApplication = Chat.where(application_id: application.id).maximum("number")
            currentChatNumber = 1 
            if !maxChatNumberInApplication.nil?
                currentChatNumber = maxChatNumberInApplication + 1
            end
            
            chatToCreate.application_id = application.id
            chatToCreate.number = currentChatNumber
            if chatToCreate.save
                application.chats_count += 1
                application.save
                render json: {status: "SUCCESS",chatNumber: chatToCreate.number},status: :created
            else
                render json: {status: "ERROR",error_message: chatToCreate.errors},status: :unprocessable_entity
            end
        else
            render json: {status: "Error",error_message: "Application_Not_Found"},status: :bad_request
        end    
    end
    
end